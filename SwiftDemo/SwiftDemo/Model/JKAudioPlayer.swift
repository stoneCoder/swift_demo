//
//  JKAudioManager.swift
//  SwiftDemo
//
//  Created by 张磊 on 2020/10/25.
//  Copyright © 2020 sinosun. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation

fileprivate func audioQueueOutputCallback(inUserData: UnsafeMutableRawPointer?, inQueue: AudioQueueRef, inBuffer: AudioQueueBufferRef) {
    if let player = inUserData?.assumingMemoryBound(to: JKPlayerState.self) {
        var bufferLength:UInt32 = player.pointee.bufferByteSize
        var numPkgs:UInt32 = kNumberPackages
        if AudioFileReadPacketData(player.pointee.mAudioFile!, false, &bufferLength, player.pointee.mPacketDescs, player.pointee.mCurrentPacket, &numPkgs, inBuffer.pointee.mAudioData) == noErr {
            inBuffer.pointee.mAudioDataByteSize = bufferLength
        }
        AudioQueueEnqueueBuffer(player.pointee.mQueue!,inBuffer,numPkgs,player.pointee.mPacketDescs)
        player.pointee.mCurrentPacket += Int64(numPkgs)

        if numPkgs == 0 {
            print("play finished")
            AudioQueueStop(player.pointee.mQueue!, false)
        }
    }
}

fileprivate struct JKPlayerState {
    var mDataFormat:AudioStreamBasicDescription? //音频流描述对象
    var mAudioFile:AudioFileID? //播放音频文件ID
    var mBuffers: [AudioQueueBufferRef] = []
    var mQueue:AudioQueueRef?
    var bufferByteSize: UInt32 = 0
    var mCurrentPacket: Int64 = 0
    var mPacketDescs:UnsafeMutablePointer<AudioStreamPacketDescription>?//对于VBR音频数据,表示正在播放的音频数据包描述性数组,对于CBR音频数据可以设为NULL
    var mNumPacketsToRead:UInt32?  //每次调用回调函数要读取的音频数据包的个数
}

fileprivate let kNumberBuffers: UInt32 = 3
fileprivate let kNumberPackages: UInt32 = 100

class JKAudioPlayer: NSObject {
    
    fileprivate var audioFileUrl: URL
    fileprivate var playerState:JKPlayerState = JKPlayerState()
    var playing:Bool = false
    
    deinit {
        if let audio = playerState.mAudioFile {
            AudioFileClose(audio)
            playerState.mAudioFile = nil
         }

        if let queue = playerState.mQueue {
            AudioQueueDispose(queue, true)
            playerState.mQueue = nil
        }

        if playerState.mPacketDescs != nil {
            playerState.mPacketDescs = nil
        }
    }
    
    init?(url: URL) {
        audioFileUrl = url
        do {
              try AVAudioSession.sharedInstance().setActive(true)
        } catch {
              return nil
        }
        //打开文件
        var audioFile: AudioFileID?
        if(AudioFileOpenURL(url as CFURL, AudioFilePermissions.readPermission, 0, &audioFile) == noErr){
            playerState.mAudioFile = audioFile
        }else{
            return nil
        }
        /*let audioAsset = AVURLAsset.init(url: url, options: nil)
        let audioDuration = audioAsset.duration
        let audioDurationSeconds = CMTimeGetSeconds(audioDuration);
        print("获取音频文件长---------->\(audioDurationSeconds)")*/
        //获取音频文件信息
        /*var dic:NSDictionary?
        var piDataSize:UInt32 = UInt32(MemoryLayout.size(ofValue: dic));
        err = AudioFileGetProperty(playerState.mAudioFile!, kAudioFilePropertyInfoDictionary, &piDataSize, &dic)
        print(dic!)*/
        
        //获取文件类型
        var dataFormatSize:UInt32 =  UInt32(MemoryLayout<AudioStreamBasicDescription>.size)
        var dataFormat = AudioStreamBasicDescription()
        if AudioFileGetProperty(audioFile!, kAudioFilePropertyDataFormat, &dataFormatSize, &dataFormat) == noErr {
            playerState.mDataFormat = dataFormat
        }else {
            return nil
        }
        //创建播放音频队列
        var queue:AudioQueueRef?
        if(AudioQueueNewOutput(&dataFormat, audioQueueOutputCallback, &playerState, CFRunLoopGetCurrent(), CFRunLoopMode.commonModes.rawValue, 0, &queue) == noErr){
            playerState.mQueue = queue
        }else {
            return nil
        }
        
        //设置buffer size与读取的音频数据包数量
        var maxPacketSize:UInt32 = 0
        var propertySize:UInt32 = UInt32(MemoryLayout<UInt32>.size)
        //为数据包描述数组分配内存
        if(AudioFileGetProperty(audioFile!, kAudioFilePropertyPacketSizeUpperBound, &propertySize, &maxPacketSize) == noErr){
            playerState.bufferByteSize = kNumberPackages * maxPacketSize
            playerState.mPacketDescs = UnsafeMutablePointer<AudioStreamPacketDescription>.allocate(capacity: Int(kNumberPackages))
        }else {
            return nil
        }
        
        //设置magic cookie
        var cookieSize:UInt32 = UInt32(MemoryLayout<UInt32>.size)
        if AudioFileGetPropertyInfo(audioFile!, kAudioFilePropertyMagicCookieData, &cookieSize, nil) == noErr {
            let magicCookie:UnsafeMutablePointer<CChar> = UnsafeMutablePointer<CChar>.allocate(capacity: Int(cookieSize))
            AudioFileGetProperty(playerState.mAudioFile!, kAudioFilePropertyMagicCookieData, &cookieSize, magicCookie)
            AudioQueueSetProperty(playerState.mQueue!, kAudioQueueProperty_MagicCookie, magicCookie, cookieSize)
            magicCookie.deallocate()
        }
        
        //分配音频队列数据
        playerState.mCurrentPacket = 0
        for _ in 0..<kNumberBuffers {
            var buffer: AudioQueueBufferRef?
            if AudioQueueAllocateBuffer(queue!, playerState.bufferByteSize, &buffer) == noErr {
                playerState.mBuffers.append(buffer!)
                audioQueueOutputCallback(inUserData: &playerState, inQueue: queue!, inBuffer: buffer!)
            } else {
                return nil
            }
        }
                
        //设置声音
        AudioQueueSetParameter(queue!, kAudioQueueParam_Volume, 1.0)
        
        playing = true
        AudioQueueStart(queue!, nil)
    }
}

extension JKAudioPlayer {
    func play() {
        playing = true
        AudioQueueStart(playerState.mQueue!, nil)
    }
    
    func pause() {
        playing = false
        AudioQueuePause(playerState.mQueue!)
    }
}

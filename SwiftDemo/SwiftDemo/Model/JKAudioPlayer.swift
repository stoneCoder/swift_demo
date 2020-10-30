//
//  JKAudioManager.swift
//  SwiftDemo
//
//  Created by Consle on 2020/10/25.
//  Copyright © 2020 Consle. All rights reserved.
//

import UIKit
import AudioToolbox
import AVFoundation

fileprivate let kNumberBuffers: Int = 3

class JKAudioPlayer: NSObject {
    var mDataFormat:AudioStreamBasicDescription = AudioStreamBasicDescription() //音频流描述对象
    var mAudioQueue:AudioQueueRef? = nil
    var mAudioFile:AudioFileID? = nil //播放音频文件ID
    var mBuffSize: UInt32 = 0
    var mCurrentPacketIndex: Int64 = 0
    var playing:Bool = false
    var mNumPacketsToRead:UInt32 = 0  //每次调用回调函数要读取的音频数据包的个数
    var mPacketDescs:UnsafeMutablePointer<AudioStreamPacketDescription>?//对于VBR音频数据,表示正在播放的音频数据包描述性数组,对于CBR音频数据可以设为NULL
    var mBuffers = Array<AudioQueueBufferRef?>(repeating: nil, count: kNumberBuffers)
    
    class var shared: JKAudioPlayer {
        return Inner.instance
    }

    struct Inner {
        static let instance: JKAudioPlayer = JKAudioPlayer()
    }
    
    func play(url:URL) {
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            
        }
        
        playing = true
        if prepareAudioQueue(url: url) {
            AudioQueueStart(mAudioQueue!, nil)
            
            let inUserPointer = unsafeBitCast(self, to: UnsafeMutableRawPointer.self)
            for index in 0..<kNumberBuffers {
                audioQueueOutputCallback(inUserPointer, mAudioQueue!, mBuffers[index]!)
            }
        }
        
    }
    
    func pause(){
        if(playing && mAudioQueue != nil){
            playing = false
            AudioQueuePause(mAudioQueue!)
        }
    }
    
    func resume(){
        if(!playing && mAudioQueue != nil){
            playing = true
            AudioQueueStart(mAudioQueue!, nil)
        }
    }
    
    func stop(){
        if(playing && mAudioQueue != nil){
            playing = false
            AudioQueueStop(mAudioQueue!, true)
        }
    }
    
    func dispose() {
        if(mAudioQueue != nil && mAudioFile != nil){
            AudioQueueDispose(mAudioQueue!, true)
            AudioFileClose(mAudioFile!)
        }
    }
    
    func prepareAudioQueue(url: URL) -> Bool{
        var prepareAudioQueueStatus:Bool = true
        //打开文件
        if(AudioFileOpenURL(url as CFURL, AudioFilePermissions.readPermission, 0, &mAudioFile) != noErr){
            print("打开文件失败")
            prepareAudioQueueStatus = false
            return prepareAudioQueueStatus
        }
        /*let audioAsset = AVURLAsset.init(url: url, options: nil)
        let audioDuration = audioAsset.duration
        let audioDurationSeconds = CMTimeGetSeconds(audioDuration);
        print("获取音频文件长---------->\(audioDurationSeconds)")*/
        //获取音频文件信息
        /*var dic:NSDictionary?
        var piDataSize:UInt32 = UInt32(MemoryLayout.size(ofValue: dic));
        err = AudioFileGetProperty(mAudioFile!, kAudioFilePropertyInfoDictionary, &piDataSize, &dic)
        print(dic!)*/
        
        //获取文件类型
        var dataFormatSize:UInt32 =  UInt32(MemoryLayout<AudioStreamBasicDescription>.size)
        var dataFormat = AudioStreamBasicDescription()
        if AudioFileGetProperty(mAudioFile!, kAudioFilePropertyDataFormat, &dataFormatSize, &dataFormat) != noErr {
            print("获取文件类型失败")
            prepareAudioQueueStatus = false
            return prepareAudioQueueStatus
        }
        //创建播放音频队列
        let player = Unmanaged.passRetained(self).toOpaque()
        if(AudioQueueNewOutput(&dataFormat, audioQueueOutputCallback, player, CFRunLoopGetCurrent(), CFRunLoopMode.commonModes.rawValue, 0, &mAudioQueue) != noErr){
            print("创建播放音频队列失败")
            prepareAudioQueueStatus = false
            return prepareAudioQueueStatus
        }
        
        //设置buffer size与读取的音频数据包数量
        var maxPacketSize:UInt32 = 0
        var propertySize:UInt32 = UInt32(MemoryLayout<UInt32>.size)
        AudioFileGetProperty(mAudioFile!, kAudioFilePropertyPacketSizeUpperBound, &propertySize, &maxPacketSize)
        
        deriveBufferSize(asbDescription: dataFormat, maxPacketSize: maxPacketSize, seconds: 0.5, outBufferSize: &mBuffSize, outNumPacketsToRead: &mNumPacketsToRead)
        //为数据包描述数组分配内存
        let isFormatVBR = mDataFormat.mBytesPerPacket == 0 || mDataFormat.mFramesPerPacket == 0
        if isFormatVBR {
            let descsSize = MemoryLayout<AudioStreamPacketDescription>.size
            mPacketDescs = malloc(Int(mNumPacketsToRead) * descsSize)?.assumingMemoryBound(to: AudioStreamPacketDescription.self)
        }else{
            mPacketDescs = nil
        }
        
        //设置magic cookie
        var cookieSize:UInt32 = UInt32(MemoryLayout<UInt32>.size)
        if AudioFileGetPropertyInfo(mAudioFile!, kAudioFilePropertyMagicCookieData, &cookieSize, nil) == noErr {
            let magicCookie:UnsafeMutablePointer<CChar> = UnsafeMutablePointer<CChar>.allocate(capacity: Int(cookieSize))
            AudioFileGetProperty(mAudioFile!, kAudioFilePropertyMagicCookieData, &cookieSize, magicCookie)
            AudioQueueSetProperty(mAudioQueue!, kAudioQueueProperty_MagicCookie, magicCookie, cookieSize)
            magicCookie.deallocate()
        }
        
        //分配音频队列数据
        mCurrentPacketIndex = 0
        for index in 0..<kNumberBuffers {
            if AudioQueueAllocateBuffer(mAudioQueue!, mBuffSize, &mBuffers[index]) != noErr {
                print("分配音频队列数据失败")
                prepareAudioQueueStatus = false
                return prepareAudioQueueStatus
            }
        }
                
        //设置声音
        AudioQueueSetParameter(mAudioQueue!, kAudioQueueParam_Volume, 1.0)
        
        return prepareAudioQueueStatus
    }
    
    
    let audioQueueOutputCallback:AudioQueueOutputCallback = {(inUserData: UnsafeMutableRawPointer?, inQueue: AudioQueueRef, inBuffer: AudioQueueBufferRef) in
        var player = unsafeBitCast(inUserData!, to:JKAudioPlayer.self)
        if !player.playing {
            print("not running")
            return
        }
        
        var numBytesReadFromFile: UInt32 = inBuffer.pointee.mAudioDataBytesCapacity
        var numPackets: UInt32 = player.mNumPacketsToRead
        AudioFileReadPacketData(player.mAudioFile!, false, &numBytesReadFromFile, player.mPacketDescs, player.mCurrentPacketIndex, &numPackets, inBuffer.pointee.mAudioData)
        if (numPackets > 0){
            inBuffer.pointee.mAudioDataByteSize = numBytesReadFromFile
            inBuffer.pointee.mPacketDescriptionCount = numPackets
            AudioQueueEnqueueBuffer(inQueue, inBuffer, (player.mPacketDescs == nil ? 0 : numPackets), player.mPacketDescs)
            player.mCurrentPacketIndex = player.mCurrentPacketIndex + Int64(numPackets)
            print("play audio numPackets is \(numPackets)")
        }else{
            print("stop")
            AudioQueueStop(inQueue, false)
            player.playing = false
        }
    }
}

//
//  JKAudioManager.swift
//  SwiftDemo
//
//  Created by 张磊 on 2020/10/25.
//  Copyright © 2020 sinosun. All rights reserved.
//

import UIKit
import AudioToolbox

class JKAudioManager: NSObject {
    
    let kNumberBuffers = 3;
    
    struct JKPlayerState {
        var mDataFormat:AudioStreamBasicDescription?
        var mQueue:AudioQueueRef?
        var mBuffers:Array<AudioQueueBufferRef>?
        var mAudioFile:AudioFileID?
    }
    
    var playerState:JKPlayerState
    
    let outPutHandlerCallBack:AudioQueueOutputCallback = { (aqData:UnsafeMutableRawPointer?, inAQ:AudioQueueRef, inBuffer: AudioQueueBufferRef) in
        print(aqData!)
    }
    
    override init() {
        playerState = JKPlayerState()
    }
    
    func test() {
        //打开本地文件
        let result:OSStatus = AudioFileOpenURL(URL.init(fileURLWithPath: Bundle.main.path(forResource: "test.m4a", ofType: nil)!) as CFURL, AudioFilePermissions.readPermission, 0, &playerState.mAudioFile)
        
        if(result == kAudioFileNotOpenError){
            return
        }
        //获取文件类型
        var dataFormatSize:UInt32 = UInt32(MemoryLayout.size(ofValue: playerState.mDataFormat))
        AudioFileGetProperty(playerState.mAudioFile!, kAudioFilePropertyDataFormat, &dataFormatSize, &playerState.mDataFormat)
        AudioQueueNewOutput(&playerState.mDataFormat!, outPutHandlerCallBack, &playerState, CFRunLoopGetCurrent(), CFRunLoopMode.commonModes.rawValue, 0, &playerState.mQueue)
    }
}

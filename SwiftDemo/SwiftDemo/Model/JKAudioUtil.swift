//
//  SSAudioUtil.swift
//  SSAudioQueueRecording
//
//  Created by Michael on 2020/4/3.
//  Copyright © 2020 Michael. All rights reserved.
//

import UIKit
import AudioToolbox

class JKAudioUtil: NSObject {

}

func deriveBufferSize(asbDescription:AudioStreamBasicDescription,maxPacketSize:UInt32,seconds:Float64,outBufferSize: UnsafeMutablePointer<UInt32>,outNumPacketsToRead: UnsafeMutablePointer<UInt32>) -> Void {
    let maxBufferSize:UInt32 = 0x50000
    let minBufferSize:UInt32 = 0x4000
    
    if asbDescription.mFramesPerPacket != 0 {
        let numPacketsForTime = asbDescription.mSampleRate/Double(asbDescription.mFramesPerPacket)*seconds
        outBufferSize.pointee = UInt32(numPacketsForTime)*UInt32(maxPacketSize)
    }
    else
    {
        outBufferSize.pointee = max(maxBufferSize, maxPacketSize)
    }
    
    if (outBufferSize.pointee > maxBufferSize && outBufferSize.pointee > maxPacketSize)
    {
        outBufferSize.pointee = maxBufferSize
    }
    else {
        if (outBufferSize.pointee < minBufferSize)
        {
            outBufferSize.pointee = minBufferSize
        }
    }
    
    outNumPacketsToRead.pointee = outBufferSize.pointee / maxPacketSize
}

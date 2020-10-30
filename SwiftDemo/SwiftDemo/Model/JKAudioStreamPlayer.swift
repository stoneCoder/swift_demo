//
//  JKAudioStreamPlayer.swift
//  SwiftDemo
//
//  Created by Consle on 2020/10/29.
//  Copyright © 2020 Consle. All rights reserved.
//

import UIKit
import AudioToolbox

class JKAudioStreamPlayer: NSObject {
    var audioFileStreamID:AudioFileStreamID? = nil
    var readyToProducePackets:Bool = false
    
    func openAudioFileStream(){
        openAudioFileStream(fileTypeHint: 0)
    }
    
    func openAudioFileStream(fileTypeHint:AudioFileTypeID){
        let streamPlayer = Unmanaged.passRetained(self).toOpaque()
        if AudioFileStreamOpen(streamPlayer, audio_file_stream_property_listener_proc, audio_file_stream_packets_proc, fileTypeHint, &audioFileStreamID) != noErr {
            audioFileStreamID = nil
        }
    }
    
    func closeAudioFileStream(){
      if (audioFileStreamID != nil) {
        AudioFileStreamClose(audioFileStreamID!);
        audioFileStreamID = nil
      }
    }
    
    func handleAudioFileStreamProperty(propertyID:AudioFileStreamPropertyID){
      if(propertyID == kAudioFileStreamProperty_ReadyToProducePackets) {
        readyToProducePackets = true
      }
    }
    
    func handleAudioFileStreamPackets(packets:UnsafeRawPointer ,numberOfBytes:UInt32 ,numberOfPackets:UInt32 ,packetDescriptioins:UnsafeMutablePointer<AudioStreamPacketDescription>?){
    }
    
    let audio_file_stream_property_listener_proc:AudioFileStream_PropertyListenerProc = {(inClientData:UnsafeMutableRawPointer, inAudioFileStream:AudioFileStreamID, inPropertyID:AudioFileStreamPropertyID, ioFlags:UnsafeMutablePointer<AudioFileStreamPropertyFlags>) in
        var streamPlayer = unsafeBitCast(inClientData, to:JKAudioStreamPlayer.self)
        streamPlayer.handleAudioFileStreamProperty(propertyID: inPropertyID)
    }
    
    let audio_file_stream_packets_proc:AudioFileStream_PacketsProc = { (inClientData:UnsafeMutableRawPointer, inNumberBytes:UInt32, inNumberPackets:UInt32, inInputData:UnsafeRawPointer, inPacketDescriptions:UnsafeMutablePointer<AudioStreamPacketDescription>?) in
        var streamPlayer = unsafeBitCast(inClientData, to:JKAudioStreamPlayer.self)
        streamPlayer.handleAudioFileStreamPackets(packets: inInputData, numberOfBytes: inNumberBytes, numberOfPackets: inNumberPackets, packetDescriptioins: inPacketDescriptions)
    }
}

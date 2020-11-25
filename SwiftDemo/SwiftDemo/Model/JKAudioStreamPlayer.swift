//
//  JKAudioStreamPlayer.swift
//  SwiftDemo
//
//  Created by Consle on 2020/10/29.
//  Copyright © 2020 Consle. All rights reserved.
//

import UIKit
import AudioToolbox
import Alamofire

class JKAudioStreamPlayer: NSObject {
    var audioFileStreamID:AudioFileStreamID? = nil
    var readyToProducePackets:Bool = false
    var audioFileURL:URL? = nil
    var cachedPath:String? = nil
    var cachedURL:URL? = nil
    var streamRequest:DataStreamRequest? = nil
    let progressQueue = DispatchQueue(label: "com.alamofire.progressQueue", qos: .utility)
    
    override init() {
        super.init()
    }
    
    convenience init(audioFile:URL) {
        self.init()
        audioFileURL = audioFile
        openAudioFileStream()
        createRequest()
    }
    
    func openAudioFileStream(){
        openAudioFileStream(fileTypeHint: 0)
    }
    
    func openAudioFileStream(fileTypeHint:AudioFileTypeID){
        let streamPlayer = Unmanaged.passRetained(self).toOpaque()
        if AudioFileStreamOpen(streamPlayer, audio_file_stream_property_listener_proc, audio_file_stream_packets_proc, fileTypeHint, &audioFileStreamID) != noErr {
            audioFileStreamID = nil
        }
    }
    
    func createRequest(){
        let request = AF.request(audioFileURL!)
        request.downloadProgress { progress in
            print(progress.totalUnitCount)
        }
        streamRequest = AF.streamRequest(audioFileURL!, automaticallyCancelOnStreamError: true, interceptor: nil).responseStream(on: progressQueue, stream: {[weak self] stream in
            switch stream.event {
                case let .stream(result):
                    switch result {
                    case let .success(data):
                        self?.requestDidReceiveData(data: data as NSData)
                    case let .failure(error):
                        print(error)
                    }
                    case let .complete(completion):
                        print("aaa")
                }
        })
        print(streamRequest?.response)
    }
    
    func requestDidReceiveData(data:NSData) {
//        print(data)
    }
    
    func requestDidComplete(){
        
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

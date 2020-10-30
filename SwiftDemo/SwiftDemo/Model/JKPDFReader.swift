//
//  JKPDFReader.swift
//  SwiftDemo
//
//  Created by Consle on 2020/10/25.
//  Copyright © 2020 Consle. All rights reserved.
//

import UIKit

class JKPDFReader: NSObject {
    
    func openPDFAtPath(path:URL) -> Bool {
        let document = CGPDFDocument.init(path as CFURL)
        var info = document?.info
        getPDFContents(document: document!)
        return (document != nil) ? true:false
    }
    
    
    func getPDFContents(document:CGPDFDocument) -> Array<Any>? {
        var mycatalog:CGPDFDictionaryRef = document.catalog!
        return nil
    }
    
    func getValueWithKeyAtPDF(info:CGPDFDictionaryRef?,key:String) -> String? {
        guard let infoDict = info else {
            return nil
        }
        let textKey = (key as NSString).cString(using: String.Encoding.ascii.rawValue)!
        var textStringRef: CGPDFStringRef?
        CGPDFDictionaryGetString(infoDict, textKey, &textStringRef)
        if let stringRef = textStringRef,
           let cTitle = CGPDFStringGetBytePtr(stringRef) {
            let length = CGPDFStringGetLength(stringRef)
            let encoding = CFStringBuiltInEncodings.UTF8.rawValue
            let allocator = kCFAllocatorDefault
            let optionalTitle: UnsafePointer<UInt8>! = Optional<UnsafePointer<UInt8>>(cTitle)
            if let title = CFStringCreateWithBytes(allocator, optionalTitle, length, encoding, true) {
                return title as String
            }
        }
        return nil
    }
}

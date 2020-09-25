//
//  ModelUtils.swift
//  SwiftDemo
//
//  Created by sinosun on 2020/9/25.
//  Copyright © 2020 sinosun. All rights reserved.
//

import UIKit

class ModelUtils: NSObject {
    class func jsonDicToData(jsonDic:Dictionary<String, Any>) -> Data? {
            if (!JSONSerialization.isValidJSONObject(jsonDic)) {
                print("is not a valid json object")
                return nil
            }
            //利用自带的json库转换成Data
            //如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
            let data = try? JSONSerialization.data(withJSONObject: jsonDic, options: [])
            return data
    }
    
    class func jsonDicToString(jsonDic:Dictionary<String, Any>) ->String? {
        if (!JSONSerialization.isValidJSONObject(jsonDic)) {
            print("is not a valid json object")
            return nil
        }
        //利用自带的json库转换成Data
        //如果设置options为JSONSerialization.WritingOptions.prettyPrinted，则打印格式更好阅读
        let jsonData = try? JSONSerialization.data(withJSONObject: jsonDic, options: [])
        return String(data: jsonData!, encoding: .utf8)
    }
}

//
//  ModelUtils.swift
//  SwiftDemo
//
//  Created by Consle on 2020/9/25.
//  Copyright © 2020 Consle. All rights reserved.
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
    
    //时间戳转成字符串
    class func timeIntervalChangeToTimeStr(timeInterval:TimeInterval, dateFormat:String?) -> String {
        let date:NSDate = NSDate.init(timeIntervalSince1970: timeInterval/1000)
        let formatter = DateFormatter.init()
        if dateFormat == nil {
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }else{
            formatter.dateFormat = dateFormat
        }
        return formatter.string(from: date as Date)
    }
    
    //字符串转时间戳
    class func timeStrChangeTotimeInterval(timeStr: String?, dateFormat:String?) -> String {
        if timeStr?.count ?? 0 > 0 {
            return ""
        }
        let format = DateFormatter.init()
        format.dateStyle = .medium
        format.timeStyle = .short
        if dateFormat == nil {
            format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }else{
            format.dateFormat = dateFormat
        }
        let date = format.date(from: timeStr!)
        return String(date!.timeIntervalSince1970)
    }
}

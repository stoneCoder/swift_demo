//
//  Convertable.swift
//  SwiftDemo
//
//  Created by sinosun on 2020/9/25.
//  Copyright © 2020 sinosun. All rights reserved.
//

import Foundation

protocol Convertable:Codable {
    
}

extension Convertable{
    /// 直接将Struct或Class转成Dictionary
    func convertToDict() -> Dictionary<String, Any>? {
        var dict: Dictionary<String, Any>? = nil
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(self)
            dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Dictionary<String, Any>
        } catch {
            print(error)
        }
        return dict
    }
    
    
    func convertToJsonString() -> String? {
        var json: String? = nil
        do {
            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(self)
            json = String(data: jsonData, encoding: .utf8)!
        } catch {
            print(error)
        }
        return json
    }
    
}

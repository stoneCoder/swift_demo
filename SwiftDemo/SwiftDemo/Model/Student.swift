//
//  Student.swift
//  SwiftDemo
//
//  Created by Consle on 2020/9/25.
//  Copyright © 2020 Consle. All rights reserved.
//

import UIKit

class Student: Person {
    var id:String?
    var grade:Int?
    
    override init() {
        super.init()
    }
    
    //子类必须实现 不然转换JSON不包含此参数
    enum CodingKeys: String, CodingKey {
       case id
       case grade
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        grade = try container.decode(Int.self, forKey: .grade)
        try super.init(from: decoder)
    }

    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: CodingKeys.id)
        try container.encode(grade, forKey: CodingKeys.grade)
        try super.encode(to: encoder)
    }
}

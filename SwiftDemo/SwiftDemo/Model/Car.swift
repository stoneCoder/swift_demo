//
//  Car.swift
//  SwiftDemo
//
//  Created by Consle on 2020/9/25.
//  Copyright © 2020 Consle. All rights reserved.
//

import UIKit

struct Car: Codable {
    var id:String
    var name:String
    var grade:Int
    
    init(id:String, name:String, grade:Int) {
        self.id = id
        self.name = name
        self.grade = grade
    }
}

//
//  SSResponse.swift
//  SwiftDemo
//
//  Created by Consle on 2020/9/25.
//  Copyright © 2020 Consle. All rights reserved.
//

import UIKit

class SSResponse:NSObject, Codable{
    var result:[People]?
}

class People:NSObject, Codable {
    var aid:String?
    var catid:String?
    var dateline:String?
    var pic:String?
    var title:String?
    var username:String?
}

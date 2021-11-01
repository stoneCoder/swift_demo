//
//  Const.swift
//  SwiftDemo
//
//  Created by Consle on 2020/9/22.
//  Copyright © 2020 Consle. All rights reserved.
//

import Foundation
import UIKit


// 屏幕的宽
let SCREEN_WIDTH = UIScreen.main.bounds.size.width

// 屏幕的高
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

//状态栏高度
//let STATUSBAR_HEIGHT = UIApplication.shared.statusBarFrame.height

//导航栏高度:通用
let NAVIGATIONBAR_HEIGHT = UINavigationController().navigationBar.frame.size.height

//分割线
let LINE_HEIGHT = 1.0/UIScreen.main.scale


var isNotchScreen: Bool {
    if UIDevice.current.userInterfaceIdiom == .pad {
        return false
    }

    let size = UIScreen.main.bounds.size
    let notchValue: Int = Int(size.width/size.height * 100)

    if 216 == notchValue || 46 == notchValue {
        return true
    }
    return false
}

//判断是否iphoneX
let STATUSBAR_HEIGHT = isNotchScreen ? CGFloat(44.0) : CGFloat(20.0)
let NAVBAR_HEIGHT = isNotchScreen ? CGFloat(88.0) : CGFloat(64.0)
let TABBAR_HEIGHT = isNotchScreen ? CGFloat(83.0) : CGFloat(49.0)

func colorFromRGB(r:CGFloat,_ g:CGFloat,_ b:CGFloat, alpha:CGFloat) -> UIColor{
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: alpha)
}

func colorFromHex(h:Int) ->UIColor {
    return colorFromRGB(r: CGFloat(((h)>>16) & 0xFF), CGFloat(((h)>>8) & 0xFF), CGFloat((h) & 0xFF), alpha: 1.0)
}

func colorFromHex(h:Int, alpha:CGFloat) ->UIColor {
    return colorFromRGB(r: CGFloat(((h)>>16) & 0xFF), CGFloat(((h)>>8) & 0xFF), CGFloat((h) & 0xFF), alpha: alpha)
}

func kFont(size:CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size);
}

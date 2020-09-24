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


//判断是否iphoneX
//let W_IPHONEX = (Double(SCREEN_WIDTH) == Double(375.0) && Double(SCREEN_HEIGHT) == Double(812.0)) ? true : false
//let W_NAVBARHEIGHT = W_IPHONEX ? Double(88.0) : Double(64.0)
//let W_TABBARHEIGHT = W_IPHONEX ? Double(49.0+34.0) : Double(49.0)
//let W_STATUSBARHEIGHT = W_IPHONEX ? Double(44.0) : Double(20.0)

func colorFromRGB(r:CGFloat,_ g:CGFloat,_ b:CGFloat, alpha:CGFloat) -> UIColor{
    return UIColor(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: alpha)
}

func colorFromHex(h:Int) ->UIColor {
    return colorFromRGB(r: CGFloat(((h)>>16) & 0xFF), CGFloat(((h)>>8) & 0xFF), CGFloat((h) & 0xFF), alpha: 1.0)
}

func kFont(size:CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size);
}

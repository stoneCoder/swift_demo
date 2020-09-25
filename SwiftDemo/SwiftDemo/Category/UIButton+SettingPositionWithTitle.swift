//
//  UIButton+SettingPositionWithTitle.swift
//  SwiftDemo
//
//  Created by Consle on 2020/9/24.
//  Copyright © 2020 Consle. All rights reserved.
//

import Foundation
import UIKit

extension UIButton{
    
    //垂直图片标题显示
    func changeTitleAndImagePositionToVerticalWithBetweenSpace(space:CGFloat) {
        self.layoutIfNeeded()
        self.contentVerticalAlignment = UIControl.ContentVerticalAlignment.top
        self.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        
        let imageW:CGFloat = self.imageView?.frame.size.width ?? 0
        let imageH:CGFloat = self.imageView?.frame.size.height ?? 0
        //获取titleLabel的宽度
        let labelW:CGFloat = self.titleLabel?.frame.size.width ?? 0
        let labelH:CGFloat = self.titleLabel?.frame.size.height ?? 0
        //设置上内距
        let imageDistance:CGFloat = (self.frame.size.width - imageW) * 0.5
        //设置上内距
        let imageTop:CGFloat = (self.frame.size.height - imageH - labelH) * 0.5
        //进行移动
        self.imageEdgeInsets = UIEdgeInsets.init(top: imageTop, left: imageDistance, bottom: 0, right: 0)
        //计算移动距离
        let labelDistance:CGFloat = -imageW + (self.frame.size.width - labelW) * 0.5 ;
        //上内距
        let labelTop:CGFloat = imageTop + imageH + space;
        self.titleEdgeInsets = UIEdgeInsets.init(top: labelTop, left: labelDistance, bottom: 0, right: 0)
    }
    
    //交换图片标题位置
    func exChangeTitleAndImagePosition() {
        self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -(self.imageView?.frame.size.width ?? 0 - 10), bottom: 0, right: self.imageView?.frame.size.width ?? 0)
        self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: self.titleLabel?.bounds.size.width ?? 0, bottom: 0, right: -(self.titleLabel?.bounds.size.width ?? 0))
    }
    
}

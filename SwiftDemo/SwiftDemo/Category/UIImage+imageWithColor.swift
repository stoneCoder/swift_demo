//
//  UIImage+imageWithColor.swift
//  SwiftDemo
//
//  Created by Consle on 2020/9/22.
//  Copyright © 2020 Consle. All rights reserved.
//

import Foundation
import UIKit
import CoreGraphics

extension UIImage{
    class func imageWithColor(color:UIColor) -> UIImage? {
        return self.imageWithColor(color: color, size: CGSize(width: 1, height: 1))
    }
    
    class func imageWithColor(color:UIColor?,size:CGSize) -> UIImage?{
        if (color === nil || size.width <= 0 || size.height <= 0){
            return nil
        }
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color!.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    class func imageFromLayer(layer:CALayer) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, layer.isOpaque, 0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return outputImage
    }
    
    class func createGradientLayerWith(frame:CGRect) -> CAGradientLayer?{
        return self.createGradientLayerWith(frame: frame, colors: [colorFromHex(h: 0x5f35fb).cgColor,colorFromHex(h: 0xae46ff).cgColor])
    }
    
    class func createGradientLayerWith(frame:CGRect,colors:[Any]?) -> CAGradientLayer?{
        let layer = CAGradientLayer()
        layer.colors = colors
        layer.locations = [0.3,0.9]
        layer.startPoint = CGPoint.init(x: 0.0,y: 0.0)
        layer.endPoint = CGPoint.init(x: 1.0,y: 0)
        layer.frame = frame
        return layer
    }
}

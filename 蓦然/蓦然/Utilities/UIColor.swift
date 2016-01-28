//
//  UIColor.swift
//  蓦然
//
//  Created by 王祖康 on 16/1/28.
//  Copyright © 2016年 com.GeekBand. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static func colorToRGB(var colorValue:NSString) -> UIColor{
        
        if colorValue.hasPrefix("#"){
           colorValue = colorValue.substringFromIndex(1)
        }
        
        let redStr = colorValue.substringToIndex(2)
        let greenStr = (colorValue.substringFromIndex(2) as NSString).substringToIndex(2)
        let blueStr = (colorValue.substringFromIndex(4) as NSString).substringToIndex(2)
        
        var r:CUnsignedInt = 0
        var g:CUnsignedInt = 0
        var b:CUnsignedInt = 0
        
        NSScanner(string: redStr).scanHexInt(&r)
        NSScanner(string: greenStr).scanHexInt(&g)
        NSScanner(string: blueStr).scanHexInt(&b)
        
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1)
    }
}
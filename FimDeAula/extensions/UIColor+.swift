//
//  UIColor+.swift
//  FimDeAula
//
//  Created by Pedro Emanuel on 09/10/18.
//  Copyright © 2018 Pedro Emanuel. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    @objc convenience init(hexString: String) {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        let index = hexString.index(hexString.startIndex, offsetBy: hexString.hasPrefix("#") ? 1 : 0)
        let hexNormalized = String(hexString[index...])
        let scanner = Scanner(string: hexNormalized)
        var hexValue: CUnsignedLongLong = 0
        
        if scanner.scanHexInt64(&hexValue) {
            if hexNormalized.count == 6 {
                red   = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)  / 255.0
                blue  = CGFloat(hexValue & 0x0000FF) / 255.0
            } else if hexNormalized.count == 8 {
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
            } else {
                print("Invalid hex string", terminator: "")
            }
        }
        
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}

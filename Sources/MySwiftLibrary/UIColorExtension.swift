//
//  UIColorExtension.swift
//
//  Created by William J. C. Nesbitt.
//

#if os(iOS)
import UIKit.UIColor

public extension UIColor {
    convenience init(r: Int, g: Int, b: Int, a: Int = 255) {
        let red   = CGFloat(r) / 255
        let green = CGFloat(g) / 255
        let blue  = CGFloat(b) / 255
        let alpha = CGFloat(a) / 255
        #if DEBUG
        print("Red: \(red), Green: \(green), Blue: \(blue), Alpha: \(alpha)")
        #endif
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    convenience init(rgb: Int, a: Int = 0xFF) {
        let red   = CGFloat(rgb >> 16 & 0xFF) / 0xFF
        let green = CGFloat(rgb >>  8 & 0xFF) / 0xFF
        let blue  = CGFloat(rgb       & 0xFF) / 0xFF
        let alpha = CGFloat(a               ) / 0xFF
        #if DEBUG
        print("Red: \(red), Green: \(green), Blue: \(blue), Alpha: \(alpha)")
        #endif
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
#endif

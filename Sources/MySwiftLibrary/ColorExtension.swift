//
//  ColorExtension.swift
//
//  Created by William J. C. Nesbitt.
//  Copyright © 2020 William J. C. Nesbitt. All rights reserved.
//

import SwiftUI

@available(iOS 13, macOS 10.15, tvOS 13, watchOS 6, *)
extension Color {
    @inlinable public init(_ colorSpace: RGBColorSpace = .sRGB, r: Int, g: Int, b: Int, o: Int = 255) {
        let red     = Double(r) / 255
        let green   = Double(g) / 255
        let blue    = Double(b) / 255
        let opacity = Double(o) / 255
//      debugPrint("Red: \(red), Green: \(green), Blue: \(blue), Opacity: \(opacity)")
        self.init(colorSpace, red: red, green: green, blue: blue, opacity: opacity)
    }

    @inlinable public init(_ colorSpace: RGBColorSpace = .sRGB, rgb: Int, o: Int = 0xFF) {
        let red     = Double(rgb >> 16 & 0xFF) / 0xFF
        let green   = Double(rgb >>  8 & 0xFF) / 0xFF
        let blue    = Double(rgb       & 0xFF) / 0xFF
        let opacity = Double(o               ) / 0xFF
//      debugPrint("Red: \(red), Green: \(green), Blue: \(blue), Opacity: \(opacity)")
        self.init(colorSpace, red: red, green: green, blue: blue, opacity: opacity)
    }
}

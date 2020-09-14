//
//  FormatNumbers.swift
//
//  Created by William J. C. Nesbitt.
//  Copyright © 2020 William J. C. Nesbitt. All rights reserved.
//

import Foundation.NSNumberFormatter

extension BinaryInteger {
    @inlinable public func `as`(_ style: NumberFormatter.Style) -> String {
        NumberFormatter.localizedString(from: NSNumber(value: Int(self)), number: style)
    }
}

extension BinaryFloatingPoint {
    @inlinable public func `as`(_ style: NumberFormatter.Style) -> String {
        NumberFormatter.localizedString(from: NSNumber(value: Double(self)), number: style)
    }
}

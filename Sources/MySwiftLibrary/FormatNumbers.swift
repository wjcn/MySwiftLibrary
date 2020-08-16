//
//  FormatNumbers.swift
//
//  Created by William J. C. Nesbitt.
//

import Foundation.NSNumberFormatter

public extension BinaryInteger {
    func `as`(_ style: NumberFormatter.Style) -> String {
        NumberFormatter.localizedString(from: NSNumber(value: Int(self)), number: style)
    }
}

public extension BinaryFloatingPoint {
    func `as`(_ style: NumberFormatter.Style) -> String {
        NumberFormatter.localizedString(from: NSNumber(value: Double(self)), number: style)
    }
}

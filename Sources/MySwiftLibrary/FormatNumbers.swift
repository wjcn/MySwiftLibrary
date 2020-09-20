//
//  FormatNumbers.swift
//
//  Created by William J. C. Nesbitt.
//  Copyright © 2020 William J. C. Nesbitt. All rights reserved.
//

import Foundation.NSNumberFormatter

extension NSNumber {
    @inlinable public func `as`(_ style: NumberFormatter.Style) -> String {
        NumberFormatter.localizedString(from: self, number: style)
    }

    @inlinable public func `as`(_ numberStyle: NumberFormatter.Style,
                                _ maximumFractionalDigits: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = maximumFractionalDigits
        numberFormatter.numberStyle = numberStyle
        return numberFormatter.string(from: self)!
    }
}

extension Int {
    @inlinable public func `as`(_ style: NumberFormatter.Style) -> String {
        NSNumber(value: self).as(style)
    }
}

extension Int8 {
    @inlinable public func `as`(_ style: NumberFormatter.Style) -> String {
        NSNumber(value: self).as(style)
    }
}

extension Int16 {
    @inlinable public func `as`(_ style: NumberFormatter.Style) -> String {
        NSNumber(value: self).as(style)
    }
}

extension Int32 {
    @inlinable public func `as`(_ style: NumberFormatter.Style) -> String {
        NSNumber(value: self).as(style)
    }
}

extension Int64 {
    @inlinable public func `as`(_ style: NumberFormatter.Style) -> String {
        NSNumber(value: self).as(style)
    }
}

extension UInt {
    @inlinable public func `as`(_ style: NumberFormatter.Style) -> String {
        NSNumber(value: self).as(style)
    }
}

extension UInt8 {
    @inlinable public func `as`(_ style: NumberFormatter.Style) -> String {
        NSNumber(value: self).as(style)
    }
}

extension UInt16 {
    @inlinable public func `as`(_ style: NumberFormatter.Style) -> String {
        NSNumber(value: self).as(style)
    }
}

extension UInt32 {
    @inlinable public func `as`(_ style: NumberFormatter.Style) -> String {
        NSNumber(value: self).as(style)
    }
}

extension UInt64 {
    @inlinable public func `as`(_ style: NumberFormatter.Style) -> String {
        NSNumber(value: self).as(style)
    }
}

extension Double {
    @inlinable public func `as`(_ style: NumberFormatter.Style) -> String {
        NSNumber(value: self).as(style)
    }

    @inlinable public func `as`(_ style: NumberFormatter.Style,
                                _ maximumFractionalDigits: Int) -> String {
        NSNumber(value: self).as(style, maximumFractionalDigits)
    }
}

extension Float {
    @inlinable public func `as`(_ style: NumberFormatter.Style) -> String {
        NSNumber(value: self).as(style)
    }

    @inlinable public func `as`(_ style: NumberFormatter.Style,
                                _ maximumFractionalDigits: Int) -> String {
        NSNumber(value: self).as(style, maximumFractionalDigits)
    }
}

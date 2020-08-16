//
//  StringExtension.swift
//
//  Created by William J. C. Nesbitt.
//

import Foundation.NSString

public extension String {
    @inlinable var notEmpty: Bool { !isEmpty }

    static func + (leftSide: Self, rightSide: Element) -> Self {
        var result = leftSide
        result.append(rightSide)
        return result
    }

    static func + (leftSide: Element, rightSide: Self) -> Self {
        var result = Self(leftSide)
        result.append(rightSide)
        return result
    }

    static func += (leftSide: inout Self, rightSide: Element) {
        leftSide.append(rightSide)
    }

    func replacingOccurrences(using dictionary: [Self: Self]) -> Self {
        var result = self
        for (key, value) in dictionary {
            result = result.replacingOccurrences(of: key, with: value)
        }
        return result
    }
}

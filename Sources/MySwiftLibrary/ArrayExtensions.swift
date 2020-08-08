//
//  ArrayExtensions.swift
//
//  Created by William J. C. Nesbitt.
//

import Foundation.NSArray

public extension Array {
    @inlinable var notEmpty: Bool { !isEmpty }
}

public extension Array where Element: Sequence {
    @inlinable static func + (leftSide: [Element], rightSide: Element) -> [Element] {
        var result = leftSide
        result.append(rightSide)
        return result
    }

    @inlinable static func += (leftSide: inout [Element], rightSide: Element) {
        leftSide.append(rightSide)
    }
}

//
//  ArrayExtensions.swift
//
//  Created by William J. C. Nesbitt.
//

import Foundation.NSArray

public extension Array {
    @inlinable var notEmpty: Bool { !isEmpty }

    // How to split an array into chunks.
    // https://www.hackingwithswift.com/example-code/language/how-to-split-an-array-into-chunks

    func chunked(into size: Index) -> [[Element]] {
        stride(from: startIndex, to: endIndex, by: size).map {
            index in
            Self(self[index ..< Swift.min(index + size, endIndex)])
        }
    }

    @inlinable static func + (leftSide: Self, rightSide: Element) -> Self {
        var result = leftSide
        result.append(rightSide)
        return result
    }

    @inlinable static func + (leftSide: Element, rightSide: Self) -> Self {
        var result = Self(arrayLiteral: leftSide)
        result.append(contentsOf: rightSide)
        return result
    }

    @inlinable static func += (leftSide: inout Self, rightSide: Element) {
        leftSide.append(rightSide)
    }
}

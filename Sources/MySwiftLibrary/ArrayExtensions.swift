//
//  ArrayExtensions.swift
//
//  Created by William J. C. Nesbitt.
//

import Foundation.NSArray

public extension Array where Element: StringProtocol {
    @available(    iOS 13,    *)
    @available(  macOS 10.15, *)
    @available(   tvOS 13,    *)
    @available(watchOS  6,    *)
    func localizedJoined() -> String {
        ListFormatter.localizedString(byJoining: self.map { String($0) })
    }
}

public extension Array {
    var notEmpty: Bool { !isEmpty }

    // How to split an array into chunks.
    // https://www.hackingwithswift.com/example-code/language/how-to-split-an-array-into-chunks

    func chunked(into size: Index) -> [[Element]] {
        stride(from: startIndex, to: endIndex, by: size).map {
            index in
            Self(self[index ..< Swift.min(index + size, endIndex)])
        }
    }

    static func + (leftSide: Self, rightSide: Element) -> Self {
        var result = leftSide
        result.append(rightSide)
        return result
    }

    static func + (leftSide: Element, rightSide: Self) -> Self {
        var result = Self(arrayLiteral: leftSide)
        result.append(contentsOf: rightSide)
        return result
    }

    static func += (leftSide: inout Self, rightSide: Element) {
        leftSide.append(rightSide)
    }
}

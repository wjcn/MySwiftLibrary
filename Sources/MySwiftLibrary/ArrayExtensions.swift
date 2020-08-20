//
//  ArrayExtensions.swift
//
//  Created by William J. C. Nesbitt.
//

import Foundation.NSArray

extension Array where Element: StringProtocol {
    @available(*, deprecated, renamed: "localizedJoined")
    @available(iOS 13, macOS 10.15, tvOS 13, watchOS 6, *)
    @inlinable public func localizedStringByJoining() -> String {
        ListFormatter.localizedString(byJoining: self.map {
            (element: Element) in
            String(element)
        })
    }
}

extension Array {
    @inlinable public var notEmpty: Bool { !isEmpty }

    // How to split an array into chunks.
    // https://www.hackingwithswift.com/example-code/language/how-to-split-an-array-into-chunks

    @inlinable public func chunked(into size: Index) -> [Array] {
        stride(from: startIndex, to: endIndex, by: size).map {
            (index: Index) in
            Array(self[index ..< Swift.min(index + size, endIndex)])
        }
    }

    @inlinable public static func + (array: Array, element: Element) -> Array {
        var result = array
        result.append(element)
        return result
    }

    @inlinable public static func + (element: Element, array: Array) -> Array {
        var result = Array(arrayLiteral: element)
        result.append(contentsOf: array)
        return result
    }

    @inlinable public static func += (array: inout Array, element: Element) {
        array.append(element)
    }

    @inlinable public mutating func sort<T>(by keyPath: KeyPath<Element, T>,
                                            comparison areInIncreasingOrder: (_ leftSide:  T,
                                                                              _ rightSide: T) throws -> Bool) rethrows {
        try sort(by: {
            (leftSide: Element, rightSide: Element) in
            try areInIncreasingOrder(leftSide[keyPath: keyPath], rightSide[keyPath: keyPath])
        })
    }

    @inlinable public func sorted<T>(by keyPath: KeyPath<Element, T>,
                                     comparison areInIncreasingOrder: (_ leftSide:  T,
                                                                       _ rightSide: T) throws -> Bool) rethrows -> Array {
        try sorted(by: {
            (leftSide: Element, rightSide: Element) in
            try areInIncreasingOrder(leftSide[keyPath: keyPath], rightSide[keyPath: keyPath])
        })
    }
}

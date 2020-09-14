//
//  ArrayExtensions.swift
//
//  Created by William J. C. Nesbitt.
//  Copyright © 2020 William J. C. Nesbitt. All rights reserved.
//

import Foundation.NSArray

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

    @inlinable public static func + (array:   Array,
                                     element: Element) -> Array {
        var result = array
        result.append(element)
        return result
    }

    @inlinable public static func + (element: Element,
                                     array: Array) -> Array {
        var result = Array(arrayLiteral: element)
        result.append(contentsOf: array)
        return result
    }

    @inlinable public static func += (array: inout Array,
                                      element: Element) {
        array.append(element)
    }

    @available(*, deprecated, renamed: "localizedStringByJoining")
    @available(iOS 13, macOS 10.15, tvOS 13, watchOS 6, *)
    @inlinable public func localizedJoined() -> String where Element: StringProtocol {
        localizedStringByJoining()
    }

    @available(iOS 13, macOS 10.15, tvOS 13, watchOS 6, *)
    @inlinable public func localizedStringByJoining() -> String where Element: StringProtocol {
        ListFormatter.localizedString(byJoining: self.map {
            (element: Element) in
            String(element)
        })
    }

    @inlinable public mutating func sort<T>(
        by keyPath: KeyPath<Element, T>,
        comparison areInIncreasingOrder: (
            _ leftSide:  T,
            _ rightSide: T
        ) throws -> Bool
    ) rethrows {
        try sort(by: {
            (leftSide: Element, rightSide: Element) in
            try areInIncreasingOrder(
                leftSide [keyPath: keyPath],
                rightSide[keyPath: keyPath]
            )
        })
    }

    @inlinable public func sorted<T>(
        by keyPath: KeyPath<Element, T>,
        comparison areInIncreasingOrder: (
            _ leftSide:  T,
            _ rightSide: T
        ) throws -> Bool
    ) rethrows -> Array {
        try sorted(by: {
            (leftSide: Element, rightSide: Element) in
            try areInIncreasingOrder(
                leftSide [keyPath: keyPath],
                rightSide[keyPath: keyPath]
            )
        })
    }

    @inlinable public mutating func sort<T>(
        by keyPath: KeyPath<Element, T>,
        ordered:    ComparisonResult      = .orderedAscending,
        options:    String.CompareOptions = [],
        range:      Range<String.Index>?  = nil,
        locale:     Locale?               = nil,
        comparison: (
            _ leftSide:  T,
            _ rightSide: T,
            _ options:   String.CompareOptions,
            _ range:     Range<String.Index>?,
            _ locale:    Locale?
        ) -> ComparisonResult = compare
    ) where T: StringProtocol {
        sort(by: {
            (leftSide: Element, rightSide: Element) in
            comparison(
                leftSide [keyPath: keyPath],
                rightSide[keyPath: keyPath],
                options, range, locale
            ) == ordered
        })
    }

    @inlinable public func sorted<T>(
        by keyPath: KeyPath<Element, T>,
        ordered:    ComparisonResult      = .orderedAscending,
        options:    String.CompareOptions = [],
        range:      Range<String.Index>?  = nil,
        locale:     Locale?               = nil,
        comparison: (
            _ leftSide:  T,
            _ rightSide: T,
            _ options:   String.CompareOptions,
            _ range:     Range<String.Index>?,
            _ locale:    Locale?
        ) -> ComparisonResult = compare
    ) -> Array where T: StringProtocol {
        sorted(by: {
            (leftSide: Element, rightSide: Element) in
            comparison(
                leftSide [keyPath: keyPath],
                rightSide[keyPath: keyPath],
                options, range, locale
            ) == ordered
        })
    }

    @inlinable public static func compare<T>(
        _ leftSide:  T,
        _ rightSide: T,
        _ options:   String.CompareOptions,
        _ range:     Range<String.Index>?,
        _ locale:    Locale?
    ) -> ComparisonResult where T: StringProtocol {
        leftSide.compare(rightSide,
                         options: options,
                         range:   range,
                         locale:  locale)
    }
}

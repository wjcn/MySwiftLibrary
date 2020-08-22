//
//  ArrayExtensions.swift
//
//  Created by William J. C. Nesbitt.
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

    @available(*, deprecated, renamed: "localizedJoined")
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
        _ ordered:  ComparisonResult,
        _ options:  String.CompareOptions = [
            .caseInsensitive,
            .diacriticInsensitive,
            .forcedOrdering,
            .numeric,
            .widthInsensitive
        ],
        range:      Range<String.Index>?  = nil,
        locale:     Locale?               = nil,
        comparison: (
            _ leftSide:  T,
            _ rightSide: T,
            _ options:   String.CompareOptions,
            _ range:     Range<String.Index>?,
            _ locale:    Locale?
        ) throws -> ComparisonResult = compare
    ) rethrows where T: StringProtocol {
        try sort(by: {
            (leftSide: Element, rightSide: Element) in
            try comparison(
                leftSide [keyPath: keyPath],
                rightSide[keyPath: keyPath],
                options, range, locale
            ) == ordered
        })
    }

    @inlinable public func sorted<T>(
        by keyPath: KeyPath<Element, T>,
        _ ordered:  ComparisonResult,
        _ options:  String.CompareOptions = [
            .caseInsensitive,
            .diacriticInsensitive,
            .forcedOrdering,
            .numeric,
            .widthInsensitive
        ],
        range:      Range<String.Index>?  = nil,
        locale:     Locale?               = nil,
        comparison: (
            _ leftSide:  T,
            _ rightSide: T,
            _ options:   String.CompareOptions,
            _ range:     Range<String.Index>?,
            _ locale:    Locale?
        ) throws -> ComparisonResult = compare
    ) rethrows -> Array where T: StringProtocol {
        try sorted(by: {
            (leftSide: Element, rightSide: Element) in
            try comparison(
                leftSide [keyPath: keyPath],
                rightSide[keyPath: keyPath],
                options, range, locale
            ) == ordered
        })
    }
}

@inlinable public func compare<T>(
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

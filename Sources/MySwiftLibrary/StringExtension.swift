//
//  StringExtension.swift
//
//  Created by William J. C. Nesbitt.
//

import Foundation.NSString

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

@available(*, deprecated)
@inlinable public func insensitiveCompareOrderedAscending<T>(
    _ leftSide:  T,
    _ rightSide: T
) -> Bool where T: StringProtocol {
    insensitiveCompare(.orderedAscending, leftSide, rightSide)
}

@available(*, deprecated)
@inlinable public func insensitiveCompareOrderedDescending<T>(
    _ leftSide:  T,
    _ rightSide: T
) -> Bool where T: StringProtocol {
    insensitiveCompare(.orderedDescending, leftSide, rightSide)
}

@available(*, deprecated)
@inlinable public func insensitiveCompare<T>(
    _ ordered:   ComparisonResult,
    _ leftSide:  T,
    _ rightSide: T
) -> Bool where T: StringProtocol {
    leftSide.compare(rightSide,
                     options: [.caseInsensitive,
                               .diacriticInsensitive,
                               .widthInsensitive]) == ordered
}

extension String {
    @inlinable public var notEmpty: Bool { !isEmpty }

    @inlinable public static func + (string:  String,
                                     element: Element) -> String {
        var result = string
        result.append(element)
        return result
    }

    @inlinable public static func + (element: Element,
                                     string:  String) -> String {
        var result = String(element)
        result.append(string)
        return result
    }

    @inlinable public static func += (string: inout String,
                                      element: Element) {
        string.append(element)
    }

    @inlinable public func replacingOccurrences<Target,
                                                Replacement>(
        dictionary: [Target: Replacement],
        options:     CompareOptions = [],
        range:       Range<Index>?  = nil
    ) -> String where Target:      StringProtocol,
                      Replacement: StringProtocol {
        var result = self
        for (target, replacement) in dictionary {
            result = result.replacingOccurrences(
                of: target,
                with: replacement,
                options: options,
                range: range
            )
        }
        return result
    }

    @inlinable public mutating func trimCharacters(
        in characterSet: CharacterSet
    ) {
        self = self.trimmingCharacters(in: characterSet)
    }
}

//
//  StringExtension.swift
//
//  Created by William J. C. Nesbitt.
//

import Foundation.NSString

@inlinable public func insensitiveCompareOrderedAscending<T>(_ leftSide: T,
                                                             _ rightSide: T) -> Bool where T: StringProtocol {
    leftSide.compare(rightSide,
                     options: [.caseInsensitive,
                               .diacriticInsensitive,
                               .widthInsensitive]) == .orderedAscending
}

@inlinable public func insensitiveCompareOrderedDescending<T>(_ leftSide: T,
                                                              _ rightSide: T) -> Bool where T: StringProtocol {
    leftSide.compare(rightSide,
                     options: [.caseInsensitive,
                               .diacriticInsensitive,
                               .widthInsensitive]) == .orderedDescending
}

extension String {
    @inlinable public var notEmpty: Bool { !isEmpty }

    @inlinable public static func + (leftSide: String, rightSide: Element) -> String {
        var result = leftSide
        result.append(rightSide)
        return result
    }

    @inlinable public static func + (leftSide: Element, rightSide: String) -> String {
        var result = String(leftSide)
        result.append(rightSide)
        return result
    }

    @inlinable public static func += (leftSide: inout String, rightSide: Element) {
        leftSide.append(rightSide)
    }

    @inlinable public func replacingOccurrences<Target,
                                                Replacement>(dictionary: [Target: Replacement],
                                                             options:     CompareOptions = [],
                                                             range:       Range<Index>?  = nil) -> String where Target:      StringProtocol,
                                                                                                                Replacement: StringProtocol {
        var result = self
        for (target, replacement) in dictionary {
            result = result.replacingOccurrences(of: target, with: replacement, options: options, range: range)
        }
        return result
    }

    @inlinable public mutating func trimCharacters(in characterSet: CharacterSet) {
        self = self.trimmingCharacters(in: characterSet)
    }
}

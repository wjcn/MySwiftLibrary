//
//  FormatDatesTimes.swift
//
//  Created by William J. C. Nesbitt.
//

import Foundation.NSDate

public extension Date {
    @inlinable func `as`(_ dateStyle: DateFormatter.Style = .none,
                           timeStyle: DateFormatter.Style = .none) -> String {
        DateFormatter.localizedString(from: self, dateStyle: dateStyle, timeStyle: timeStyle)
    }
}

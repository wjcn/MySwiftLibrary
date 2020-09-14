//
//  FormatDatesTimes.swift
//
//  Created by William J. C. Nesbitt.
//  Copyright © 2020 William J. C. Nesbitt. All rights reserved.
//

import Foundation.NSDateFormatter

extension Date {
    @inlinable public func `as`(_ dateStyle: DateFormatter.Style = .none,
                                  timeStyle: DateFormatter.Style = .none) -> String {
        DateFormatter.localizedString(from: self, dateStyle: dateStyle, timeStyle: timeStyle)
    }
}

//
//  CIFilterExtension.swift
//
//  Created by William J. C. Nesbitt.
//

import CoreImage.CIFilter

public extension CIFilter {
    @inlinable var localisedName: String { Self.localizedName(forFilterName: name)! }
}

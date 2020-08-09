//
//  CIFilterExtension.swift
//
//  Created by William J. C. Nesbitt.
//

#if !os(watchOS)
import CoreImage.CIFilter

public extension CIFilter {
    @inlinable var localisedName: String { Self.localizedName(forFilterName: name)! }
}
#endif

//
//  CIFilterExtension.swift
//
//  Created by William J. C. Nesbitt.
//

#if !os(watchOS)
import CoreImage.CIFilter

extension CIFilter {
    @inlinable public var localisedName: String { Self.localizedName(forFilterName: name)! }
}
#endif

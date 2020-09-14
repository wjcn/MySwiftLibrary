//
//  CIFilterExtension.swift
//
//  Created by William J. C. Nesbitt.
//  Copyright © 2020 William J. C. Nesbitt. All rights reserved.
//

#if !os(watchOS)
import CoreImage.CIFilter

extension CIFilter {
    @inlinable public var localisedName: String { Self.localizedName(forFilterName: name)! }
}
#endif

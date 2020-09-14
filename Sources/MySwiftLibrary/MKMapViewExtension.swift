//
//  MKMapViewExtension.swift
//
//  Created by William J. C. Nesbitt.
//  Copyright © 2020 William J. C. Nesbitt. All rights reserved.
//

#if !os(watchOS)
import MapKit.MKMapView

@available(tvOS 9.2, *)
extension MKMapView {
    @inlinable public func removeAllAnnotations() {
        removeAnnotations(annotations)
    }
}
#endif

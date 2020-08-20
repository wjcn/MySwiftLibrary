//
//  MKMapViewExtension.swift
//
//  Created by William J. C. Nesbitt.
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

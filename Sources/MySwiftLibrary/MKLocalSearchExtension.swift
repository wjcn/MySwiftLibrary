//
//  MKLocalSearchExtension.swift
//
//  Created by William J. C. Nesbitt.
//  Copyright © 2020 William J. C. Nesbitt. All rights reserved.
//

#if !os(watchOS)
import MapKit.MKLocalSearch

@available(tvOS 9.2, *)
extension MKLocalSearch {
    // The completion handler does not seem to be executed on
    // the main queue even though the documentation says otherwise.
    @inlinable public func start(
        queue: DispatchQueue         = .main,
        group: DispatchGroup?        =  nil,
        qos:   DispatchQoS           = .unspecified,
        flags: DispatchWorkItemFlags = [],
        completionHandler: @escaping (Result<Response, Error>) -> Void
    ) {
        start(completionHandler: {
            (response: Response?, error: Error?) in
            if let response = response, error == nil {
                queue.async(
                    group: group, qos: qos, flags: flags,
                    execute: {
                        completionHandler(.success(response))
                    })
            } else if response == nil, let error = error {
                queue.async(
                    group: group, qos: qos, flags: flags,
                    execute: {
                        completionHandler(.failure(error))
                    })
            } else {
                fatalError() // This should not happen.
            }
        })
    }
}
#endif

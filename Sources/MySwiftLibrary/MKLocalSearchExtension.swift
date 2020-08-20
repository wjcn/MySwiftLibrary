//
//  MKLocalSearchExtension.swift
//
//  Created by William J. C. Nesbitt.
//

#if !os(watchOS)
import MapKit.MKLocalSearch

@available(tvOS 9.2, *)
extension MKLocalSearch {
    public typealias ResultBasedCompletionHandler = (Result<Response, Error>) -> Void

    // The completion handler does not seem to be executed on
    // the main queue even though the documentation says otherwise.
    @inlinable public func start(queue:             DispatchQueue = .main,
                                 with parameters:   DispatchParameters3 = .defaults,
                                 completionHandler: @escaping ResultBasedCompletionHandler) {
        start(completionHandler: {
            (response: Response?, error: Error?) in
            if let response = response, error == nil {
                queue.async(with: parameters, execute: {
                    completionHandler(.success(response))
                })
                return
            }
            if response == nil, let error = error {
                queue.async(with: parameters, execute: {
                    completionHandler(.failure(error))
                })
                return
            }
            fatalError() // This should not happen.
        })
    }
}
#endif

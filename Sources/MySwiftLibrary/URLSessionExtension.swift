//
//  URLSessionExtension.swift
//
//  Created by William J. C. Nesbitt.
//

import Foundation.NSURLSession

extension URLSession {
    public typealias ResultBasedCompletionHandler = (Result<(Data, URLResponse?), Error>) -> Void

    @inlinable public func dataTask(with url: URL,
                                    queue: DispatchQueue = .main,
                                    with parameters: DispatchParameters3 = .defaults,
                                    completionHandler: @escaping ResultBasedCompletionHandler) {
        dataTask(with: url, completionHandler: {
            (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data, error == nil {
                queue.async(with: parameters, execute: {
                    completionHandler(.success((data, response)))
                })
                return
            }
            if data == nil, let error = error {
                queue.async(with: parameters, execute: {
                    completionHandler(.failure(error))
                })
                return
            }
            fatalError() // This should not happen.
        })
    }

    @inlinable public func dataTask(with request: URLRequest,
                                    queue: DispatchQueue = .main,
                                    with parameters: DispatchParameters3 = .defaults,
                                    completionHandler: @escaping ResultBasedCompletionHandler) {
        dataTask(with: request, completionHandler: {
            (data: Data?, response: URLResponse?, error: Error?) in
            if let data = data, error == nil {
                queue.async(with: parameters, execute: {
                    completionHandler(.success((data, response)))
                })
                return
            }
            if data == nil, let error = error {
                queue.async(with: parameters, execute: {
                    completionHandler(.failure(error))
                })
                return
            }
            fatalError() // This should not happen.
        })
    }
}

//
//  URLSessionExtension.swift
//
//  Created by William J. C. Nesbitt.
//

import Foundation.NSURLSession

extension URLSession {
    @inlinable public func dataTask(with url: URL,
                                    queue: DispatchQueue = .main,
                                    with parameters: DispatchParameters3 = .defaults,
                                    completionHandler: @escaping (Result<(Data, URLResponse?), Error>) -> Void) -> URLSessionDataTask {
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
                                    completionHandler: @escaping (Result<(Data, URLResponse?), Error>) -> Void) -> URLSessionDataTask {
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

    @inlinable public func jsonTask<T>(with url: URL,
                                       decoder: JSONDecoder = JSONDecoder(),
                                       queue: DispatchQueue = .main,
                                       with parameters: DispatchParameters3 = .defaults,
                                       completionHandler: @escaping (Result<(T, URLResponse?), Error>) -> Void) -> URLSessionDataTask where T: Decodable {
        dataTask(with: url, queue: queue, with: parameters, completionHandler: {
            (result: Result<(Data, URLResponse?), Error>) in
            switch result {
                case .success(let (data, response)):
                    do {
                        let decoded = try decoder.decode(T.self, from: data)
                        queue.async(with: parameters, execute: {
                            completionHandler(.success((decoded, response)))
                        })
                    } catch {
                        queue.async(with: parameters, execute: {
                            completionHandler(.failure(error))
                        })
                    }
                case .failure(let error):
                    queue.async(with: parameters, execute: {
                        completionHandler(.failure(error))
                    })
            }
        })
    }

    @inlinable public func jsonTask<T>(with request: URLRequest,
                                       decoder: JSONDecoder = JSONDecoder(),
                                       queue: DispatchQueue = .main,
                                       with parameters: DispatchParameters3 = .defaults,
                                       completionHandler: @escaping (Result<(T, URLResponse?), Error>) -> Void) -> URLSessionDataTask where T: Decodable {
        dataTask(with: request, queue: queue, with: parameters, completionHandler: {
            (result: Result<(Data, URLResponse?), Error>) in
            switch result {
                case .success(let (data, response)):
                    do {
                        let decoded = try decoder.decode(T.self, from: data)
                        queue.async(with: parameters, execute: {
                            completionHandler(.success((decoded, response)))
                        })
                    } catch {
                        queue.async(with: parameters, execute: {
                            completionHandler(.failure(error))
                        })
                    }
                case .failure(let error):
                    queue.async(with: parameters, execute: {
                        completionHandler(.failure(error))
                    })
            }
        })
    }
}

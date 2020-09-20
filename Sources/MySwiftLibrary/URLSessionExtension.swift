//
//  URLSessionExtension.swift
//
//  Created by William J. C. Nesbitt.
//  Copyright © 2020 William J. C. Nesbitt. All rights reserved.
//

import Combine
import Foundation.NSURLSession

extension URLSession {
    public func dataTask(
        with url: URL,
        queue:    DispatchQueue         = .main,
        group:    DispatchGroup?        =  nil,
        qos:      DispatchQoS           = .unspecified,
        flags:    DispatchWorkItemFlags = [],
        completionHandler: @escaping (Result<(Data, URLResponse?), Error>) -> Void
    ) -> URLSessionDataTask {
        dataTask(
            with: url,
            completionHandler: {
                (data: Data?, response: URLResponse?, error: Error?) in
                self.commonDataTaskCompletionHandler(
                    data: data, response: response, error: error,
                    queue: queue, group: group, qos: qos, flags: flags,
                    completionHandler: completionHandler)
            })
    }

    public func dataTask(
        with request: URLRequest,
        queue:        DispatchQueue         = .main,
        group:        DispatchGroup?        =  nil,
        qos:          DispatchQoS           = .unspecified,
        flags:        DispatchWorkItemFlags = [],
        completionHandler: @escaping (Result<(Data, URLResponse?), Error>) -> Void
    ) -> URLSessionDataTask {
        dataTask(
            with: request,
            completionHandler: {
                (data: Data?, response: URLResponse?, error: Error?) in
                self.commonDataTaskCompletionHandler(
                    data: data, response: response, error: error,
                    queue: queue, group: group, qos: qos, flags: flags,
                    completionHandler: completionHandler)
            })
    }

    private func commonDataTaskCompletionHandler(
        data:     Data?,
        response: URLResponse?,
        error:    Error?,
        queue:    DispatchQueue,
        group:    DispatchGroup?,
        qos:      DispatchQoS,
        flags:    DispatchWorkItemFlags,
        completionHandler: @escaping (Result<(Data, URLResponse?), Error>) -> Void
    ) {
        switch (data, error) {
            case (let .some(data), .none):
                queue.async(
                    group: group, qos: qos, flags: flags,
                    execute: {
                        completionHandler(.success((data, response)))
                    })
            case (.none, let .some(error)):
                queue.async(
                    group: group, qos: qos, flags: flags,
                    execute: {
                        completionHandler(.failure(error))
                    })
            default:
                fatalError() // This should not happen.
        }
    }

    @available(iOS 13, macOS 10.15, tvOS 13, watchOS 6, *)
    public func codableTask<Type, Decoder>(
        with url: URL,
        decoding: Type.Type,
        decoder:  Decoder,
        queue:    DispatchQueue         = .main,
        group:    DispatchGroup?        =  nil,
        qos:      DispatchQoS           = .unspecified,
        flags:    DispatchWorkItemFlags = [],
        completionHandler: @escaping (Result<(Type, URLResponse?), Error>) -> Void
    ) -> URLSessionDataTask where Type:   Decodable,
                                  Decoder:TopLevelDecoder,
                                  Decoder.Input == Data {
        dataTask(
            with: url,
            queue: queue, group: group, qos: qos, flags: flags,
            completionHandler: {
                (result: Result<(Data, URLResponse?), Error>) in
                self.commonCodableTaskCompletionHandler(
                    result: result, decoding: decoding, decoder: decoder,
                    queue: queue, group: group, qos: qos, flags: flags,
                    completionHandler: completionHandler)
            })
    }

    @available(iOS 13, macOS 10.15, tvOS 13, watchOS 6, *)
    public func codableTask<Type, Decoder>(
        with request: URLRequest,
        decoding:     Type.Type,
        decoder:      Decoder,
        queue:        DispatchQueue         = .main,
        group:        DispatchGroup?        =  nil,
        qos:          DispatchQoS           = .unspecified,
        flags:        DispatchWorkItemFlags = [],
        completionHandler: @escaping (Result<(Type, URLResponse?), Error>) -> Void
    ) -> URLSessionDataTask where Type:   Decodable,
                                  Decoder:TopLevelDecoder,
                                  Decoder.Input == Data {
        dataTask(
            with: request,
            queue: queue, group: group, qos: qos, flags: flags,
            completionHandler: {
                (result: Result<(Data, URLResponse?), Error>) in
                self.commonCodableTaskCompletionHandler(
                    result: result, decoding: decoding, decoder: decoder,
                    queue: queue, group: group, qos: qos, flags: flags,
                    completionHandler: completionHandler)
            })
    }

    @available(iOS 13, macOS 10.15, tvOS 13, watchOS 6, *)
    private func commonCodableTaskCompletionHandler<Type, Decoder>(
        result:   Result<(Data, URLResponse?), Error>,
        decoding: Type.Type,
        decoder:  Decoder,
        queue:    DispatchQueue,
        group:    DispatchGroup?,
        qos:      DispatchQoS,
        flags:    DispatchWorkItemFlags,
        completionHandler: @escaping (Result<(Type, URLResponse?), Error>) -> Void
    ) where Type:   Decodable,
            Decoder:TopLevelDecoder,
            Decoder.Input == Data {
        switch result {
            case .success(let (data, response)):
                do {
                    let decoded = try decoder.decode(Type.self, from: data)
                    queue.async(
                        group: group, qos: qos, flags: flags,
                        execute: {
                            completionHandler(.success((decoded, response)))
                        })
                } catch {
                    queue.async(
                        group: group, qos: qos, flags: flags,
                        execute: {
                            completionHandler(.failure(error))
                        })
                }
            case .failure(let error):
                queue.async(
                    group: group, qos: qos, flags: flags,
                    execute: {
                        completionHandler(.failure(error))
                    })
        }
    }

    @available(iOS 13, macOS 10.15, tvOS 13, watchOS 6, *)
    public func jsonTask<Type>(
        with url: URL,
        decoding: Type.Type,
        decoder:  JSONDecoder           =  JSONDecoder(),
        queue:    DispatchQueue         = .main,
        group:    DispatchGroup?        =  nil,
        qos:      DispatchQoS           = .unspecified,
        flags:    DispatchWorkItemFlags = [],
        completionHandler: @escaping (Result<(Type, URLResponse?), Error>) -> Void
    ) -> URLSessionDataTask where Type: Decodable {
        codableTask(
            with: url, decoding: decoding, decoder: decoder,
            queue: queue, group: group, qos: qos, flags: flags,
            completionHandler: completionHandler)
    }

    @available(iOS 13, macOS 10.15, tvOS 13, watchOS 6, *)
    public func jsonTask<Type>(
        with request: URLRequest,
        decoding:     Type.Type,
        decoder:      JSONDecoder           =  JSONDecoder(),
        queue:        DispatchQueue         = .main,
        group:        DispatchGroup?        =  nil,
        qos:          DispatchQoS           = .unspecified,
        flags:        DispatchWorkItemFlags = [],
        completionHandler: @escaping (Result<(Type, URLResponse?), Error>) -> Void
    ) -> URLSessionDataTask where Type: Decodable {
        codableTask(
            with: request, decoding: decoding, decoder: decoder,
            queue: queue, group: group, qos: qos, flags: flags,
            completionHandler: completionHandler)
    }
}

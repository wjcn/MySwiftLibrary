//
//  URLRequestExtension.swift
//
//  Created by William J. C. Nesbitt.
//  Copyright © 2020 William J. C. Nesbitt. All rights reserved.
//

import Foundation.NSURLRequest

extension URLRequest {
    @inlinable public init<Type>(
        url: URL,
        jsonBody: Type,
        jsonEncoder: JSONEncoder = JSONEncoder(),
        cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy,
        timeoutInterval: TimeInterval = 60
    ) throws where Type: Encodable {
        self.init(url: url,
                  cachePolicy: cachePolicy,
                  timeoutInterval: timeoutInterval)
        addValue("application/json",
                 forHTTPHeaderField: "Content-Type")
        httpBody = try jsonEncoder.encode(jsonBody)
    }
}

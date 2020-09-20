//
//  LAContextExtension.swift
//
//  Created by William J. C. Nesbitt.
//  Copyright © 2020 William J. C. Nesbitt. All rights reserved.
//

#if !os(watchOS)
import LocalAuthentication.LAContext

@available(tvOS 10, *)
extension LAContext {
    @inlinable public func canEvaluatePolicy(_ policy: LAPolicy) -> Result<Any, Error> {
        var error: NSError?
        let success = canEvaluatePolicy(policy, error: &error)
        switch (success, error) {
            case (true, .none):
                return .success(true)
            case (false, let .some(error)):
                return .failure(error)
            default:
                fatalError() // This should not happen.
        }
    }

    @inlinable public func evaluatePolicy(
        _ policy:         LAPolicy,
        localizedReason:  String,
        queue:            DispatchQueue         = .main,
        group:            DispatchGroup?        = nil,
        qos:              DispatchQoS           = .unspecified,
        flags:            DispatchWorkItemFlags = [],
        reply: @escaping (Result<Any, Error>) -> Void
    ) {
        evaluatePolicy(policy, localizedReason: localizedReason) {
            (success: Bool, error: Error?) in
            switch (success, error) {
                case (true, .none):
                    queue.async(group: group, qos: qos, flags: flags, execute: {
                        reply(.success(true))
                    })
                case (false, let .some(error)):
                    queue.async(group: group, qos: qos, flags: flags, execute: {
                        reply(.failure(error))
                    })
                default:
                    fatalError() // This should not happen.
            }
        }
    }
}
#endif

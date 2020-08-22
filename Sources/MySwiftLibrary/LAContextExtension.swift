//
//  LAContextExtension.swift
//
//  Created by William J. C. Nesbitt.
//

#if !os(watchOS)
import LocalAuthentication.LAContext

@available(tvOS 10, *)
extension LAContext {
    @inlinable public func canEvaluatePolicy(_ policy: LAPolicy) -> Result<Any, Error> {
        var error: NSError?
        let success = canEvaluatePolicy(policy, error: &error)
        if success == true, error == nil {
            return .success(true)
        }
        if success == false, let error = error {
            return .failure(error)
        }
        fatalError() // This should not happen.
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
            if success == true, error == nil {
                queue.async(group: group, qos: qos, flags: flags, execute: {
                    reply(.success(true))
                })
                return
            }
            if success == false, let error = error {
                queue.async(group: group, qos: qos, flags: flags, execute: {
                    reply(.failure(error))
                })
                return
            }
            fatalError() // This should not happen.
        }
    }
}
#endif

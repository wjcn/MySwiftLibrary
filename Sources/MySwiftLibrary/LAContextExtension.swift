//
//  LAContextExtension.swift
//
//  Created by William J. C. Nesbitt.
//

#if !os(watchOS)
import LocalAuthentication.LAContext

@available(tvOS 10, *)
public extension LAContext {
    func canEvaluatePolicy(_ policy: LAPolicy) -> Result<Any, Error> {
        var error: NSError?
        if canEvaluatePolicy(policy, error: &error) {
            return .success(true)
        } else {
            return .failure(error!)
        }
    }

    func evaluatePolicy(_ policy: LAPolicy, localizedReason: String, reply: @escaping (Result<Any, Error>) -> Void) {
        evaluatePolicy(policy, localizedReason: localizedReason) {
            success, error in
            if success {
                reply(.success(true))
            } else {
                reply(.failure(error!))
            }
        }
    }
}
#endif

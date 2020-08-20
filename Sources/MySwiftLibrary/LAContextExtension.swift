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
        if canEvaluatePolicy(policy, error: &error) {
            return .success(true)
        } else {
            return .failure(error!)
        }
    }

    @inlinable public func evaluatePolicy(_ policy:        LAPolicy,
                                          localizedReason: String,
                                          queue:           DispatchQueue = .main,
                                          with parameters: DispatchParameters3 = .defaults,
                                          reply:           @escaping (Result<Any, Error>) -> Void) {
        evaluatePolicy(policy, localizedReason: localizedReason) {
            (success: Bool, error: Error?) in
            if success == true, error == nil {
                queue.async(with: parameters, execute: { reply(.success(true)) })
                return
            }
            if success == false, let error = error {
                queue.async(with: parameters, execute: { reply(.failure(error)) })
                return
            }
            fatalError() // This should not happen.
        }
    }
}
#endif

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

    func evaluatePolicy(_ policy:        LAPolicy,
                        localizedReason: String,
                        on queue:        DispatchQueue = .main,
                        with parameters: DispatchParametersMore = .defaults,
                        reply:           @escaping (Result<Any, Error>) -> Void) {
        evaluatePolicy(policy, localizedReason: localizedReason) {
            (success: Bool, error: Error?) in
            if success {
                queue.async(with: parameters, execute: { reply(.success(true))   })
            } else {
                queue.async(with: parameters, execute: { reply(.failure(error!)) })
            }
        }
    }
}
#endif

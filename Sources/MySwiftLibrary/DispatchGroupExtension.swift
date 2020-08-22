//
//  DispatchGroupExtension.swift
//
//  Created by William J. C. Nesbitt.
//

import Dispatch

@available(*, deprecated)
extension DispatchGroup {
    @inlinable public func notify(queue:           DispatchQueue = .main,
                                  with parameters: DispatchParameters2 = .defaults,
                                  execute closure: @escaping () -> Void) {
        notify(qos:     parameters.qos,
               flags:   parameters.flags,
               queue:   queue,
               execute: closure)
    }
}

//
//  DispatchQueueExtension.swift
//
//  Created by William J. C. Nesbitt on 8/18/20.
//  Copyright © 2020 William J. C. Nesbitt. All rights reserved.
//

import Dispatch

@available(*, deprecated)
extension DispatchQueue {
    @inlinable public func async(with parameters: DispatchParameters3 = .defaults,
                                 execute closure: @escaping () -> Void) {
        async(group:   parameters.group,
              qos:     parameters.qos,
              flags:   parameters.flags,
              execute: closure)
    }

    @inlinable public func asyncAfter(deadline:        DispatchTime,
                                      with parameters: DispatchParameters2 = .defaults,
                                      execute closure: @escaping () -> Void) {
        asyncAfter(deadline: deadline,
                   qos:      parameters.qos,
                   flags:    parameters.flags,
                   execute:  closure)
    }

    @inlinable public func asyncAfter(wallDeadline:    DispatchWallTime,
                                      with parameters: DispatchParameters2 = .defaults,
                                      execute closure: @escaping () -> Void) {
        asyncAfter(wallDeadline: wallDeadline,
                   qos:          parameters.qos,
                   flags:        parameters.flags,
                   execute:      closure)
    }
}

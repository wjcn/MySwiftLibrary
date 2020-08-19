//
//  DispatchQueueExtension.swift
//
//  Created by William J. C. Nesbitt on 8/18/20.
//

import Foundation

private protocol DispatchParametersProtocol3: DispatchParametersProtocol2 {
    var group: DispatchGroup? { get set }
}

private protocol DispatchParametersProtocol2 {
    var qos:   DispatchQoS           { get set }
    var flags: DispatchWorkItemFlags { get set }
}

private protocol DispatchParametersProtocol {
    static var `defaults`: Self { get }
}

public struct DispatchParameters3: DispatchParametersProtocol3, DispatchParametersProtocol {
    public static var `defaults`: Self { Self() }

    var group: DispatchGroup?
    var qos:   DispatchQoS           = .unspecified
    var flags: DispatchWorkItemFlags = []
}

public struct DispatchParameters2: DispatchParametersProtocol2, DispatchParametersProtocol {
    var qos:   DispatchQoS           = .unspecified
    var flags: DispatchWorkItemFlags = []

    public static var `defaults`: Self { Self() }
}

public extension DispatchQueue {
    func async(with parameters: DispatchParameters3 = .defaults,
               execute work:    @escaping () -> Void) {
        async(group:   parameters.group,
              qos:     parameters.qos,
              flags:   parameters.flags,
              execute: work)
    }

    func asyncAfter(deadline:        DispatchTime,
                    with parameters: DispatchParameters2 = .defaults,
                    execute work:    @escaping () -> Void) {
        asyncAfter(deadline: deadline,
                   qos:      parameters.qos,
                   flags:    parameters.flags,
                   execute:  work)
    }

    func asyncAfter(wallDeadline:    DispatchWallTime,
                    with parameters: DispatchParameters2 = .defaults,
                    execute work:    @escaping () -> Void) {
        asyncAfter(wallDeadline: wallDeadline,
                   qos:          parameters.qos,
                   flags:        parameters.flags,
                   execute:      work)
    }
}

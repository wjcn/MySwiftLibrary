//
//  DispatchParameters.swift
//
//  Created by William J. C. Nesbitt.
//

import Dispatch

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

public struct DispatchParameters3: DispatchParametersProtocol3,
                                   DispatchParametersProtocol {
    public var group: DispatchGroup?
    public var qos:   DispatchQoS
    public var flags: DispatchWorkItemFlags

    public static var `defaults`: Self { Self() }

    public init(group: DispatchGroup?        = nil,
                qos:   DispatchQoS           = .unspecified,
                flags: DispatchWorkItemFlags = []) {
        self.group = group
        self.qos   = qos
        self.flags = flags
    }
}

public struct DispatchParameters2: DispatchParametersProtocol2,
                                   DispatchParametersProtocol {
    public init(qos:   DispatchQoS           = .unspecified,
                flags: DispatchWorkItemFlags = []) {
        self.qos   = qos
        self.flags = flags
    }

    public static var `defaults`: Self { Self() }

    public var qos:   DispatchQoS
    public var flags: DispatchWorkItemFlags
}

//
//  DispatchQueueExtension.swift
//
//  Created by William J. C. Nesbitt on 8/18/20.
//

import Foundation

public protocol DispatchParametersBaseProtocol {
    var qos:   DispatchQoS           { get set }
    var flags: DispatchWorkItemFlags { get set }

    static var `defaults`: Self { get }
}

public protocol DispatchParametersMoreProtocol: DispatchParametersBaseProtocol {
    var group: DispatchGroup? { get set }
}

public struct DispatchParametersBase: DispatchParametersBaseProtocol {
    public var qos:   DispatchQoS
    public var flags: DispatchWorkItemFlags

    public static var `defaults`: Self { Self(qos: .unspecified, flags: []) }
}

public struct DispatchParametersMore: DispatchParametersMoreProtocol {
    public var group: DispatchGroup?
    public var qos:   DispatchQoS
    public var flags: DispatchWorkItemFlags

    public static var `defaults`: Self { Self(group: nil, qos: .unspecified, flags: []) }
}

public extension DispatchQueue {
    func async(with parameters: DispatchParametersMore = .defaults,
               execute work:    @escaping () -> Void) {
        async(group:   parameters.group,
              qos:     parameters.qos,
              flags:   parameters.flags,
              execute: work)
    }

    func asyncAfter(deadline:        DispatchTime,
                    with parameters: DispatchParametersBase = .defaults,
                    execute work:    @escaping () -> Void) {
        asyncAfter(deadline: deadline,
                   qos:      parameters.qos,
                   flags:    parameters.flags,
                   execute:  work)
    }

    func asyncAfter(wallDeadline:    DispatchWallTime,
                    with parameters: DispatchParametersBase = .defaults,
                    execute work:    @escaping () -> Void) {
        asyncAfter(wallDeadline: wallDeadline,
                   qos:          parameters.qos,
                   flags:        parameters.flags,
                   execute:      work)
    }
}

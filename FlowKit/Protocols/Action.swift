//
//  Action.swift
//  FlowKit
//
//  Created by Andrii Selivanov on 4/24/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation

/// Base protocol for actions that is passed to the chain of responsibility and handled by action handlers. Expected usage is to create a class conforming to that protocol and pass it around.
public protocol Action {
    
    /// Identitier of the action. Used to distinguish them and therefore should be unique for each different type of actions.
    static var id: String { get }
    
    /// Flag that shows if action should be passed through all action handlers even though it was already handled by some unit in the chain. Can be useful for actions like logout to make sure that it'll get to the parent in any case.
    static var passingThrough: Bool { get }
    
}

// MARK: - Default implementation of Action protocol. Makes it easy to create new actions without requiring implement properties all the time.
public extension Action {
    
    static var id: String {
        // Id is set to class name
        return String(describing: Self.self)
    }
    
    static var passingThrough: Bool {
        // False by default, since it's usually the case for most of the actions.
        return false
    }
    
}

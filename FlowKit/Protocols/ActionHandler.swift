//
//  ActionHandler.swift
//  FlowKit
//
//  Created by Andrii Selivanov on 4/24/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation

/// Protocol that all action handlers conform to. Action handler is one unit of the chain of responsibility implemented by flows.
public protocol ActionHandler {
    
    /// Function that is called when handler should handle an action
    ///
    /// - Parameter action: The action to handle
    func handle(action: Action) throws
    
}

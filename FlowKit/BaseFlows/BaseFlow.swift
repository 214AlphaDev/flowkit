//
//  BaseFlow.swift
//  FlowKit
//
//  Created by Andrii Selivanov on 4/24/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import UIKit

/// Base class for provided flows.
open class BaseFlow: Flow {
    
    // Required property for Flow protocol implementation
    public var nextActionHandler: WeakWrapper<ActionHandler> = WeakWrapper()
    
    /// Flow that is presented modally by this flow, if there is any, nil otherwise.
    private(set) var presentedFlow: Flow?
    
    /// Private storage for action handlers that will be invoked on specific action. Registered and removed using methods of BaseFlow class.
    private var actionHandlers: [String: (Action) throws -> Void] = [:]
    
    public init() {}
    
    // Required function for Flow protocol implementation
    open func prepareToStart() {
        // Do nothing
    }
    
    // Required function for Flow protocol implementation
    open func rootViewController() -> UIViewController {
        fatalError("You should override rootViewController method which is not implemented on BaseFlow")
    }
    
    // Required function for ActionHandler protocol implementation
    public func handle(action: Action) throws {
        let actionType = type(of: action)
        
        // Finding the corresponding handler
        if let handler = actionHandlers[actionType.id] {
            try handler(action)

            // Checking if action should be passed to the next handler even after it's already handled. Check the documentation for `passingThrough` property for more details.
            if !actionType.passingThrough {
                return
            }
        }
        
        try nextActionHandler.wrapped?.handle(action: action)
    }
    
    /// Registers closure to perform on handling specific action type. It **does not** append action handler in case one for specified action is already in place. It will be **replaced** with new one instead.
    ///
    /// - Parameters:
    ///   - actionType: Action type to handle.
    ///   - perform: Closure to invoke on the action.
    /// - Returns: Object itself to make chaining possible
    @discardableResult public func on<T: Action>(_ actionType: T.Type, perform: @escaping (T) throws -> Void) -> Self {
        actionHandlers[actionType.id] = { (action: Action) throws in
            try perform(action as! T)
        }
        
        return self
    }
    
    /// Removes action handler for specified action type.
    ///
    /// - Parameter actionType: Action type to remove handler for.
    public func removeActionHandler<T: Action>(for actionType: T.Type) {
        actionHandlers.removeValue(forKey: actionType.id);
    }
    
    /// Removes all action handlers.
    public func removeAllActionHandlers() {
        actionHandlers.removeAll()
    }
    
    /// Presents flow modally from this flow.
    ///
    /// - Parameters:
    ///   - flow: Flow to present.
    ///   - animated: Flag if presenting should be animated.
    ///   - completion: Closure to invoke when presentation animation is done.
    public func present(_ flow: Flow, animated: Bool, completion: (() -> Void)? = nil) throws {
        if let presentedFlow = self.presentedFlow {
            throw FlowPresentationError.anotherFlowAlreadyPresented(flow: presentedFlow)
        }
        
        self.presentedFlow = flow
        
        flow.prepareToStart()
        flow.nextActionHandler = WeakWrapper(self)
        
        rootViewController().present(flow.rootViewController(), animated: animated, completion: completion)
    }
    
    /// Dismiss modally presented flow.
    public func dismissPresenterFlow(animated: Bool) {
        if presentedFlow == nil {
            // Nothing to dismiss
            return
        }
        self.presentedFlow = nil
        
        rootViewController().dismiss(animated: animated, completion: nil)
    }
    
}

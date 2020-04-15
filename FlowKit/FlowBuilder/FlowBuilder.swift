//
//  FlowBuilder.swift
//  FlowKit
//
//  Created by Andrii Selivanov on 5/6/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation

/// Class designed to provide building functionality for flows. Allows to compose flows together, register actions, setup the navigation and so on in a chainable manner.
public class FlowBuilder<RootFlowType: BaseFlow> {
    
    /// Root flow of the builder.
    public let rootFlow: RootFlowType
    
    /// Creates the builder.
    ///
    /// - Parameter rootFlow: Flow which builder will start from.
    public init(rootFlow: RootFlowType) {
        self.rootFlow = rootFlow
    }
    
    /// Registers a handler to invoke on specfic action type.
    ///
    /// - Parameters:
    ///   - actionType: Action type of action to handle.
    ///   - perform: Handler to invoke.
    /// - Returns: Self for chaining purpose.
    @discardableResult public func on<T: Action>(_ actionType: T.Type, perform: @escaping (RootFlowType, T) throws -> Void) -> FlowBuilder<RootFlowType> {
        rootFlow.on(actionType) { [weak rootFlow] action throws in
            guard let rootFlow = rootFlow else { return }
            
            try perform(rootFlow, action)
        }
        
        return self
    }
    
    /// Registers pushing the flow returned by **build** closure on action of **actionType**
    ///
    /// - Parameters:
    ///   - actionType: Action type to register the push for.
    ///   - build: Builder for flow to push.
    /// - Returns: Self for chaining purpose.
    @discardableResult public func push<T: Action>(on actionType: T.Type, build: @escaping (RootFlowType, T) -> Flow) -> FlowBuilder<RootFlowType> {
        guard let pushPopFlow = rootFlow as? PushPopNavigationFlow else {
            return self
        }
        
        rootFlow.on(T.self) { [weak pushPopFlow, weak rootFlow] action in
            guard let pushPopFlow = pushPopFlow, let rootFlow = rootFlow else { return }
            
            pushPopFlow.pushFlow(build(rootFlow, action))
        }
        
        return self
    }
    
    /// Registers popping the flow of type **FlowType**.
    ///
    /// - Parameter subflowType: Type of flow to register pop action for.
    /// - Returns: Self for chaining purpose.
    @discardableResult public func pop<FlowType>(_ subflowType: FlowType.Type) -> FlowBuilder<RootFlowType> {
        guard let pushPopFlow = rootFlow as? PushPopNavigationFlow else {
            return self
        }
        
        rootFlow.on(PopAction<FlowType>.self) { [weak pushPopFlow] action in
            guard let pushPopFlow = pushPopFlow else { return }
            
            if pushPopFlow.topFlow is FlowType {
                pushPopFlow.popFlow()
            }
        }
        
        return self
    }
    
}

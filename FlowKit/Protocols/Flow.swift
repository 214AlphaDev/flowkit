//
//  Flow.swift
//  FlowKit
//
//  Created by Andrii Selivanov on 4/23/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import UIKit

/// Protocol that all flows should conform to.
public protocol Flow: class, ActionHandler {
    
    /// Function that is called before rootViewController is requested. Can be used to do any preparation needed.
    func prepareToStart()
    
    /// Function that is called when flow is displayed on a screen.
    ///
    /// - Returns: The root view contoller that represents start of the flow
    func rootViewController() -> UIViewController
    
    /// Link to next action handler in chain of responsibility. It uses WeakWrapper to make sure that we don't have a strong reference to object above in hierarchy. 
    var nextActionHandler: WeakWrapper<ActionHandler> { get set }
    
}


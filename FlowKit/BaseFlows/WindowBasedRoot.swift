//
//  WindowBasedRoot.swift
//  FlowKit
//
//  Created by Andrii Selivanov on 5/5/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import UIKit

/// Class that is designed to be a parent of all navigation. It gets the window and shows its subflows right inside that window by setting a rootViewController. It holds a reference to the flow that is currently shown.
open class WindowBasedRoot: ActionHandler {
    
    /// Window instance
    public let window: UIWindow
    /// Flow that is currently should on the window.
    public private(set) var currentFlow: Flow?
    
    public init(window: UIWindow) {
        self.window = window
    }
    
    open func handle(action: Action) throws {
        // It's supposed to be a root of action handler chain

        if !type(of: action).passingThrough {
            // If action was not passed there intentionally using `passingThrough` property it wasn't handled properly
            
            print("[FlowKit] Unhandled action passed to the root - ", String(describing: action))
        }
    }
    
    /// Shows a flow on the window.
    ///
    /// - Parameter flow: Flow to show.
    public func showFlow(_ flow: Flow) {
        flow.nextActionHandler = WeakWrapper(self)
        flow.prepareToStart()
        currentFlow = flow
        window.rootViewController = flow.rootViewController()
    }
    
}

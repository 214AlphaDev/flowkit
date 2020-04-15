//
//  ContainerFlow.swift
//  FlowKit
//
//  Created by Andrii Selivanov on 6/23/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import UIKit

/// Flow that can show children inside its view controller. It may be useful, for example, when you need to change display different flows based on some conditions.
open class ContainerFlow: BaseFlow {
    
    private let viewController: UIViewController
    private var childFlow: Flow?
    
    public init(viewController: UIViewController) {
        self.viewController = viewController
        
        super.init()
    }
    
    public func setChildFlow(_ flow: Flow) {
        if let childVC = childFlow?.rootViewController() {
            // Remove previous child
            childVC.willMove(toParent: nil)
            childVC.removeFromParent()
            childVC.view.removeFromSuperview()
        }
        
        self.childFlow = flow
        flow.nextActionHandler = WeakWrapper(self)
        flow.prepareToStart()
        
        // Add new child
        let child = flow.rootViewController()
        viewController.view.addSubview(child.view)
        viewController.addChild(child)
        child.didMove(toParent: viewController)
    }
    
    override open func rootViewController() -> UIViewController {
        return viewController
    }
    
}

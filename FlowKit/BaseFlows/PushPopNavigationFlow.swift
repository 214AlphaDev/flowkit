//
//  PushPopNavigationFlow.swift
//  FlowKit
//
//  Created by Andrii Selivanov on 4/23/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import UIKit

/// Flow that uses navigation controller to provide push/pop navigation
/// **IMPORTANT**: It uses delegate of navigation controller, which is needed for correct work. Don't set it yourself.
open class PushPopNavigationFlow: BaseFlow {
    
    /// Navigation controller that is used by that flow. **IMPORTANT**: Flow sets the delegate of that navigation controller, which means you shouldn't deal set that delegate yourself.
    public let navigationController: UINavigationController
    
    /// Root flow to show as a root of navigation controller.
    private(set) public var rootFlow: Flow
    
    /// Subflows shown above rootFlow.
    public private(set) var subflows: [Flow] = []
    
    /// Top flow displayed on the navigation controller.
    public var topFlow: Flow {
        return subflows.last ?? rootFlow
    }
    private let navigationControllerDelegate = NavigationControllerDelegate()
    
    /// Initializes PushPopNavigationFlow.
    ///
    /// - Parameters:
    ///   - navigationController: Navigation controller to be used as a root. **IMPORTANT** Don't set the delegate of navigation controller, it will be overwritten by flow anyway.
    ///   - rootFlow: Root flow to show as a root in navigation controller.
    public init(navigationController: UINavigationController, rootFlow: Flow) {
        self.navigationController = navigationController
        self.rootFlow = rootFlow
        
        super.init()
        
        navigationController.delegate = navigationControllerDelegate
        navigationControllerDelegate.onPop = { [weak self] in
            self?.applyPopNavigation()
        }
        rootFlow.nextActionHandler = WeakWrapper(self)
    }
    
    override open func rootViewController() -> UIViewController {
        return navigationController
    }
    
    override open func prepareToStart() {
        rootFlow.prepareToStart()
        
        navigationController.viewControllers = [rootFlow.rootViewController()]
        subflows = []
    }
    
    public func setRootFlow(_ flow: Flow) {
        self.rootFlow = flow
        
        prepareToStart()
    }
    
    /// Pushes the flow into the navigation.
    ///
    /// - Parameter flow: Flow to push.
    ///   - animated: Flag if push should be animated.
    public func pushFlow(_ flow: Flow, animated: Bool = true) {
        // It's important to set it before topFlow changed, to not make it nextActionHandler for itself
        flow.nextActionHandler = WeakWrapper(topFlow)
        subflows.append(flow)
        flow.prepareToStart()

        navigationController.pushViewController(flow.rootViewController(), animated: animated)
    }
    
    /// Pops the top flow (if there is any) from navigation.
    ///
    /// - Parameter animated: Flag if pop should be animated.
    public func popFlow(animated: Bool = true) {
        if subflows.isEmpty {
            // Nothing to pop out.
            return
        }
        
        navigationController.popViewController(animated: animated)
        // Subflows will be updated accordingly in the applyUserInitiatedPop function after pop animation is done.
    }
    
    /// Keeps subflows array consistent after the pop animation ends. It's needed because pop can be initiated by user, e.g. by pressing back button or interactive edge swipe gesture.
    private func applyPopNavigation() {
        if subflows.isEmpty {
            return
        }
        
        subflows.removeLast()
    }
    
}

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
    
    var onPop: (() -> Void)?
    private var lastViewControllersCount = 0
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if navigationController.viewControllers.count < lastViewControllersCount {
            onPop?()
        }
        
        lastViewControllersCount = navigationController.viewControllers.count
    }
    
}

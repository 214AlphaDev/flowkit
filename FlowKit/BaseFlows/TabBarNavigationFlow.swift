//
//  TabBarNavigationFlow.swift
//  FlowKit
//
//  Created by Andrii Selivanov on 4/24/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import UIKit

/// Flow that is designed to handle tab bar based navigation. It shows subflows as a tabs on tab bar.
open class TabBarNavigationFlow: BaseFlow {
    
    /// Root tab bar. Pass in the custom class if you want to adjust
    public let tabBarController: UITabBarController
    /// Array of items which are shown under the tabs.
    public let tabBarItems: [TabBarItemProtocol]
    
    public init(tabBarController: UITabBarController, tabBarItems: [TabBarItemProtocol]) {
        self.tabBarController = tabBarController
        self.tabBarItems = tabBarItems
        
        super.init()
        
        tabBarItems.forEach {
            $0.flow.nextActionHandler = WeakWrapper(self)
        }
    }
    
    override open func prepareToStart() {
        tabBarItems
            .filter { $0.shouldBeShown() }
            .forEach { $0.flow.prepareToStart() }
        
        self.setTabsWithAllowedSubflows()
    }
    
    /// Updates which tabs are shown on the tab bar based on which flows return isAllowed equals to true
    private func setTabsWithAllowedSubflows() {
        tabBarController.viewControllers = tabBarItems
            .filter { $0.shouldBeShown() }
            .map { $0.flow.rootViewController() }
    }
    
    /// Updates which tabs are shown on the tab bar based on which flows return isAllowed equals to true
    public func updateSubflowsDisplaying() {
        prepareToStart()
    }
    
    override open func rootViewController() -> UIViewController {
        return tabBarController
    }
    
}

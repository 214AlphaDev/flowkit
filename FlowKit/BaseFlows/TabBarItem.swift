//
//  TabBarItem.swift
//  FlowKit
//
//  Created by Andrii Selivanov on 5/12/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation

public class TabBarItem: TabBarItemProtocol {
    
    let shouldBeShownClosure: () -> Bool
    public let flow: Flow
    
    public init(flow: Flow, shouldBeShown: @escaping () -> Bool) {
        self.shouldBeShownClosure = shouldBeShown
        self.flow = flow
    }
    
    public func shouldBeShown() -> Bool {
        return shouldBeShownClosure()
    }
    
    
}

//
//  WrapperFlow.swift
//  FlowKit
//
//  Created by Andrii Selivanov on 6/23/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import UIKit

/// Flow that contains single flow and mimics its behaviour. It may be useful, for example, when you need to extend functionality of some flow.
open class WrapperFlow: BaseFlow {
    
    public let baseFlow: Flow
    
    public init(flow: Flow) {
        self.baseFlow = flow
        
        super.init()
        
        baseFlow.nextActionHandler = WeakWrapper(self)
    }
    
    override open func prepareToStart() {
        baseFlow.prepareToStart()
    }
    
    override open func rootViewController() -> UIViewController {
        return baseFlow.rootViewController()
    }
    
}

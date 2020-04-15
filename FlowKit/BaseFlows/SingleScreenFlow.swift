//
//  SingleScreenFlow.swift
//  FlowKit
//
//  Created by Andrii Selivanov on 4/23/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import UIKit

/// Flow that contains single presenter. It's the only provided at the moment which works with presenters, which means that all presenters should be wrapped into the single screen flow in order to be shown using the FlowKit.
open class SingleScreenFlow: BaseFlow {
    
    /// Name basePresenter is chosen to not take `presenter` name. It's left to use in subclass for computed property that casts basePresenter into specific type
    public let basePresenter: Presenter
    
    public init(presenter: Presenter) {
        self.basePresenter = presenter
    }
    
    override open func prepareToStart() {
        // Do any preparation if needed
        (basePresenter as? Cleanable)?.cleanUp()
    }
    
    override open func rootViewController() -> UIViewController {
        return basePresenter.viewController
    }
    
}

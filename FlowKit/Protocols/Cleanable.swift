//
//  Cleanable.swift
//  FlowKit
//
//  Created by Andrii Selivanov on 4/24/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation

/// Protocol for objects that can be cleaned up. Used for presenters that saves state across displaying, but may have some part that should be cleaned up.
public protocol Cleanable {
    
    /// Function that is called when object should do the clean up.
    func cleanUp()
    
}

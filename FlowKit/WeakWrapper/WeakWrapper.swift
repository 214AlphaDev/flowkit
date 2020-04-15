//
//  WeakWrapper.swift
//  FlowKit
//
//  Created by Andrii Selivanov on 4/23/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation

/// Class to provide a "force" weak behaviour of values that should be weak, but can't be specified as such on protocols.
public struct WeakWrapper<T> {
    
    private weak var privateWrapped: AnyObject?
    
    /// Value wrapped by this wrapped.
    public private(set) var wrapped: T? {
        get { return privateWrapped as? T }
        set { privateWrapped = newValue as AnyObject }
    }
    
    public init(_ wrapped: T? = nil) {
        self.wrapped = wrapped
    }
    
}


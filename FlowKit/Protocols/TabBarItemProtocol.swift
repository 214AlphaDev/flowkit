//
//  TabBarItemProtocol.swift
//  FlowKit
//
//  Created by Andrii Selivanov on 4/23/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation

public protocol TabBarItemProtocol {
    
    var flow: Flow { get }
    
    /// Function that is called by tab bar flow to check if this flow should be shown. Tab bar flow will generate list of tabs based on these values for each flow.
    ///
    /// - Returns: True if flow should be shown, false otherwise
    func shouldBeShown() -> Bool
    
}

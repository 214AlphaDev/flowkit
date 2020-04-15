//
//  Errors.swift
//  FlowKit
//
//  Created by Andrii Selivanov on 5/8/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation

enum FlowPresentationError: Error {
    
    case anotherFlowAlreadyPresented(flow: Flow)
    
}

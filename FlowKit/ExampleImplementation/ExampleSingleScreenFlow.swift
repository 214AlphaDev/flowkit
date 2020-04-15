//
//  ExampleSingleScreenFlow.swift
//  FlowKit
//
//  Created by Andrii Selivanov on 4/23/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation

// This file contains example of single screen flow presenter casting.

class ExampleSingleScreenFlow: SingleScreenFlow {
    
    var presenter: ExamplePresenterProtocol {
        return basePresenter as! ExamplePresenterProtocol
    }
    
    init(presenter: ExamplePresenterProtocol) {
        super.init(presenter: presenter)
    }
    
}


//
//  ExamplePresenter.swift
//  FlowKit
//
//  Created by Andrii Selivanov on 4/23/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import UIKit

// This file contains example of how presenter protocol and implementation can look like.

protocol ExamplePresenterProtocol: Presenter {
    
    var view: ExampleViewProtocol { get }
    
}

class ExamplePresenter: ExamplePresenterProtocol {
    
    var view: ExampleViewProtocol
    
    init(view: ExampleViewProtocol) {
        self.view = view
    }
    
    func cleanUp() {
        // Clean up all fields and state that shouldn't be saved accross screen displaying
    }
    
    var viewController: UIViewController {
        return view.viewController
    }
    
}

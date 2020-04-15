//
//  ExampleView.swift
//  FlowKit
//
//  Created by Andrii Selivanov on 4/23/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import UIKit

// This file contains example of how view and presenters can be used together with WeakWrapper.

protocol ExampleViewProtocol: ViewControllerProvider {
    
    var presenter: WeakWrapper<ExamplePresenterProtocol> { get set }
    
}

class ExampleView: ExampleViewProtocol {
    
    var presenter: WeakWrapper<ExamplePresenterProtocol> = WeakWrapper()
    
    var viewController: UIViewController {
        return UIViewController()
    }
    
}

//
//  ExampleFlows.swift
//  FlowKit
//
//  Created by Andrii Selivanov on 5/6/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation
import UIKit

// This file contains examples of how the structure works together.

struct ShowChildFlowAction: Action {
    let someStuff: String
}

struct HideChildFlow: Action {}

protocol TestFlowProtocol: Flow {}

class TestFlow: PushPopNavigationFlow, TestFlowProtocol {}

struct TestFlowFactory {
    
    static func build(navigationController: UINavigationController, rootFlow: ParentFlowProtocol, childFlowFactory: @escaping (_ someStuff: String) -> ChildFlowProtocol) -> TestFlowProtocol {
        return
            FlowBuilder(rootFlow: TestFlow(navigationController: navigationController, rootFlow: rootFlow))
            .push(on: ShowChildFlowAction.self) { _, action -> Flow in
                return childFlowFactory(action.someStuff)
            }
            .pop(ChildFlowProtocol.self)
            .rootFlow
    }
    
}

protocol ParentFlowProtocol: Flow {}

class ParentFlow: SingleScreenFlow, ParentFlowProtocol {}

struct ParentFlowFactory {
    
    static func build() -> ParentFlowProtocol {
        return ParentFlow(presenter: ExamplePresenter(view: ExampleView()))
    }
    
}

protocol ChildFlowProtocol: Flow {}

class ChildFlow: SingleScreenFlow, ChildFlowProtocol {
    
    var presenter: SomeStuffPresenterProtocol {
        return basePresenter as! SomeStuffPresenterProtocol
    }
    
    init(presenter: SomeStuffPresenterProtocol) {
        super.init(presenter: presenter)
    }
    
}

struct ChildFlowFactory {
    
    static func build(someStuff: String) -> ChildFlowProtocol {
        return ChildFlow(presenter: SomeStuffPresenter(someStuff: someStuff))
    }
    
}

protocol SomeStuffPresenterProtocol: Presenter {
    
    init(someStuff: String)
    
}

class SomeStuffPresenter: SomeStuffPresenterProtocol {
    
    let someStuff: String
    
    required init(someStuff: String) {
        self.someStuff = someStuff
    }
    
    var viewController: UIViewController {
        return UIViewController()
    }
    
}

struct UseInMainApp {
    
    func create() -> TestFlowProtocol {
        return TestFlowFactory.build(
            navigationController: UINavigationController(),
            rootFlow: ParentFlowFactory.build(),
            childFlowFactory: ChildFlowFactory.build)
    }
    
}

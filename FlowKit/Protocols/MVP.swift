//
//  View.swift
//  FlowKit
//
//  Created by Andrii Selivanov on 4/23/19.
//  Copyright © 2019 214alpha. All rights reserved.
//

import Foundation

/// Base protocol for all presenters used by flows.
public protocol Presenter: class, ViewControllerProvider {}

/// Protocol that describes that an instance should be able to return view controller. Used to abstract away from how exactly view controller is related to presenter or view.
public protocol ViewControllerProvider {
    
    var viewController: UIViewController { get }
    
}

// Protocol meaning that conformant is able to show a loading indicator
public protocol LoadingIndicatorDisplayable {
    
    /// Function to change visibility of loading indicator
    ///
    /// - Parameter visible: Flag meaning whether loading indicator should be visible
    func setLoadingIndicatorVisible(_ visible: Bool)
}

// Protocol meaning that conformant is able to display an error
public protocol ErrorDisplayable {
    
    /// Function to display an error
    ///
    /// - Parameters:
    ///   - title: Title of the error message
    ///   - error: Error to display
    func displayError(title: String, error: Error)
}

/// Result of validation for some value
///
/// - valid: Value is valid
/// - invalid: Valud is invalid
public enum ValidationResult {
    case valid
    case invalid(Error)
}


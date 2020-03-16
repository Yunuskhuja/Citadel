 //
//  CitadelUI.swift
//  Citadel
//
//  Cretated by Shohin Tagev
//  Edited by Yunuskhuja Tuygunkhujaev on 3/16/20.
//

import UIKit

public protocol CLConfigurator {
    associatedtype V: UIViewController
}

public protocol CLInitializer where Self: NSObject {
    associatedtype V: UIViewController
    var controller: V! { get }
}

public protocol CLInitializable: class {
    associatedtype I: CLInitializer
    var initializer: I! { get }
}

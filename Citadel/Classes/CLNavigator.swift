//
//  CLNavigator.swift
//  Citadel
//
//  Cretated by Shohin Tagev
//  Edited by Yunuskhuja Tuygunkhujaev on 3/16/20.
//

import UIKit

public protocol CLNavigation {
    
}

/*
     view controllers is nil only for segue
*/
public protocol CLNavigator {
    associatedtype T: CLNavigation
    func prepare(viewController: UIViewController, for navigation: T, object: Any?)
    func viewController(for navigation: T, object: Any?) -> UIViewController!
    func navigate(for navigation: T, from: UIViewController, to: UIViewController?, object: Any?)
}

extension CLNavigator {
    public func prepare(viewController: UIViewController, for navigation: T, object: Any?) {
        
    }
    
    public func prepare(viewController: UIViewController, for navigation: T) {
        self.prepare(viewController: viewController, for: navigation, object: nil)
    }
    
    public func viewController(for navigation: T) -> UIViewController! {
        return self.viewController(for: navigation, object: nil)
    }
    
    public func navigate(for navigation: T, from: UIViewController, to: UIViewController?) {
        self.navigate(for: navigation, from: from, to: to, object: nil)
    }
    
    public func navigate(for navigation: T, from: UIViewController, object: Any? = nil) {
        self.navigate(for: navigation, from: from, to: self.viewController(for: navigation, object: object), object: object)
    }
}

final public class CLRouter {
    public typealias NavigationBlock = ((CLNavigation) -> Void)
    static let `default` = CLRouter()
    private var didNavigateBlocks = [NavigationBlock] ()
    
    private init() {
        
    }
    
    public func navigate<N: CLNavigator>(with navigator: N, for navigation: N.T, from: UIViewController, object: Any? = nil) {
        navigator.navigate(for: navigation, from: from, object: object)
        for bl in self.didNavigateBlocks {
            bl(navigation)
        }
    }
    
    public func didNavigate(block: @escaping NavigationBlock) {
        didNavigateBlocks.append(block)
    }
}

final public class CR {
    public static func navigate<N: CLNavigator>(with navigator: N, for navigation: N.T, from: UIViewController, object: Any? = nil) {
        CLRouter.default.navigate(with: navigator, for: navigation, from: from, object: object)
    }
    
    public static func didNavigate(block: @escaping ALRouter.NavigationBlock) {
        CLRouter.default.didNavigate(block: block)
    }
}

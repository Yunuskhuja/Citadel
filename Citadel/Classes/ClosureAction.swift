//
//  ClosureAction.swift
//  Citadel
//
//  Cretated by Shohin Tagev
//  Edited by Yunuskhuja Tuygunkhujaev on 3/16/20.
//

import Foundation

public class ClosureAction {
    public let callback: () -> ()
    public init(_ callback: @escaping () -> ()) {
        self.callback = callback
    }
    @objc func action(_ sender: AnyObject) {
        callback()
    }
    
    deinit {
        
    }
}

private var ClosureKey: UInt8 = 10
extension NSObject {
    //It uses for strong reference
    //Use it when ClosureAction is locale variable
    public func storngReference(to closureAction: ClosureAction) {
        setAssociatedObject(self, value: closureAction, associativeKey: &ClosureKey, policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}

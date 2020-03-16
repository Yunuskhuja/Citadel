//
//  UIControlExtension.swift
//  Citadel
//
//  Cretated by Shohin Tagev
//  Edited by Yunuskhuja Tuygunkhujaev on 3/16/20.
//

import UIKit

public typealias ActionClosure = (() -> ())

public final class ActionHandler {
    let action: ActionClosure
    let priority: Int
    init(action: @escaping ActionClosure,
         priority: Int) {
        self.action = action
        self.priority = priority
    }
}

extension UIControl {
    public func touchDown(_ handler: @escaping ActionClosure,
                          priority: Int = 0) {
        self.add(handler: handler, for: .touchDown,
                 priority: priority)
    }
    
    public func touchDownRepeat(_ handler: @escaping ActionClosure,
                                priority: Int = 0) {
        self.add(handler: handler, for: .touchDownRepeat,
                 priority: priority)
    }
    
    public func touchDragInside(_ handler: @escaping ActionClosure,
                                priority: Int = 0) {
        self.add(handler: handler, for: .touchDragInside,
                 priority: priority)
    }
    
    public func touchDragOutside(_ handler: @escaping ActionClosure,
                                 priority: Int = 0) {
        self.add(handler: handler, for: .touchDragOutside,
                 priority: priority)
    }
    
    public func touchDragEnter(_ handler: @escaping ActionClosure,
                               priority: Int = 0) {
        self.add(handler: handler, for: .touchDragEnter,
                 priority: priority)
    }
    
    public func touchDragExit(_ handler: @escaping ActionClosure,
                              priority: Int = 0) {
        self.add(handler: handler, for: .touchDragExit,
                 priority: priority)
    }
    
    public func touchUpInside(_ handler: @escaping ActionClosure,
                              priority: Int = 0) {
        self.add(handler: handler, for: .touchUpInside,
                 priority: priority)
    }
    
    public func touchUpOutside(_ handler: @escaping ActionClosure,
                               priority: Int = 0) {
        self.add(handler: handler, for: .touchUpOutside,
                 priority: priority)
    }
    
    public func touchCancel(_ handler: @escaping ActionClosure,
                            priority: Int = 0) {
        self.add(handler: handler, for: .touchCancel,
                 priority: priority)
    }
    
    public func valueChanged(_ handler: @escaping ActionClosure,
                             priority: Int = 0) {
        self.add(handler: handler, for: .valueChanged,
                 priority: priority)
    }
    
    public func editingDidBegin(_ handler: @escaping ActionClosure,
                                priority: Int = 0) {
        self.add(handler: handler, for: .editingDidBegin,
                 priority: priority)
    }
    
    public func editingChanged(_ handler: @escaping ActionClosure,
                               priority: Int = 0) {
        self.add(handler: handler, for: .editingChanged,
                 priority: priority)
    }

    public func editingDidEnd(_ handler: @escaping ActionClosure,
                              priority: Int = 0) {
        self.add(handler: handler, for: .editingDidEnd,
                 priority: priority)
    }
    
    public func editingDidEndOnExit(_ handler: @escaping ActionClosure,
                                    priority: Int = 0) {
        self.add(handler: handler, for: .editingDidEndOnExit,
                 priority: priority)
    }
    
    public func primaryActionTriggered(handler: @escaping ActionClosure,
                                       priority: Int = 0) {
        self.add(handler: handler, for: .primaryActionTriggered,
                 priority: priority)
    }
    
    public func allTouchEvents(_ handler: @escaping ActionClosure,
                               priority: Int = 0) {
        self.add(handler: handler, for: .allTouchEvents,
                 priority: priority)
    }
    
    public func allEditingEvents(_ handler: @escaping ActionClosure,
                                 priority: Int = 0) {
        self.add(handler: handler, for: .allEditingEvents,
                 priority: priority)
    }
    
    public func applicationReserved(_ handler: @escaping ActionClosure,
                                    priority: Int = 0) {
        self.add(handler: handler, for: .applicationReserved,
                 priority: priority)
    }
    
    public func systemReserved(_ handler: @escaping ActionClosure,
                               priority: Int = 0) {
        self.add(handler: handler, for: .systemReserved,
                 priority: priority)
    }
    
    public func allEvents(_ handler: @escaping ActionClosure,
                          priority: Int = 0) {
        self.add(handler: handler, for: .allEvents,
                 priority: priority)
    }
    
    // MARK: - Privates
    private struct ActionHandlerKeys {
        static var ActionHandlerDictionaryKey = "actions_handler_key"
    }
    
    private static let eventToKey: [UIControl.Event: NSString] = [
        .touchDown: "TouchDown",
        .touchDownRepeat: "TouchDownRepeat",
        .touchDragInside: "TouchDragInside",
        .touchDragOutside: "TouchDragOutside",
        .touchDragEnter: "TouchDragEnter",
        .touchDragExit: "TouchDragExit",
        .touchUpInside: "TouchUpInside",
        .touchUpOutside: "TouchUpOutside",
        .touchCancel: "TouchCancel",
        .valueChanged: "ValueChanged",
        .editingDidBegin: "EditingDidBegin",
        .editingChanged: "EditingChanged",
        .editingDidEnd: "EditingDidEnd",
        .editingDidEndOnExit: "EditingDidEndOnExit",
        .primaryActionTriggered: "PrimaryActionTriggered",
        .allTouchEvents: "AllTouchEvents",
        .allEditingEvents: "AllEditingEvents",
        .applicationReserved: "ApplicationReserved",
        .systemReserved: "SystemReserved",
        .allEvents: "AllEvents"]
    
    private func getOrCreateHandlerDic() -> NSMutableDictionary {
        return getOrCreateAssociatedObject(self,
                                           associativeKey: &ActionHandlerKeys.ActionHandlerDictionaryKey,
                                           defaultValue: NSMutableDictionary(),
                                           policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    public func setAssociatedObject<T>(_ object: AnyObject, value: T, associativeKey: UnsafeRawPointer, policy: objc_AssociationPolicy) {
        objc_setAssociatedObject(object, associativeKey, value, policy)
    }

    public func getAssociatedObject<T>(_ object: AnyObject, associativeKey: UnsafeRawPointer) -> T? {
        if let valueAsType = objc_getAssociatedObject(object, associativeKey) as? T {
            return valueAsType
        } else {
            return nil
        }
    }
    
    public func getOrCreateAssociatedObject<T>(_ object: AnyObject, associativeKey: UnsafeRawPointer, defaultValue: T, policy: objc_AssociationPolicy) -> T {
        if let valueAsType: T = getAssociatedObject(object, associativeKey: associativeKey) {
            return valueAsType
        }
        setAssociatedObject(object, value: defaultValue, associativeKey: associativeKey, policy: policy)
        return defaultValue
    }
    
    private func add(handler: @escaping ActionClosure, for event: UIControl.Event, priority: Int) {
        guard let key = UIControl.eventToKey[event] else {
            fatalError("Event type is not handled")
        }
        self.addTarget(self, action: Selector("eventHandler\(key)"), for: event)
        let dic = self.getOrCreateHandlerDic()
        var arr = (dic[key] as? Array<ActionHandler>) ?? Array<ActionHandler>()
        arr.append(ActionHandler(action: handler, priority: priority))
        dic[key] = arr
    }
    
    @objc
    private func handleUI(controlEvent: UIControl.Event) {
        guard let key = UIControl.eventToKey[controlEvent] else {
            fatalError("Event type is not handled")
        }
        if let arr = self.getOrCreateHandlerDic()[key] as? Array<ActionHandler> {
            self.notify(handlers: arr)
        } else {
            fatalError("Action event \(controlEvent) does not exists")
        }
    }
    
    private func notify(handlers: Array<ActionHandler>) {
        for handler in handlers.sorted(by: { (a1, a2) -> Bool in
            return a1.priority > a2.priority
        }) {
            handler.action()
        }
    }
    
    @objc
    private dynamic func eventHandlerTouchDown() {
        handleUI(controlEvent: .touchDown)
    }
    
    @objc
    private dynamic func eventHandlerTouchDownRepeat() {
        handleUI(controlEvent: .touchDownRepeat)
    }
    
    @objc
    private dynamic func eventHandlerTouchDragInside() {
        handleUI(controlEvent: .touchDragInside)
    }
    
    @objc
    private dynamic func eventHandlerTouchDragOutside() {
        handleUI(controlEvent: .touchDragOutside)
    }
    
    @objc
    private dynamic func eventHandlerTouchDragEnter() {
        handleUI(controlEvent: .touchDragEnter)
    }
    
    @objc
    private dynamic func eventHandlerTouchDragExit() {
        handleUI(controlEvent: .touchDragExit)
    }
    
    @objc
    private dynamic func eventHandlerTouchUpInside() {
        handleUI(controlEvent: .touchUpInside)
    }
    
    @objc
    private dynamic func eventHandlerTouchUpOutside() {
        handleUI(controlEvent: .touchUpOutside)
    }
    
    @objc
    private dynamic func eventHandlerTouchCancel() {
        handleUI(controlEvent: .touchCancel)
    }
    
    @objc
    private dynamic func eventHandlerValueChanged() {
        handleUI(controlEvent: .valueChanged)
    }
    
    @objc
    private dynamic func eventHandlerEditingDidBegin() {
        handleUI(controlEvent: .editingDidBegin)
    }
    
    @objc
    private dynamic func eventHandlerEditingChanged() {
        handleUI(controlEvent: .editingChanged)
    }
    
    @objc
    private dynamic func eventHandlerEditingDidEnd() {
        handleUI(controlEvent: .editingDidEnd)
    }
    
    @objc
    private dynamic func eventHandlerEditingDidEndOnExit() {
        handleUI(controlEvent: .editingDidEndOnExit)
    }
}

extension UIControl.Event: Hashable {
    public var hashValue: Int {
        return Int(self.rawValue)
    }
}

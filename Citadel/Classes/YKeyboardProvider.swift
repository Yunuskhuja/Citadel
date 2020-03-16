//
//  YKeyboardProvider.swift
//
//  Cretated by Shohin Tagev
//  Edited by Yunuskhuja Tuygunkhujaev on 3/16/20.
//

import Foundation

public typealias YKeyboardCompletion = ((CGRect) -> Void)

public final class YKeyboardProvider {
  public var keyboardWillShow: YKeyboardCompletion?
  public var keyboardWillHide: YKeyboardCompletion?
  public var keyboardDidShow: YKeyboardCompletion?
  public var keyboardDidHide: YKeyboardCompletion?
  
  public init() {
  }
    
  public final func registerKeyboardNotification() {
    self.registerWillShowKeyboardNotification()
    self.registerWillHideKeyboardNotification()
  }
  
  public final func registerWillShowKeyboardNotification() {
    self.registerKeyboardNotification(selector: #selector(kdWillShow), notificationName: self.willShowNotificationName())
  }
  
  public final func registerWillHideKeyboardNotification() {
    self.registerKeyboardNotification(selector: #selector(kdWillHide), notificationName: self.willHideNotificationName())
  }
  
  public final func registerDidShowKeyboardNotification() {
    self.registerKeyboardNotification(selector: #selector(kdDidShow), notificationName: self.didShowKeyboardNotificationName())
  }
  
  public final func registerDidHideKeyboardNotification() {
    self.registerKeyboardNotification(selector: #selector(kdDidHide), notificationName: self.didHideNotificationName())
  }
    
  private func registerKeyboardNotification(selector: Selector, notificationName: Notification.Name) {
    NotificationCenter.default.addObserver(self, selector: selector, name: notificationName, object: nil)
  }
  
  public final func unregisterKeyboardNotification() {
    self.unregisterWillShowKeyboardNotification()
    self.unregisterWillHideKeyboardNotification()
  }
  
  public final func unregisterWillShowKeyboardNotification() {
    self.unregisterKeyboardNotification(name: self.willShowNotificationName())
  }
  
  public final func unregisterWillHideKeyboardNotification() {
    self.unregisterKeyboardNotification(name: self.willHideNotificationName())
  }
  
  public final func unregisterDidShowKeyboardNotification() {
    self.unregisterKeyboardNotification(name: self.didShowKeyboardNotificationName())
  }
  
  public final func unregisterDidHideKeyboardNotification() {
    self.unregisterKeyboardNotification(name: self.didHideNotificationName())
  }
    
  private func unregisterKeyboardNotification(name: Notification.Name) {
    NotificationCenter.default.removeObserver(self, name: name, object: nil)
  }
  
  private func didHideNotificationName() -> NSNotification.Name {
    var nName: Notification.Name!
    #if swift(>=4.2)
    nName = UIResponder.keyboardDidHideNotification
    #else
    nName = .UIKeyboardDidHide
    #endif
    return nName
  }

  private func didShowKeyboardNotificationName() -> Notification.Name {
    var nName: Notification.Name!
    #if swift(>=4.2)
    nName = UIResponder.keyboardDidShowNotification
    #else
    nName = .UIKeyboardDidShow
    #endif
    return nName
  }
    
  private func willHideNotificationName() -> NSNotification.Name {
    var nName: Notification.Name!
    #if swift(>=4.2)
    nName = UIResponder.keyboardWillHideNotification
    #else
    nName = .UIKeyboardWillHide
    #endif
    return nName
  }
  
  private func willShowNotificationName() -> Notification.Name {
    var nName: Notification.Name!
    #if swift(>=4.2)
    nName = UIResponder.keyboardWillShowNotification
    #else
    nName = .UIKeyboardWillShow
    #endif
    return nName
  }
    
  fileprivate func keyboardFrameEndKey() -> String {
    var nName: String!
    #if swift(>=4.2)
    nName = UIResponder.keyboardFrameEndUserInfoKey
    #else
    nName = UIKeyboardFrameEndUserInfoKey
    #endif
    return nName
  }
}

extension YKeyboardProvider {
  private func getFrameKeyboard(_ notification: Notification) -> CGRect {
    if let userInfo = notification.userInfo {
      if let frame = (userInfo[self.keyboardFrameEndKey()] as? NSValue)?.cgRectValue {
       return frame
      } else {
        return CGRect.zero
      }
    } else {
      return CGRect.zero
    }
  }
  
  /// actions
  @objc
  fileprivate func kdWillShow(notification: Notification) {
    guard let kws = self.keyboardWillShow else {
      fatalError("keyboardWillShow is nil")
    }
    kws(self.getFrameKeyboard(notification))
  }
  
  @objc
  fileprivate func kdWillHide(notification: Notification) {
    guard let kwh = self.keyboardWillHide else {
      fatalError("keyboardWillHide is nil")
    }
    kwh(self.getFrameKeyboard(notification))
  }
  
  @objc
  fileprivate func kdDidShow(notification: Notification) {
    guard let kds = self.keyboardDidShow else {
      fatalError("keyboardDidShow is nil")
    }
    kds(self.getFrameKeyboard(notification))
  }
  
  @objc
  fileprivate func kdDidHide(notification: Notification) {
    guard let kdh = self.keyboardDidHide else {
      fatalError("keyboardDidHide is nil")
    }
    kdh(self.getFrameKeyboard(notification))
  }
}

//
//  YUIBind.swift
//  Citadel
//
//  Cretated by Shohin Tagev
//  Edited by Yunuskhuja Tuygunkhujaev on 3/16/20.
//

import UIKit

public enum YBindType {
    case none, model, ui, both
}

public struct YUIBind {
    public static func bind<T>(model: YBindable<T>, textField: UITextField, type: YBindType = .ui) {
        let hasModelValue = model.value != nil
        let hasFieldText = textField.text.isFull
        
        func setModel() {
            if let txt = textField.text {
                model.disableChangingObserver = true
                model.value = model.convert(from: txt)
                model.disableChangingObserver = false
            } else {
                model.disableChangingObserver = true
                model.value = nil
                model.disableChangingObserver = false
            }
        }
        
        func setField() {
            textField.text = model.value == nil ? nil : model.stringValue
        }
        
        func textFieldChanged() {
            if hasFieldText {
                setModel()
            }
            
            textField.editingChanged({
                setModel()
            }, priority: Int.max)
        }
        
        func modelChanged() {
            if hasModelValue {
                setField()
            }
            
            model.valueChanged {
                setField()
            }
        }
        
        switch type {
        case .both:
            textFieldChanged()
            modelChanged()
        case .model:
            modelChanged()
        case .ui:
            textFieldChanged()
        default:
            break
        }
    }
}

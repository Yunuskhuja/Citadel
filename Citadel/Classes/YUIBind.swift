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
    
    public static func bind<T>(model: YBindable<T>, picker: YPickerView<T>, type: YBindType = .ui) {
        let hasPickerSelected = picker.hasSelected
        
        func setModel() {
            model.disableChangingObserver = true
            model.value = picker.selectedItem ?? nil
            model.disableChangingObserver = false
        }
        
        func pickerChanged() {
            if hasPickerSelected {
                setModel()
            }
            
            picker.addSelectChange({
                setModel()
            }, priority: Int.max)
        }
        
        switch type {
        case .both:
            fatalError("Two way binding is unsupported")
        case .model:
            fatalError("Model binding is unsupported")
        case .ui:
            pickerChanged()
        default:
            break
        }
    }
    
    public static func bind<T: Equatable>(model: YBindable<T>, picker: YPickerView<T>, type: YBindType = .ui) {
        let hasModelValue = model.value != nil
        let hasPickerSelected = picker.hasSelected
        
        func setModel() {
            model.disableChangingObserver = true
            model.value = picker.selectedItem ?? nil
            model.disableChangingObserver = false
        }
        
        func pickerChanged() {
            if hasPickerSelected {
                setModel()
            }
            
            picker.addSelectChange({
                setModel()
            }, priority: Int.max)
        }
        
        func setPicker() {
            if let v = model.value {
                picker.set(item: v)
            }
        }
        
        func modelChanged() {
            if hasModelValue {
                setPicker()
            }
            
            model.valueChanged {
                setPicker()
            }
        }
        
        switch type {
        case .both:
            pickerChanged()
            modelChanged()
        case .model:
            modelChanged()
        case .ui:
            pickerChanged()
        default:
            break
        }
    }
    
    public static func bind<T>(model: YArrayBindable<T>, picker: YPickerView<T>, selectFirst: Bool, type: YBindType = .model) {
        func setPicker() {
            if !model.isEmpty {
                picker.set(items: model.value!, selectFirst: selectFirst)
            }
        }
        
        func modelChanged() {
            model.valueChanged {
                setPicker()
            }
        }
        
        setPicker()
        
        switch type {
        case .both:
            fatalError("Two way binding is unsupported")
        case .model:
            modelChanged()
        case .ui:
            fatalError("UI binding is unsupported")
        default:
            break
        }
    }
    
    public static func bind<T>(model: YBindable<T>, datePicker: YDatePicker, type: YBindType = .ui) {
        let hasModelValue = model.value != nil
        
        func setModel() {
            if let sd = datePicker.stringDate {
                model.disableChangingObserver = true
                model.value = model.convert(from: sd)
                model.disableChangingObserver = false
            } else {
                model.disableChangingObserver = true
                model.value = nil
                model.disableChangingObserver = false
            }
        }
        
        func setDatePicker() {
            datePicker.set(stringDate: model.stringValue)
        }
        
        func datePickerChanged() {
            datePicker.valueChanged({
                setModel()
            }, priority: Int.max)
        }
        
        func modelChanged() {
            if hasModelValue {
                setDatePicker()
            }
            
            model.valueChanged {
                setDatePicker()
            }
        }
        
        switch type {
        case .both:
            datePickerChanged()
            modelChanged()
        case .model:
            modelChanged()
        case .ui:
            datePickerChanged()
        default:
            break
        }
    }
}

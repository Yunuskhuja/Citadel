//
//  BoolExtensions.swift
//  Citadel
//
//  Cretated by Shohin Tagev
//  Edited by Yunuskhuja Tuygunkhujaev on 3/16/20.
//

import Foundation

extension Bool {
    public static func parse(from value: Any?) -> Bool? {
        guard let v = value else {
            return nil
        }
        
        switch v {
        case let b as Bool:
            return b
        case let num as NSNumber:
            return num.boolValue
        case let str as NSString:
            return str.boolValue
        case let str as String:
            return NSString(string: str).boolValue
        default:
            return false
        }
    }
}

extension Bool {
    public mutating func toggle() -> Bool {
        self = !self
        return self
    }
}

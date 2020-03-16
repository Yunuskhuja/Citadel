//
//  OptionalExtensions.swift
//  Citadel
//
//  Cretated by Shohin Tagev
//  Edited by Yunuskhuja Tuygunkhujaev on 3/16/20.
//

import Foundation

extension Optional where Wrapped == String {
    public var nilOrEmpty: Bool {
        guard let s = self else {
            return true
        }
        return s.isEmpty
    }
    
    public var isFull: Bool {
        return !self.nilOrEmpty
    }
}

//
//  ArrayExtensions.swift
//  Citadel
//
//  Cretated by Shohin Tagev
//  Edited by Yunuskhuja Tuygunkhujaev on 3/16/20.
//

import Foundation

extension Array {
    public var isFull: Bool {
        return !self.isEmpty
    }
}

extension Array where Element: Equatable {
    public static func distinct(with other: [Element]) -> [Element] {
        var unique = [Element]()
        for item in other {
            if !unique.contains(item) {
                unique.append(item)
            }
        }
        return unique
    }
    
    public mutating func remove(object: Element) {
        for i in (0..<count).reversed() {
            if self[i] == object {
                self.remove(at: i)
            }
        }
    }
    
    public mutating func prepend(_ newElement: Element) {
        self.insert(newElement, at: 0)
    }
    
    public mutating func append(_ newElement: Element, if state: Bool) {
        if state {
            self.append(newElement)
        }
    }
}

extension Array where Element: Hashable {
    public func set() -> Set<Element> {
        var s = Set<Element>()
        for item in self {
            s.insert(item)
        }
        return s
    }
}

extension Array where Element == String {
    public func makeString(prefix: String, infix: String, suffix: String) -> String {
        if self.isEmpty {
            return ""
        }
        var str = prefix
        for index in 0..<self.count {
            if index > 0 {
                str.append(infix)
            }
            str.append(self[index])
        }
        str.append(suffix)
        return str
    }
    
    public func makeString(separator: String) -> String {
        return self.makeString(prefix: "", infix: separator, suffix: "")
    }
}


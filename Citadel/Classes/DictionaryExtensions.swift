//
//  DictionaryExtensions.swift
//  Citadel
//
//  Cretated by Shohin Tagev
//  Edited by Yunuskhuja Tuygunkhujaev on 3/16/20.
//

import Foundation

extension Dictionary {
    public func random() -> Value {
        let index: Int = Int(arc4random_uniform(UInt32(self.count)))
        return Array(self.values)[index]
    }
    
    /// Combines the first dictionary with the second and returns single dictionary
    public mutating func union(other: Dictionary) {
        for (key, value) in other {
            self.updateValue(value, forKey:key)
        }
    }
}

extension Dictionary {
    public static func parse(from value: Any?) -> Dictionary? {
        guard let v = value else {
            return nil
        }
        
        switch v {
        case let d as Dictionary:
            return d
        default:
            return nil
        }
    }
}

extension Dictionary where Key: ExpressibleByStringLiteral, Value: Any {
    public var jsonString: String? {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions(rawValue: 0))
            if let string = String(data: data, encoding: String.Encoding.utf8) {
                return string
            }
        } catch {
            print(error)
        }
        
        return nil
    }
}

public func += <KeyType, ValueType> (left: inout Dictionary<KeyType, ValueType>, right: Dictionary<KeyType, ValueType>) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}

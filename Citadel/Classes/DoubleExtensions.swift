//
//  DoubleExtensions.swift
//  Citadel
//
//  Cretated by Shohin Tagev
//  Edited by Yunuskhuja Tuygunkhujaev on 3/16/20.
//

import Foundation

extension Double {
    public static func parse(from value: Any?) -> Double? {
        guard let v = value else {
            return nil
        }
        
        switch v {
        case let d as Double:
            return d
        case let num as NSNumber:
            return num.doubleValue
        case let str as NSString:
            return str.doubleValue
        default:
            return nil
        }
    }
    
    public func rounded(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

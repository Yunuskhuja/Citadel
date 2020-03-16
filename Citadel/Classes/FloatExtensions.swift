//
//  FloatExtensions.swift
//  Citadel
//
//  Cretated by Shohin Tagev
//  Edited by Yunuskhuja Tuygunkhujaev on 3/16/20.
//

import Foundation

extension Float {
    public static func parse(from value: Any?) -> Float? {
        guard let v = value else {
            return nil
        }
        switch v {
        case let f as Float:
            return f
        case let num as NSNumber:
            return num.floatValue
        case let str as NSString:
            return str.floatValue
        default:
            return nil
        }
    }
    
    public func rounded(places: Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}

extension FloatingPoint {
    public var degreesToRadians: Self {
        return self * .pi / 180
    }
    
    public var radiansToDegrees: Self {
        return self * 180 / .pi
    }
}

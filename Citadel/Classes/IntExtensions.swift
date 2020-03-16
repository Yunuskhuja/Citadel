//
//  IntExtensions.swift
//  Citadel
//
//  Cretated by Shohin Tagev
//  Edited by Yunuskhuja Tuygunkhujaev on 3/16/20.
//

import Foundation

extension Int {
    public static func parse(from value: Any?) -> Int? {
        guard let v = value else {
            return nil
        }
        switch v {
        case let i as Int:
            return i
        case let num as NSNumber:
            return num.intValue
        case let str as NSString:
            return str.integerValue
        case _ as NSNull:
            return nil
        default:
            return nil
        }
    }
}

extension Int {
    public var isEven: Bool {
        return self % 2 == 0
    }
    
    public var isOdd: Bool {
        return !self.isEven
    }
    
    public var isPositive: Bool {
        return self >= 0
    }
    
    public var isNegative: Bool {
        return !self.isPositive
    }
    
    public var toDouble: Double {
        return Double(self)
    }
    
    public var toFloat: Float {
        return Float(self)
    }
    
    public var toCGFloat: CGFloat {
        return CGFloat(self)
    }
    
    public var toString: String {
        return String(self)
    }
    
    public var digits: Int {
        if self == 0 {
            return 1
        } else if Int(fabs(Double(self))) <= LONG_MAX {
            return Int(log10(fabs(Double(self)))) + 1
        }
    }
    
    /// Execute action this many times
    public func times(action: () -> ()) {
        if self > 0 {
            for _ in 0..<self {
                action()
            }
        }
    }
    
}

extension UInt {
    public var toInt: Int {
        return Int(self)
    }
}

extension BinaryInteger {
    public var degreesToRadians: CGFloat {
        return CGFloat(Int(self)) * .pi / 180
    }
}

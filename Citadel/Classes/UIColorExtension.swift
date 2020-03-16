//
//  UIColorExtension.swift
//  Citadel
//
//  Cretated by Shohin Tagev
//  Edited by Yunuskhuja Tuygunkhujaev on 3/16/20.
//

import UIKit

extension UIColor {
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(r: r, g: g, b: b, a: 1)
    }

    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        var red = r
        var green = g
        var blue = b
        if r > 1
           || g > 1
           || b > 1 {
            red = r / 255.0
            green = g / 255.0
            blue =  b / 255.0
        }
        self.init(red: red, green: green, blue: blue, alpha: a)
    }
    
    public convenience init(hex: UInt) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    public convenience init?(hex: String) {
        guard let h = UInt(hex) else {
            return nil
        }
        self.init(hex: h)
    }
}

extension UIColor {
    public convenience init(gray: CGFloat, alpha: CGFloat = 1) {
        self.init(r: gray, g: gray, b: gray, a: alpha)
    }

    public static func color(r: CGFloat, g: CGFloat,  b: CGFloat, a: CGFloat = 0) -> UIColor {
        return UIColor(r: r, g: g, b: b, a: a)
    }
    
    public var redComponent: CGFloat {
        var r: CGFloat = 0
        getRed(&r, green: nil, blue: nil, alpha: nil)
        return r * 255
    }
    
    public var greenComponent: CGFloat {
        var g: CGFloat = 0
        getRed(nil, green: &g, blue: nil, alpha: nil)
        return g * 255
    }
    
    public var blueComponent: CGFloat {
        var b: CGFloat = 0
        getRed(nil, green: nil, blue: &b, alpha: nil)
        return b * 255
    }
    
    public var alpha: CGFloat {
        var a: CGFloat = 0
        getRed(nil, green: nil, blue: nil, alpha: &a)
        return a
    }
}

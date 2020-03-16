//
//  UIButtonExtension.swift
//  Citadel
//
//  Cretated by Shohin Tagev
//  Edited by Yunuskhuja Tuygunkhujaev on 3/16/20.
//

import UIKit

extension UIButton {
    public func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: forState)
    }
    
    public func setAttributed(titles: Array<String>,
                              attributes: Array<Dictionary<NSAttributedString.Key, Any>>,
                              commonAttributes: Dictionary<NSAttributedString.Key, Any>?) {
        let attrStr = NSAttributedString.attributedString(titles: titles,
                                                          attributes: attributes,
                                                          commonAttributes: commonAttributes)
        self.titleLabel?.numberOfLines = 0
        self.setAttributedTitle(attrStr, for: .normal)
    }
}

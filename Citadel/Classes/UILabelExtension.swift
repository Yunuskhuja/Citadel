//
//  UILabelExtension.swift
//  Citadel
//
//  Cretated by Shohin Tagev
//  Edited by Yunuskhuja Tuygunkhujaev on 3/16/20.
//

import UIKit

extension UILabel {
    public func html(from text: String, font: UIFont? = nil, color: UIColor? = nil) {
        let attrStr = try! NSMutableAttributedString(data: text.data(using: String.Encoding.unicode,allowLossyConversion: true)!, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        
        if !text.isEmpty {
            let range = NSMakeRange(0, attrStr.length)
            if let f = font {
                attrStr.addAttributes([NSAttributedString.Key.font: f], range: range)
            }
            if let c = color {
                attrStr.addAttributes([NSAttributedString.Key.foregroundColor: c], range: range)
            }
        }
        
        self.attributedText = attrStr
    }
}

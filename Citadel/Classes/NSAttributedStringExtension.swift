//
//  NSAttributedStringExtension.swift
//  Citadel
//
//  Cretated by Shohin Tagev
//  Edited by Yunuskhuja Tuygunkhujaev on 3/16/20.
//

import Foundation

public enum DocEXT: String {
    case rtfd
    case rtf
    case htm
    case html
    case txt
}

extension NSAttributedString {
    
    public static func attributedString(titles: Array<String>,
                                        attributes: Array<Dictionary<NSAttributedString.Key, Any>>,
                                        commonAttributes: Dictionary<NSAttributedString.Key, Any>?) -> NSAttributedString {
        assert(titles.isFull
            && attributes.isFull
            && titles.count == attributes.count, "Titles and Attributes are not equal length")
        
        let fullStr = titles.joined()
        let attrStr = NSMutableAttributedString(string: fullStr, attributes: commonAttributes)
        var loc = 0
        for (index, title) in titles.enumerated() {
            let len = title.count
            let range = NSRange(location: loc, length: len)
            loc = loc + len
            let attrs = attributes[index]
            if attrs.isEmpty {
                continue
            }
            attrStr.addAttributes(attrs, range: range)
        }
        return attrStr
    }
    
    public func adding(attribute name: NSAttributedString.Key, value: Any, range: NSRange) -> NSAttributedString {
        let attr = NSMutableAttributedString(attributedString: self)
        attr.addAttribute(name, value: value, range: range)
        return NSAttributedString(attributedString: attr)
    }
    
    /// Attempts to create an `NSAttributedString` from an encoded string of the specified type.
    public static func encoded(from string: String, ext: DocEXT) -> NSAttributedString? {
        guard let data = string.data(using: .utf8) else { return nil }
        let docType = documentTypeDictionary(extension: ext)
        let result = try? NSAttributedString(data: data,
                                             options: docType,
                                             documentAttributes: nil)
        return result
    }
    
    /// Attempts to create an NSAttributedString from an encoded **html** string.
    public static func encoded(fromHTML html: String) -> NSAttributedString? {
        return NSAttributedString.encoded(from: html, ext: .html)
    }
}


////////////////////////
// <html>String</html> ⇒ NSAttributedString
////////////////////////

extension String {
    public func attributedString(ext: DocEXT) -> NSAttributedString? {
        guard let data = self.data(using: .utf8) else { return nil }
        let result = try? NSAttributedString(data: data,
                                             options: documentTypeDictionary(extension: ext),
                                             documentAttributes: nil)
        return result
    }
}


// Helper(s)
fileprivate func documentTypeDictionary(extension ext: DocEXT) -> [NSAttributedString.DocumentReadingOptionKey: Any] {
    let documentTypeDictionary: [DocEXT: Any] = [
        .rtfd: NSAttributedString.DocumentType.rtfd,
        .rtf : NSAttributedString.DocumentType.rtf,
        .htm : NSAttributedString.DocumentType.html,
        .html: NSAttributedString.DocumentType.html,
        .txt : NSAttributedString.DocumentType.plain
    ]
    
    let docType = documentTypeDictionary[ext]
    return [NSAttributedString.DocumentReadingOptionKey.documentType: docType ?? NSAttributedString.DocumentType.plain]
}

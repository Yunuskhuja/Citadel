//
//  CStringExtensions.swift
//  Citadel
//
//  Cretated by Shohin Tagev
//  Edited by Yunuskhuja Tuygunkhujaev on 3/16/20.
//

import Foundation

//MARK: Subscripting
extension String {
    fileprivate func makeRange(lower: Int, upper: Int) -> Range<String.Index> {
        let start = self.index(self.startIndex, offsetBy: lower)
        let end = self.index(self.startIndex, offsetBy: upper)
        return Range<String.Index>(uncheckedBounds: (lower: start, upper: end))
    }
    
    public subscript(i: Int) -> Character {
        get {
            return self[self.index(self.startIndex, offsetBy: i)]
        }
        set (val) {
            self.replaceSubrange(self.makeRange(lower: i, upper: i + 1), with: String(val))
        }
    }
    
    public subscript (i: Int) -> String {
        get {
            return String(self[self.index(self.startIndex, offsetBy: i)])
        }
        set (val) {
            self.replaceSubrange(self.makeRange(lower: i, upper: i + 1), with: val)
        }
    }
}

//MARK: Formatting
extension String {
    public var isFull: Bool {
        return !self.isEmpty
    }
    
    public var capitalizedFirst: String {
        guard let f = self.first else {
            return self
        }
        var result = self
        result[0] = String(f).capitalized
        return result
    }
    
    public var isEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    public var isAllDigits: Bool {
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
    }
    
    public var trimmed: String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
    }
    
    public var utf8Length: Int {
        get {
            return self.lengthOfBytes(using: String.Encoding.utf8)
        }
    }
    
    /**
     A simple extension to the String object to encode it for web request.
     
     :returns: Encoded version of of string it was called as.
     */
    public var escaped: String? {
        let set = NSMutableCharacterSet()
        set.formUnion(with: CharacterSet.urlQueryAllowed)
        set.removeCharacters(in: "[].:/?&=;+!@#$()',*\"") // remove the HTTP ones from the set.
        return self.addingPercentEncoding(withAllowedCharacters: set as CharacterSet)
    }
    
    /**
     A simple extension to the String object to url encode quotes only.
     
     :returns: string with .
     */
    public var quoteEscaped: String {
        return self.replacingOccurrences(of: "\"", with: "%22").replacingOccurrences(of: "'", with: "%27")
    }
}

//MARK: Searching
extension String {
    public func index(of character: Character) -> Int? {
        for i in 0..<self.count {
            if character == self[i] {
                return i
            }
        }
        
        return nil
    }
    
    public static func binarySearch (_ str: String, searchCh: Character, start: Int, end: Int) -> Int {
        var mid = (start + end) / 2
        if str[mid] == searchCh {
            while (mid + 1 < str.count && str[mid + 1] == searchCh) {
                mid += 1
            }
            return mid
        } else if start == end {
            return -1
        } else if str[mid] < searchCh {
            return binarySearch(str, searchCh: searchCh, start: mid + 1, end: end)
        } else {
            return binarySearch(str, searchCh: searchCh, start: start, end: mid)
        }
    }
}

//MARK: Removing
extension String {
    public mutating func remove(range: Range<Int>) {
        self.removeSubrange(self.makeRange(lower: range.lowerBound, upper: range.upperBound))
    }
    
    public func removingWhitespaces() -> String {
        return self.components(separatedBy: .whitespaces).joined()
    }
}

//MARK: Converting
extension String {
    public static func parse(from value: Any?) -> String? {
        guard let v = value else {
            return nil
        }
        switch v {
        case let s as String:
            return s
        case let s as NSString:
            return s as String
        case let n as NSNumber:
            return n.stringValue
        case let d as Data:
            var buffer = [UInt8](repeating: 0, count: d.count)
            d.copyBytes(to: &buffer, count: d.count)
            let datastring = String(bytes: buffer, encoding:String.Encoding.utf8)
            return datastring
        default:
            return nil
        }
    }
    
    public func data(encoding: String.Encoding) -> Data? {
        return self.data(using: encoding)
    }
    
    public var dataUTF8Encoding: Data? {
        return self.data(encoding: String.Encoding.utf8)
    }
    
    public var bool: Bool? {
        return Bool(self)
    }
    
    public var int: Int? {
        return Int(self)
    }
    
    public var int8: Int8? {
        return Int8(self)
    }
    
    public var int16: Int16? {
        return Int16(self)
    }
    
    public var int32: Int32? {
        return Int32(self)
    }
    
    public var int64: Int64? {
        return Int64(self)
    }
    
    public var double: Double? {
        return Double(self)
    }
    
    public var float: Float? {
        return Float(self)
    }
    
    public var dictionary: Dictionary<String, Any>? {
        if let d = self.dataUTF8Encoding {
            do {
                let dic = try JSONSerialization.jsonObject(with: d, options: JSONSerialization.ReadingOptions.allowFragments)
                return dic as? Dictionary
            } catch {
                DLog("error in parsing \(self) to dictionary: \(error)")
            }
        }
        
        return nil
    }
}

extension String {
    public func isOnlySpacesAndNewLines() -> Bool {
        let characterSet = NSCharacterSet.whitespacesAndNewlines
        let newText = self.trimmingCharacters(in: characterSet)
        return newText.isEmpty
    }
    
    public mutating func trim() {
        self = self.trimmed
    }
}

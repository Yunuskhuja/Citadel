//
//  YBindable.swift
//  Citadel
//
//  Cretated by Shohin Tagev
//  Edited by Yunuskhuja Tuygunkhujaev on 3/16/20.
//

import Foundation

open class YBindable<T> {
    private var _value: T?
    private var _valueChanged: (() -> ())!
    
    public var disableChangingObserver: Bool = false
    
    public init() {
    }
    
    public var stringValue: String {
        guard let v = self.value else {
            return ""
        }
        
        return "\(v)"
    }
    
    public func convert(from string: String) -> T? {
        fatalError("Must implement")
    }
    
    public var value: T? {
        get {
            return _value
        }
        set {
            self._value = newValue
            if self._valueChanged != nil
                && !self.disableChangingObserver {
                self._valueChanged()
            }
        }
    }
    
    public func valueChanged(_ block: @escaping () -> ()) {
        self._valueChanged = block
    }
}

extension YBindable where T: Equatable {
    static func == (lhs: YBindable, rhs: YBindable) -> Bool {
        return lhs.value == rhs.value
    }
}

public final class YStringBindable: YBindable<String> {
    public override func convert(from string: String) -> String? {
        return string
    }
}

public final class YIntBindable: YBindable<Int> {
    public override func convert(from string: String) -> Int? {
        return Int(string)
    }
}

public final class YArrayBindable<T>: YBindable<Array<T>> {
    public override func convert(from string: String) -> Array<T>? {
        return string.components(separatedBy: ",") as? Array<T>
    }
    
    public var isEmpty: Bool {
        guard let v = self.value else {
            return true
        }
        return v.isEmpty
    }
}


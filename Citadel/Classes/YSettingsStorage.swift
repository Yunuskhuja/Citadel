//
//  FSettingsStorage.swift
//  Citadel
//
//  Cretated by Shohin Tagaev
//  Edited by Yunuskhuja Tuygunkhujaev on 3/16/20.
//

import Foundation

final public class YSettingsStorage {
    private var userDef = UserDefaults.standard
    public init() {
        
    }
    
    public class var shared: YSettingsStorage {
        struct Singleton {
            static let singleton = YSettingsStorage()
        }
        return Singleton.singleton
    }
    
    public subscript (key: String) -> Any? {
        get {
            return self.object(for: key)
        }
        set (val) {
            self.set(val, for: key)
        }
    }
    
    public subscript (key: String) -> Bool {
        get {
            return self.bool(for: key)
        }
        set (val) {
            self.set(val, for: key)
        }
    }
    
    public subscript (key: String) -> Int {
        get {
            return self.integer(for: key)
        }
        set (val) {
            self.set(val, for: key)
        }
    }
    
    public subscript (key: String) -> Double {
        get {
            return self.double(for: key)
        }
        set (val) {
            self.set(val, for: key)
        }
    }
    
    public subscript (key: String) -> Float {
        get {
            return self.float(for: key)
        }
        set (val) {
            self.set(val, for: key)
        }
    }
    
    public subscript (key: String) -> URL? {
        get {
            return self.url(for: key)
        }
        set (val) {
            self.set(val, for: key)
        }
    }
    
    public func set(_ object: Any?, for key: String) {
        self.userDef.set(object, forKey: key)
        self.userDef.synchronize()
    }
    
    public func removeObject(for key: String) {
        self.userDef.removeObject(forKey: key)
    }
    
    public func object(for key: String) -> Any? {
        return self.userDef.object(forKey: key)
    }
    
    public func dictionaryRepresentation() -> [String : Any] {
        return self.userDef.dictionaryRepresentation()
    }
    
    public func bool(for key: String) -> Bool {
        return self.userDef.bool(forKey: key)
    }
    
    public func integer(for key: String) -> Int {
        return self.userDef.integer(forKey: key)
    }
    
    public func double(for key: String) -> Double {
        return self.userDef.double(forKey: key)
    }
    
    public func float(for key: String) -> Float {
        return self.userDef.float(forKey: key)
    }
    
    public func string(for key: String) -> String? {
        return self.userDef.string(forKey: key)
    }
    
    public func stringArray(for key: String) -> [String]? {
        return self.userDef.stringArray(forKey: key)
    }
    
    public func array(for key: String) -> [Any]? {
        return self.userDef.array(forKey: key)
    }
    
    public func dictionary(for key: String) -> [String: Any]? {
        return self.userDef.dictionary(forKey: key)
    }
    
    public func data(for key: String) -> Data? {
        return self.userDef.data(forKey: key)
    }
    
    public func url(for key: String) -> URL? {
        return self.userDef.url(forKey: key)
    }
    
    public func set(_ value: Bool?, for key: String) {
        self.userDef.set(value, forKey: key)
        self.userDef.synchronize()
    }
    
    public func set(_ value: Int?, for key: String) {
        self.userDef.set(value, forKey: key)
        self.userDef.synchronize()
    }
    
    public func set(_ value: Double?, for key: String) {
        self.userDef.set(value, forKey: key)
        self.userDef.synchronize()
    }
    
    public func set(_ value: Float?, for key: String) {
        self.userDef.set(value, forKey: key)
        self.userDef.synchronize()
    }
    
    public func set(_ url: URL?, for key: String) {
        self.userDef.set(url, forKey: key)
        self.userDef.synchronize()
    }
}

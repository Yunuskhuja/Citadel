//
//  YDomain.swift
//  Citadel
//
//  Cretated by Shohin Tagev
//  Edited by Yunuskhuja Tuygunkhujaev on 3/16/20.
//

import Foundation

public struct YDataError {
    public let code: Int
    public let message: String
    public init(code: Int,
                message: String) {
        self.code = code
        self.message = message
    }
}

extension YDataError: Equatable {
    public static func == (lhs: YDataError, rhs: YDataError) -> Bool {
        return lhs.code == rhs.code
    }
}

public protocol YData {
    func error() -> YDataError?
}

extension YData {
    public var isValid: Bool {
        return self.error() == nil
    }
    
    public var isError: Bool {
        return !self.isValid
    }
    
    public var isEmpty: Bool {
        return self.isError
    }
    
    public var isFull: Bool {
        return !self.isEmpty
    }
    
    public var errorMessage: String? {
        return self.error()?.message
    }
}

public protocol YInputData: YData {
}

public protocol YOutputData: YData {
    
}

public protocol YPopulateAble {
    associatedtype Model
    func populate(with: Model)
}

@objc public protocol YWorker: class {
}

public protocol YPresenter: class {
}

//
//  YTransformable.swift
//  Citadel
//
//  Cretated by Shohin Tagev
//  Edited by Yunuskhuja Tuygunkhujaev on 3/16/20.
//

import Foundation

public protocol YInputTransformable {
    associatedtype InputType
    init(input: InputType)
}

public extension YInputTransformable {
    func turn(input: InputType) {
        fatalError("Not implemented")
    }
}

public protocol YOutputTransformable {
    associatedtype OutputType
    func transform() -> OutputType
}

public extension YOutputTransformable {
    init(output: OutputType) {
        fatalError("Not implemented")
    }
}

public typealias YTransfromable = YInputTransformable & YOutputTransformable

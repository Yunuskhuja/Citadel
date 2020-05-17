//
//  ALPickerView.swift
//  pls
//
//  Created by SSP on 1/19/18.
//  Copyright © 2018 prsl. All rights reserved.
//

import UIKit

final public class PickerView<T> {
    public typealias NumberOfColumns = (() -> Int)
    public typealias NumberOfRows = ((Int) -> Int)
    
    public typealias WidtForColumn = ((Int) -> CGFloat)
    public typealias HeightForColumn = ((Int) -> CGFloat)
    public typealias TitleForRow = ((_ item: T, _ row: Int, _ col: Int) -> String?)
    public typealias AttributedTitleForRow = ((Int, Int) -> NSAttributedString?)
    public typealias ViewForRow = ((Int, Int, UIView?) -> UIView)
    public typealias DidSelectRow = ((_ item: T, _ row: Int, _ col: Int) -> ())

    public typealias Mapper<M> = ((T) -> M)
    
    fileprivate var numberOfColumns: NumberOfColumns?
    fileprivate var numberOfRows: NumberOfRows?
    
    fileprivate var widthForColumn: WidtForColumn!
    fileprivate var heightForColumn: HeightForColumn!
    fileprivate var titleForRow: TitleForRow!
    fileprivate var attributedTitleForRow: AttributedTitleForRow?
    fileprivate var viewForRow: ViewForRow?
    fileprivate var didSelectRow: DidSelectRow?
    fileprivate var selectFirst: Bool = false
    
    private lazy var selectChanges: Array<ActionHandler> = {
        return []
    }()
    
    private var mapper: Mapper<Any>!
    
    private var dataModel: PickerViewDataModel<T>!
    
    fileprivate var its: Array<T> = []
    fileprivate var allItems: Array<T> = []
    
    fileprivate var sldItem: T!
    
    public let pickerView = UIPickerView()
    
    public var items: Array<T> {
        return self.its
    }
    
    public var hasSelected: Bool {
        return self.sldItem != nil
    }
    
    public var selectedItem: T! {
        return self.sldItem
    }
    
    public var selectedColumn: Int = 0 {
        didSet {
            self.select(row: self.selectedRow(), inColumn: self.selectedColumn, animated: true)
        }
    }
    
    public var hasColumns: Bool {
        return self.pickerView.numberOfComponents > 0
    }
    
    public init(numberOfColumns: @escaping NumberOfColumns,
                numberOfRows: @escaping NumberOfRows) {
        self.numberOfColumns = numberOfColumns
        self.numberOfRows = numberOfRows
        self.initialize()
    }
    
    public init() {
        self.initialize()
    }
    
    private func initialize() {
        self.dataModel = PickerViewDataModel(pickerView: self)
        self.pickerView.dataSource = self.dataModel
        self.pickerView.delegate = self.dataModel
    }
    
    private func config(titleForRow: @escaping TitleForRow,
                        widthForColumn: WidtForColumn?,
                       heightForColumn: HeightForColumn?,
                       attributedTitleForRow: AttributedTitleForRow?,
                       viewForRow: ViewForRow?,
                       didSelectRow: DidSelectRow?) {
        self.titleForRow = titleForRow
        self.widthForColumn = widthForColumn
        self.heightForColumn = heightForColumn
        self.attributedTitleForRow = attributedTitleForRow
        self.viewForRow = viewForRow
        self.didSelectRow = didSelectRow
        self.pickerView.backgroundColor = UIColor.white
    }
    
    fileprivate func item(for row: Int, component: Int) -> T {
        return self.numberOfColumns == nil ? self.its[row] : self.its[component]
    }
    
    fileprivate func setInternal(_ items: Array<T>, selectFirst: Bool) {
        self.selectFirst = selectFirst
        self.its = items
        if selectFirst {
            self.sldItem = self.its.first
        }
        self.reload()
    }
    
    public func set(titleForRow: @escaping TitleForRow,
                    widthForColumn: WidtForColumn? = nil,
                    heightForColumn: HeightForColumn? = nil,
                    attributedTitleForRow: AttributedTitleForRow? = nil,
                    viewForRow: ViewForRow? = nil,
                    didSelectRow: DidSelectRow?) {
        self.config(titleForRow: titleForRow,
                    widthForColumn: widthForColumn,
                    heightForColumn: heightForColumn,
                    attributedTitleForRow: attributedTitleForRow,
                    viewForRow: viewForRow,
                    didSelectRow: didSelectRow)
    }
    
    public func set(items: Array<T>, selectFirst: Bool) {
        self.allItems = items
        self.setInternal(items, selectFirst: selectFirst)
    }
    
    public func mapSelected<M>(_ mapper: Mapper<M>? = nil) -> M {
        if mapper != nil {
            self.mapper = mapper
        }
        return self.mapper(self.selectedItem) as! M
    }
    
    public func filter(_ predicate: ((T) -> Bool)?) {
        guard let p = predicate else {
            self.setInternal(self.allItems, selectFirst: self.selectFirst)
            return
        }
        self.setInternal(self.allItems.filter(p), selectFirst: self.selectFirst)
    }
    
    public func sort(_ comparator: ((T, T) -> Bool)?) {
        guard let c = comparator else {
            self.setInternal(self.allItems, selectFirst: self.selectFirst)
            return
        }
        self.setInternal(self.its.sorted(by: c), selectFirst: self.selectFirst)
    }
    
    public func reload() {
        self.pickerView.reloadAllComponents()
    }
    
    public func reload(column: Int) {
        self.pickerView.reloadComponent(column)
    }
    
    public func select(row: Int, inColumn column: Int = 0, animated: Bool) {
        self.pickerView.selectRow(row, inComponent: column, animated: animated)
    }
    
    public func selectedRow() -> Int {
        return self.pickerView.selectedRow(inComponent: self.selectedColumn)
    }
    
    public func hasRows(for col: Int = 0) -> Bool {
        return self.pickerView.numberOfRows(inComponent: col) > 0
    }
    
    public func addSelectChange(_ selectChange: @escaping ActionClosure,
                                priority: Int = 0) {
        self.selectChanges.append(ActionHandler(action: selectChange, priority: priority))
    }
    
    public func notifySelects() {
        for select in self.selectChanges.sorted(by: { (ac1, ac2) -> Bool in
            return ac1.priority > ac2.priority
        }) {
            select.action()
        }
    }
}

private class PickerViewDataModel<T>: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    private let pickerView: PickerView<T>
    init(pickerView: PickerView<T>) {
        self.pickerView = pickerView
    }
    
    //MARK: picker data source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return self.pickerView.numberOfColumns?() ?? 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerView.numberOfRows?(component) ?? self.pickerView.its.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerView.titleForRow(self.pickerView.item(for: row, component: component), row, component)
    }
 
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let itm = self.pickerView.item(for: row, component: component)
        self.pickerView.sldItem = itm
        self.pickerView.didSelectRow?(itm, row, component)
        self.pickerView.selectedColumn = component
        self.pickerView.notifySelects()
    }
}

extension PickerView where T: Equatable {
    public func set(item: T) {
        if let indx = self.items.index(of: item) {
            self.sldItem = item
            self.select(row: indx, animated: true)
        }
    }
}

//picker
extension UITextField {
    public func add<T>(pickerView: PickerView<T>,
                doneTitle: String = "Done",
                cancelTitle: String = "Cancel",
                doneAction: (() -> ())? = nil,
                cancelAction: (() -> ())? = nil) {
        func setText(isNil: Bool = false) {
            var txt: String? = nil
            if !isNil && pickerView.hasRows() {
                txt = pickerView.titleForRow(pickerView.selectedItem,
                                             pickerView.selectedRow(),
                                             pickerView.selectedColumn)
            }
            self.text = txt
            self.sendActions(for: .editingChanged)
        }
        self.inputView = pickerView.pickerView
        self.setAccessoryToolbar(doneTitle: doneTitle, cancelTitle: cancelTitle, doneAction: {

            doneAction?()
            pickerView.notifySelects()
        }, cancelAction: {
            cancelAction?()
            pickerView.notifySelects()
        })
    }
}

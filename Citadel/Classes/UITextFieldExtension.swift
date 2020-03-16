//
//  UITextFieldExtension.swift
//  Citadel
//
//  Cretated by Shohin Tagev
//  Edited by Yunuskhuja Tuygunkhujaev on 3/16/20.
//

import UIKit

private var maxLengths = [UITextField: Int]()

extension UITextField {

    @IBInspectable public var maxLength: Int {
        get {
            guard let length = maxLengths[self] else {
                return Int.max
            }
            return length
        }
        set {
            maxLengths[self] = newValue
            self.addTarget(self, action: #selector(limitLength), for: UIControl.Event.editingChanged)
        }
    }
    
    @objc
    private func limitLength(textField: UITextField) {
        guard let prospectiveText = textField.text,
            prospectiveText.count > maxLength else {
                return
        }
        
        let selection = self.selectedTextRange
        let r = Range<String.Index>(uncheckedBounds: (lower: prospectiveText.startIndex, upper: prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)))
        self.text = String(prospectiveText[r])
        self.selectedTextRange = selection
    }
}

extension UITextField {
    private func make(horizontalPadding: CGFloat,
                      isLeft: Bool,
                      with image: UIImage?,
                      isImageCenter: Bool,
                      target: AnyObject?,
                      action: Selector?) -> UIView {
        let w = (image?.size.width ?? 0) + horizontalPadding
        let h = image?.size.height ?? 0
        let v = UIView(frame: CGRect(x: 0, y: 0, width: w, height: h))
        v.backgroundColor = UIColor.clear
        if let img = image {
            let imgView = UIImageView(frame: CGRect(x: isLeft ? horizontalPadding : 0, y: 0, width: img.size.width, height: img.size.height))
            imgView.image = img
            if isImageCenter {
                imgView.center = v.center
            }
            
            if let action = action {
                let t = target ?? self
               imgView.addTapGesture(tapNumber: 1, target: t, action: action)
            }
            v.addSubview(imgView)
        }
        return v
    }
    
    public func set(leftPadding: CGFloat,
                    with leftImage: UIImage? = nil,
                    isImageCenter: Bool = false,
                    target: AnyObject? = nil,
                    action: Selector? = nil) {
        self.leftView = self.make(horizontalPadding: leftPadding,
                                  isLeft: true,
                                  with: leftImage,
                                  isImageCenter: isImageCenter,
                                  target: target,
                                  action: action)
        self.leftViewMode = .always
    }
    
    public func set(rightPadding: CGFloat,
                    with rightImage: UIImage? = nil,
                    isImageCenter: Bool = false,
                    target: AnyObject? = nil,
                    action: Selector? = nil) {
        self.rightView = self.make(horizontalPadding: rightPadding,
                                   isLeft: false,
                                   with: rightImage,
                                   isImageCenter: isImageCenter,
                                   target: target,
                                   action: action)
        self.rightViewMode = .always
    }
}

extension UITextField {
    private func set(placeholderAttr: Any?, key: NSAttributedString.Key) {
        guard let pls = self.placeholder, !pls.isEmpty,
            let attr = placeholderAttr else {
            self.attributedPlaceholder = nil
            return
        }
        
        if let pas = self.attributedPlaceholder {
            let mAttr = NSMutableAttributedString(attributedString: pas)
            var attrs = mAttr.attributes(at: 0, effectiveRange: nil)
            attrs[key] = attr
            mAttr.setAttributes(attrs, range: NSMakeRange(0, pls.count))
            self.attributedPlaceholder = mAttr
        } else {
            self.attributedPlaceholder = NSAttributedString(string: pls, attributes: [key : attr])
        }
    }
    
    private func getPlaceholderAttr(key: NSAttributedString.Key) -> Any? {
        if let l = self.attributedPlaceholder?.length, l > 0 {
            return self.attributedPlaceholder?.attribute(key, at: 0, longestEffectiveRange: nil, in: NSMakeRange(0, l))
        } else {
            return nil
        }
    }
    
    public var placeholderColor: UIColor? {
        get {
            return self.getPlaceholderAttr(key: .foregroundColor) as? UIColor
        }
        set {
            self.set(placeholderAttr: newValue, key: .foregroundColor)
        }
    }
    
    public var placeholderFont: UIFont? {
        get {
            return self.getPlaceholderAttr(key: .font) as? UIFont
        }
        set {
            self.set(placeholderAttr: newValue, key: .font)
        }
    }
}

private let errorLblTag          = 1010101
private let errorContentTag      = 1010102

private let borderLayerName      = "Error_Border_Layer"

private let errorColor           = UIColor(hex: 0xFF5F5D)

extension UITextField {
    public var errorMessage: String? {
        get {
            return (self.viewWithTag(errorLblTag) as? UILabel)?.text
        }
        set {
            self.set(errorText: newValue)
        }
    }
    
    private func set(errorText: String?) {
        DispatchQueue.main.async {
            var lbl: UILabel! = self.viewWithTag(errorContentTag)?.viewWithTag(errorLblTag) as? UILabel
            if lbl == nil {
                lbl = UILabel()
                self.initializeErrorUI(label: lbl)
            }
            lbl.text = errorText
            let isValid = (errorText ?? "").isEmpty
            self.changedAppearance(!isValid)
        }
    }
    
    private func initializeErrorUI(label: UILabel) {
        self.clipsToBounds = false
        self.addBorder(radius: self.layer.cornerRadius)
        self.config(label: label)
        let v: CGFloat = 3
        let h: CGFloat = 10
        let cl = label.with(padding: UIEdgeInsets(top: v, left: h, bottom: v, right: h))
        self.config(content: cl)
    }
    
    private func changedAppearance(_ isAppear: Bool) {
        let isHide = !isAppear
        self.viewWithTag(errorContentTag)?.isHidden    = isHide
        self.layer.sublayers?.first(where: { (l) -> Bool in
            return l.name == borderLayerName
        })?.isHidden = isHide
    }
    
    private func addBorder(radius: CGFloat) {
        let borderLayer = CAShapeLayer()
        borderLayer.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = errorColor.cgColor
        borderLayer.lineWidth = 2
        borderLayer.name = borderLayerName
        borderLayer.frame = self.bounds
        self.layer.addSublayer(borderLayer)
    }
    
    private func config(label: UILabel) {
        label.backgroundColor = errorColor
        label.numberOfLines = 0
        label.tag = errorLblTag
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 11)
    }
    
    private func config(content: UIView) {
        content.backgroundColor = errorColor
        content.translatesAutoresizingMaskIntoConstraints = false
        content.tag = errorContentTag
        content.layer.cornerRadius = 2
        content.clipsToBounds =  true
        self.addSubview(content)
        
        let constraints = [
            NSLayoutConstraint(item: content, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 1),
            NSLayoutConstraint(item: content, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: content, attribute: .width, relatedBy: .lessThanOrEqual, toItem: self, attribute: .width, multiplier: 1, constant: 0),
            ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension UITextField {
    /// A boolean indicating whether the text is empty.
    public var isEmpty: Bool {
        return true == text?.isEmpty
    }
}

//picker
extension UITextField {
    public func setAccessoryToolbar(doneTitle: String?,
                                cancelTitle: String?,
                                doneAction: (() -> ())? = nil,
                                cancelAction: (() -> ())? = nil) {
        if doneTitle == nil
            && cancelTitle == nil {
            fatalError("Buttons titles are nil")
        }
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.isTranslucent = true
        toolbar.sizeToFit()
        
        func cancelDefAct() {
            self.resignFirstResponder()
        }
        
        func defAct() {
            guard let tshr = self.delegate?.textFieldShouldReturn else {
                cancelDefAct()
                return
            }
            _ = tshr(self)
        }
        
        var items: Array<UIBarButtonItem> = []
        if let ct = cancelTitle {
            let cancelClosure = ClosureAction({
                cancelAction?()
                cancelDefAct()
            })
            let cancelButton = UIBarButtonItem(title: ct, style: UIBarButtonItem.Style.plain, target: cancelClosure, action: #selector(cancelClosure.action(_:)))
            let attr = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 12)]
            cancelButton.setTitleTextAttributes(attr, for: .normal)
            cancelButton.setTitleTextAttributes(attr, for: .selected)
            cancelButton.storngReference(to: cancelClosure)
            items.append(cancelButton)
        }
        
        if let dt = doneTitle  {
            let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
            items.append(spaceButton)
            let doneClosure = ClosureAction({
                doneAction?()
                defAct()
            })
            
            let doneButton = UIBarButtonItem(title: dt, style: UIBarButtonItem.Style.done, target: doneClosure, action: #selector(ClosureAction.action(_:)))
            let attr = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 12)]
            doneButton.setTitleTextAttributes(attr, for: .normal)
            doneButton.setTitleTextAttributes(attr, for: .selected)
            doneButton.storngReference(to: doneClosure)
            items.append(doneButton)
        }
        
        toolbar.setItems(items, animated: false)
        toolbar.isUserInteractionEnabled = true
        self.inputAccessoryView = toolbar
    }
}

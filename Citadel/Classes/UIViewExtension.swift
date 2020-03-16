//
//  UIViewExtensions.swift
//  Citadel
//
//  Cretated by Shohin Tagev
//  Edited by Yunuskhuja Tuygunkhujaev on 3/16/20.
//

import UIKit


extension UIView {
    public convenience init(x: CGFloat, y: CGFloat, w: CGFloat, h: CGFloat) {
        self.init(frame: CGRect(x: x, y: y, width: w, height: h))
    }
    
    public convenience init(superView: UIView, padding: CGFloat) {
        self.init(frame: CGRect(x: superView.x + padding, y: superView.y + padding, width: superView.width - padding * 2, height: superView.height - padding * 2))
    }
    
    public convenience init(superView: UIView) {
        self.init(frame: CGRect(origin: CGPoint.zero, size: superView.size))
    }
}

extension UIView {
    
    public func resizeToFitSubviews() {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for someView in self.subviews {
            let aView = someView
            let newWidth = aView.x + aView.width
            let newHeight = aView.y + aView.height
            width = max(width, newWidth)
            height = max(height, newHeight)
        }
        self.frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    public func resizeToFitSubviews(tagsToIgnore: [Int]) {
        var width: CGFloat = 0
        var height: CGFloat = 0
        for someView in self.subviews {
            let aView = someView
            if !tagsToIgnore.contains(someView.tag) {
                let newWidth = aView.x + aView.width
                let newHeight = aView.y + aView.height
                width = max(width, newWidth)
                height = max(height, newHeight)
            }
        }
        self.frame = CGRect(x: x, y: y, width: width, height: height)
    }
    
    public func resizeToFitWidth() {
        let currentHeight = self.height
        self.sizeToFit()
        self.height = currentHeight
    }
    
    public func resizeToFitHeight() {
        let currentWidth = self.width
        self.sizeToFit()
        self.width = currentWidth
    }
    
    public var x: CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newX) {
            var newFrame = self.frame
            newFrame.origin.x = newX
            self.frame = newFrame
        }
    }
    
    public var y: CGFloat {
        get {
            return self.frame.origin.y
        }
        set(newY) {
            var newFrame = self.frame
            newFrame.origin.y = newY
            self.frame = newFrame
        }
    }
    
    public var width: CGFloat {
        get {
            return self.frame.size.width
        }
        set(newWidth) {
            var newFrame = self.frame
            newFrame.size.width = newWidth
            self.frame = newFrame
        }
    }
    
    public var height: CGFloat {
        get {
            return self.frame.size.height
        }
        set(newHeight) {
            var newFrame = self.frame
            newFrame.size.height = newHeight
            self.frame = newFrame
        }
    }

    public var minX: CGFloat {
        get {
            return self.frame.minX
        }
    }
    
    public var midX: CGFloat {
        get {
            return self.frame.midX
        }
    }
    
    public var maxX: CGFloat {
        get {
            return self.frame.maxX
        }
    }
    
    public var minY: CGFloat {
        get {
            return self.frame.minY
        }
    }
    public var midY: CGFloat {
        get {
            return self.frame.midY
        }
    }
    
    public var maxY: CGFloat {
        get {
            return self.frame.maxY
        }
    }
    
    public var size: CGSize {
        get {
            return self.frame.size
        } set {
            self.frame.size = newValue
        }
    }
    
    public var origin: CGPoint {
        get {
            return self.frame.origin
        } set {
            self.frame.origin = newValue
        }
    }
    
    public var left: CGFloat {
        get {
            return self.x
        } set(value) {
            self.x = value
        }
    }
    
    public var right: CGFloat {
        get {
            return self.x + self.width
        } set(value) {
            self.x = value - self.width
        }
    }
    
    public var top: CGFloat {
        get {
            return self.y
        } set(value) {
            self.y = value
        }
    }
    
    public var bottom: CGFloat {
        get {
            return self.y + self.height
        } set(value) {
            self.y = value - self.height
        }
    }
    
    public var centerX: CGFloat {
        get {
            return self.center.x
        } set(value) {
            self.center.x = value
        }
    }
    
    public var centerY: CGFloat {
        get {
            return self.center.y
        } set(value) {
            self.center.y = value
        }
    }
    
    @IBInspectable
    public var zPosition: CGFloat {
        get {
            return layer.zPosition
        }
        set(value) {
            layer.zPosition = value
        }
    }
    
    public func left(offset: CGFloat) -> CGFloat {
        return self.left - offset
    }
    
    public func right(offset: CGFloat) -> CGFloat {
        return self.right + offset
    }
    
    public func top(offset: CGFloat) -> CGFloat {
        return self.top - offset
    }
    
    public func bottom(offset: CGFloat) -> CGFloat {
        return self.bottom + offset
    }
    
    public func align(offset: CGFloat) -> CGFloat {
        return self.width - offset
    }

    public func reorderSubViews(reorder: Bool = false,
                                tagsToIgnore: [Int] = []) -> CGFloat {
        var currentHeight: CGFloat = 0
        for someView in subviews {
            if !tagsToIgnore.contains(someView.tag) && !(someView ).isHidden {
                if reorder {
                    let aView = someView
                    aView.frame = CGRect(x: aView.frame.origin.x, y: currentHeight, width: aView.frame.width, height: aView.frame.height)
                }
                currentHeight += someView.frame.height
            }
        }
        return currentHeight
    }
    
    public func scaleFrame(to scale: CGFloat) {
        var fr = self.frame
        fr.origin.x = self.x + scale
        fr.origin.y = self.y + scale
        fr.size.width = self.width - 2 * scale
        fr.size.height = self.height - 2 * scale
        self.frame = fr
    }
}

extension UIView {
    public var boundsX: CGFloat {
        get {
            return self.bounds.origin.x
        }
        set {
            var newBounds = self.bounds
            newBounds.origin.x = newValue
            self.bounds = newBounds
        }
    }
    
    public var boundsY: CGFloat {
        get {
            return self.bounds.origin.y
        }
        set {
            var newBounds = self.bounds
            newBounds.origin.y = newValue
            self.bounds = newBounds
        }
    }
    
    public var boundsWidth: CGFloat {
        get {
            return self.bounds.size.width
        }
        set {
            var newBounds = self.bounds
            newBounds.size.width = newValue
            self.bounds = newBounds
        }
    }
    
    public var boundsHeight: CGFloat {
        get {
            return self.bounds.size.height
        }
        set {
            var newBounds = self.bounds
            newBounds.size.height = newValue
            self.bounds = newBounds
        }
    }
}

extension UIView {
    public var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.clipsToBounds = true
            self.layer.cornerRadius = newValue
        }
    }
    
    public var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    
    public var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    public func addBorder(color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    public func addBorder(_ borderColor: UIColor, rect: CGRect) {
        let border = CALayer()
        border.backgroundColor = borderColor.cgColor
        border.frame = rect
        self.layer.addSublayer(border)
    }
    
    public func addTopBorder(borderColor: UIColor, borderWidth: CGFloat) {
        addBorder(borderColor, rect: CGRect(x: 0, y: 0, width: self.width, height: borderWidth))
    }
    
    public func addBottomBorder(borderColor: UIColor, borderWidth: CGFloat) {
        addBorder(borderColor, rect: CGRect(x: 0, y: self.height - borderWidth, width: self.width, height: borderWidth))
    }
    
    public func addLeftBorder(borderColor: UIColor, borderWidth: CGFloat) {
        addBorder(borderColor, rect: CGRect(x: 0, y: 0, width: borderWidth, height: self.height))
    }
    
    public func addRightBorder(borderColor: UIColor, borderWidth: CGFloat) {
        addBorder(borderColor, rect: CGRect(x: self.width - borderWidth, y: 0, width: borderWidth, height: self.height))
    }
}

//shadow
extension UIView {
    
    public func addShadow(offset: CGSize, radius: CGFloat, color: UIColor, opacity: Float, cornerRadius: CGFloat? = nil) {
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = color.cgColor
        if let r = cornerRadius {
            self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: r).cgPath
        }
    }
    
    public func addShadowBorder(color: UIColor, rect: CGRect) {
        let shadowPath = UIBezierPath(rect: rect)
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = rect.size
        self.layer.shadowOpacity = 1.0
        self.layer.shadowPath = shadowPath.cgPath
    }
    
    public var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    public var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    
    public var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }
    
    public var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
}

extension UIView {
    public func add(subviews: UIView...) {
        for sv in subviews {
            self.addSubview(sv)
        }
    }
    
    public func removeAllSubviews() {
        for v in self.subviews {
            v.removeFromSuperview()
        }
    }
}
extension UIView {
    public func scale(x: CGFloat, y: CGFloat) {
        var transform = CATransform3DIdentity
        transform.m34 = 1.0 / -1000.0
        transform = CATransform3DScale(transform, x, y, 1)
        self.layer.transform = transform
    }
}

extension UIView {
    public func drawCircle(fillColor: UIColor, strokeColor: UIColor, strokeWidth: CGFloat) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.width, height: self.width), cornerRadius: self.width / 2)
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = fillColor.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = strokeWidth
        self.layer.addSublayer(shapeLayer)
    }
    
    public func drawStroke(width: CGFloat, color: UIColor) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.width, height: self.width), cornerRadius: self.width / 2)
        let shapeLayer = CAShapeLayer ()
        shapeLayer.path = path.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = width
        self.layer.addSublayer(shapeLayer)
    }
}

private let UIViewAnimationDuration: TimeInterval = 1
private let UIViewAnimationSpringDamping: CGFloat = 0.5
private let UIViewAnimationSpringVelocity: CGFloat = 0.5

extension UIView {
    public func spring(animations: @escaping (() -> Void),
                       completion: ((Bool) -> Void)? = nil) {
        spring(duration: UIViewAnimationDuration,
               animations: animations,
               completion: completion)
    }
    
    public func spring(duration: TimeInterval,
                       animations: @escaping (() -> Void),
                       completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: UIViewAnimationDuration,
                       delay: 0,
                       usingSpringWithDamping: UIViewAnimationSpringDamping,
                       initialSpringVelocity: UIViewAnimationSpringVelocity,
                       options: UIView.AnimationOptions.allowAnimatedContent,
                       animations: animations,
                       completion: completion)
    }
    
    public func animate(_ duration: TimeInterval,
                        animations: @escaping (() -> Void),
                        completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: duration,
                       animations: animations,
                       completion: completion)
    }
    
    public func animate(animations: @escaping (()->Void),
                        completion: ((Bool) -> Void)? = nil) {
        animate(UIViewAnimationDuration,
                animations: animations,
                completion: completion)
    }
    
    public func pop() {
        self.scale(x: 1.1, y: 1.1)
        self.spring(duration: 0.2,
               animations: { [unowned self] () -> Void in
                self.scale(x: 1, y: 1)
            })
    }
    
    public func popBig() {
        self.scale(x: 1.25, y: 1.25)
        self.spring(duration: 0.2,
                    animations: { [unowned self] () -> Void in
                        self.scale(x: 1, y: 1)
        })
    }
}


extension UIView {
    public func toImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0.0)
        self.drawHierarchy(in: bounds, afterScreenUpdates: false)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img!
    }
}

extension UIView {
    
    public func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

extension UIView {
    
    /// http://stackoverflow.com/questions/4660371/how-to-add-a-touch-event-to-a-uiview/32182866#32182866
    ///
    public func addTapGesture(tapNumber: Int, target: AnyObject, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }
    
    public func addSwipeGesture(direction: UISwipeGestureRecognizer.Direction, numberOfTouches: Int, target: AnyObject, action: Selector) {
        let swipe = UISwipeGestureRecognizer(target: target, action: action)
        swipe.direction = direction
        swipe.numberOfTouchesRequired = numberOfTouches
        addGestureRecognizer(swipe)
        isUserInteractionEnabled = true
    }
    
    public func addPanGesture(target: AnyObject, action: Selector) {
        let pan = UIPanGestureRecognizer(target: target, action: action)
        addGestureRecognizer(pan)
        isUserInteractionEnabled = true
    }
    
    public func addPinchGesture(target: AnyObject, action: Selector) {
        let pinch = UIPinchGestureRecognizer(target: target, action: action)
        addGestureRecognizer(pinch)
        isUserInteractionEnabled = true
    }
    
    public func addLongPressGesture(target: AnyObject, action: Selector) {
        let longPress = UILongPressGestureRecognizer(target: target, action: action)
        addGestureRecognizer(longPress)
        isUserInteractionEnabled = true
    }
}

extension UIView {
    public func anchor(to top: NSLayoutYAxisAnchor? = nil,
                     left: NSLayoutXAxisAnchor? = nil,
                     bottom: NSLayoutYAxisAnchor? = nil,
                     right: NSLayoutXAxisAnchor? = nil) {
        self.anchorWithConstants(to: top, left: left, bottom: bottom, right: right, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
    }
    
    public func anchorWithConstants(to top: NSLayoutYAxisAnchor? = nil,
                             left: NSLayoutXAxisAnchor? = nil,
                             bottom: NSLayoutYAxisAnchor? = nil,
                             right: NSLayoutXAxisAnchor? = nil,
                             topConstant: CGFloat = 0,
                             leftConstant: CGFloat = 0,
                             bottomConstant: CGFloat = 0,
                             rightConstant: CGFloat = 0) {
        
        _ = self.anchor(top, left: left, bottom: bottom, right: right, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant)
    }
    
    public func anchor(_ top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                topConstant: CGFloat = 0,
                leftConstant: CGFloat = 0,
                bottomConstant: CGFloat = 0,
                rightConstant: CGFloat = 0,
                widthConstant: CGFloat = 0,
                heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
}

extension UIView {
    
    public func constrainCentered(_ subview: UIView) {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let verticalContraint = NSLayoutConstraint(
            item: subview,
            attribute: .centerY,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerY,
            multiplier: 1.0,
            constant: 0)
        
        let horizontalContraint = NSLayoutConstraint(
            item: subview,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self,
            attribute: .centerX,
            multiplier: 1.0,
            constant: 0)
        
        let heightContraint = NSLayoutConstraint(
            item: subview,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: subview.frame.height)
        
        let widthContraint = NSLayoutConstraint(
            item: subview,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1.0,
            constant: subview.frame.width)
        
        addConstraints([
            horizontalContraint,
            verticalContraint,
            heightContraint,
            widthContraint])
        
    }
    
    public func constrainToEdges(_ subview: UIView) {
        
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        let topContraint = NSLayoutConstraint(
            item: subview,
            attribute: .top,
            relatedBy: .equal,
            toItem: self,
            attribute: .top,
            multiplier: 1.0,
            constant: 0)
        
        let bottomConstraint = NSLayoutConstraint(
            item: subview,
            attribute: .bottom,
            relatedBy: .equal,
            toItem: self,
            attribute: .bottom,
            multiplier: 1.0,
            constant: 0)
        
        let leadingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self,
            attribute: .leading,
            multiplier: 1.0,
            constant: 0)
        
        let trailingContraint = NSLayoutConstraint(
            item: subview,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self,
            attribute: .trailing,
            multiplier: 1.0,
            constant: 0)
        
        addConstraints([
            topContraint,
            bottomConstraint,
            leadingContraint,
            trailingContraint])
    }
    
}

extension UIView {
    public func with(padding: UIEdgeInsets) -> UIView {
        let container = UIView()
        self.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(self)
        container.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "|-(\(padding.left))-[view]-(\(padding.right))-|", options: [], metrics: nil, views: ["view": self]))
        container.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(\(padding.top))-[view]-(\(padding.bottom))-|", options: [], metrics: nil, views: ["view": self]))
        return container
    }
}

extension UIView {
    public static func isNibExists(nibName: String) -> Bool {
        return Bundle.main.path(forResource: nibName, ofType: "nib") != nil
    }
}

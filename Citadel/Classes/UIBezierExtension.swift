//
//  UIBezierExtension.swift
//  Citadel
//
//  Cretated by Shohin Tagev
//  Edited by Yunuskhuja Tuygunkhujaev on 3/16/20.
//

import UIKit

//draw arrow
extension UIBezierPath {
    private class func getAxisAlignedArrow(points: inout Array<CGPoint>,
                                           forLength: CGFloat,
                                           tailWidth: CGFloat,
                                           headWidth: CGFloat,
                                           headLength: CGFloat ) {
        let tailLength = forLength - headLength
        points.append(CGPoint(x: 0, y: tailWidth / 2))
        points.append(CGPoint(x: tailLength, y: tailWidth / 2))
        points.append(CGPoint(x: tailLength, y: headWidth / 2))
        points.append(CGPoint(x: forLength, y: 0))
        points.append(CGPoint(x: tailLength, y: -headWidth / 2))
        points.append(CGPoint(x: tailLength, y: -tailWidth / 2))
        points.append(CGPoint(x: 0, y: -tailWidth / 2))
    }
    
    private class func transform(for startPoint: CGPoint,
                                 endPoint: CGPoint,
                                 length: CGFloat) -> CGAffineTransform{
        let cosine: CGFloat = (endPoint.x - startPoint.x)/length
        let sine: CGFloat = (endPoint.y - startPoint.y)/length
        return __CGAffineTransformMake(cosine, sine, -sine, cosine, startPoint.x, startPoint.y)
    }
    
    
    public class func bezierPathWithArrow(from startPoint: CGPoint,
                                   endPoint: CGPoint,
                                   tailWidth: CGFloat,
                                   headWidth: CGFloat,
                                   headLength: CGFloat) -> UIBezierPath {
        let xdiff: Float = Float(endPoint.x) - Float(startPoint.x)
        let ydiff: Float = Float(endPoint.y) - Float(startPoint.y)
        let length = hypotf(xdiff, ydiff)
        
        var points = [CGPoint]()
        self.getAxisAlignedArrow(points: &points, forLength: CGFloat(length), tailWidth: tailWidth, headWidth: headWidth, headLength: headLength)
        
        let transform: CGAffineTransform = self.transform(for: startPoint, endPoint: endPoint, length:  CGFloat(length))
        
        let cgPath: CGMutablePath = CGMutablePath()
        cgPath.addLines(between: points, transform: transform)
        cgPath.closeSubpath()
        
        let uiPath: UIBezierPath = UIBezierPath(cgPath: cgPath)
        return uiPath
    }
}

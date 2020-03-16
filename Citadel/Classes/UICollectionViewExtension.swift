//
//  UICollectionViewExtension.swift
//  Citadel
//
//  Cretated by Shohin Tagev
//  Edited by Yunuskhuja Tuygunkhujaev on 3/16/20.
//

import UIKit

extension UICollectionView {
    public func getMidVisibleIndexPath() -> IndexPath? {
        var visibleRect = self.bounds
        visibleRect.origin = self.contentOffset
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = self.indexPathForItem(at: visiblePoint) else { return nil }
        return indexPath
    }
}

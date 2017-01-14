//
//  CascadeDividerView.swift
//  CascadeKit
//
//  Created by Kevin Tulod on 1/7/17.
//  Copyright © 2017 Kevin Tulod. All rights reserved.
//

import UIKit

protocol CascadeDividerDelegate {
    
    func divider(_ divider: CascadeDividerView, shouldTranslateToCenter center: CGPoint) -> Bool
    func divider(_ divider: CascadeDividerView, didTranslateToCenter center: CGPoint)
    
}

class CascadeDividerView: UIView {

    static let touchMargin = -CGFloat(10)
    var lastCenter = CGPoint(x: 0, y: 0)
    var delegate: CascadeDividerDelegate?
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return bounds.insetBy(dx: CascadeDividerView.touchMargin, dy: 0).contains(point)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lastCenter = center
        setupPanGestures()
        
        backgroundColor = .lightGray
    }
    
    func setupPanGestures() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(CascadeDividerView.detectPan(recognizer:)))
        addGestureRecognizer(pan)
    }
    
    internal func detectPan(recognizer: UIPanGestureRecognizer) {
        
        switch recognizer.state {
            
        case .changed:
            // Translate the center only by x
            let translation = recognizer.translation(in: superview)
            let newCenter = CGPoint(x: lastCenter.x + translation.x, y: lastCenter.y)
            
            if let delegate = delegate, delegate.divider(self, shouldTranslateToCenter: newCenter) {
                center = newCenter
                delegate.divider(self, didTranslateToCenter: center)
            }
            
        case .ended:
            lastCenter = center
            
        default:
            break
        }
        
    }

}

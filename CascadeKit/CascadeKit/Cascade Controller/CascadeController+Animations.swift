//
//  CascadeController+Animations.swift
//  CascadeKit
//
//  Created by Kevin Tulod on 1/14/17.
//  Copyright © 2017 Kevin Tulod. All rights reserved.
//

import UIKit

extension CascadeController {
    
    typealias AnimationStageHandler = () -> Void
    
    /// Performs a cascade animation in the forward direction
    internal func animate(withForwardCascadeController cascadeController: UIViewController, preAnimation: AnimationStageHandler?, postAnimation: AnimationStageHandler?, completion: AnimationStageHandler?) {
        
        // Add images of the current state
        let imageViews = imageViewsForCurrentState()
        view.addSubviews([imageViews.left, imageViews.right])
        
        // Add cascading view image
        var cascadeFrame = rightViewContainer.frame
        cascadeFrame.origin.x += cascadeFrame.width
        let cascadeImageView = imageView(for: cascadeController.view, targetFrame: cascadeFrame)
        view.addSubview(cascadeImageView)
        
        // Calculate target frames
        let rightImageViewTargetFrame = leftViewContainer.frame
        let cascadeImageViewTargetFrame = rightViewContainer.frame
        var leftImageViewTargetFrame = leftViewContainer.frame
        leftImageViewTargetFrame.origin.x = -leftImageViewTargetFrame.width

        // Set alphas
        leftViewContainer.alpha = 0
        rightViewContainer.alpha = 0
        
        preAnimation?()
        
        UIView.animate(withDuration: animationDuration, delay: 0, options: [.curveEaseOut],
        animations: {
            imageViews.left.frame = leftImageViewTargetFrame
            imageViews.right.frame = rightImageViewTargetFrame
            cascadeImageView.frame = cascadeImageViewTargetFrame
            
            imageViews.right.alpha = 0.5
            self.leftViewContainer.alpha = 1
            self.rightViewContainer.alpha = 1
            
        }, completion: { success in
            postAnimation?()
            
            imageViews.left.removeFromSuperview()
            imageViews.right.removeFromSuperview()
            cascadeImageView.removeFromSuperview()
            
            completion?()
        })
        
    }
    
    /// Performs a cascade animation in the backward direction
    internal func animate(withBackwardCascadeController cascadeController: UIViewController, preAnimation: AnimationStageHandler?, postAnimation: AnimationStageHandler?, completion: AnimationStageHandler?) {
        // Add images of the current state
        let imageViews = imageViewsForCurrentState()
        view.addSubviews([imageViews.left, imageViews.right])
        
        // Add cascading view image
        var cascadeFrame = leftViewContainer.frame
        cascadeFrame.origin.x += cascadeFrame.width
        let cascadeImageView = imageView(for: cascadeController.view, targetFrame: cascadeFrame)
        view.addSubview(cascadeImageView)
        
        // Calculate target frames
        let leftImageViewTargetFrame = rightViewContainer.frame
        let cascadeImageViewTargetFrame = leftViewContainer.frame
        var rightImageViewTargetFrame = rightViewContainer.frame
        rightImageViewTargetFrame.origin.x += rightImageViewTargetFrame.width
        
        // Set alphas
        leftViewContainer.alpha = 0
        rightViewContainer.alpha = 0
        
        preAnimation?()
        
        UIView.animate(withDuration: animationDuration,
                       delay: 0,
                       options: [.curveEaseOut],
                       animations: {
            imageViews.left.frame = leftImageViewTargetFrame
            imageViews.right.frame = rightImageViewTargetFrame
            cascadeImageView.frame = cascadeImageViewTargetFrame

            imageViews.left.alpha = 0.5
            self.leftViewContainer.alpha = 1
            self.rightViewContainer.alpha = 1

        }, completion: { success in
            postAnimation?()
            
            imageViews.left.removeFromSuperview()
            imageViews.right.removeFromSuperview()
            cascadeImageView.removeFromSuperview()
            
            completion?()
        })
    }
    
    /// Returns the image view representations for the left and right views
    fileprivate func imageViewsForCurrentState() -> (left: UIImageView, right: UIImageView) {
        let leftImageView = UIImageView(frame: leftViewContainer.frame)
        leftImageView.image = UIImage.image(from: leftController?.view)
        
        let rightImageView = UIImageView(frame: rightViewContainer.frame)
        rightImageView.image = UIImage.image(from: rightController?.view)
        
        return (leftImageView, rightImageView)
    }
    
    /// Returns an image view representation of the passed-in view in the target frame
    fileprivate func imageView(for pendingView: UIView, targetFrame: CGRect) -> UIImageView {
        let tempView = UIView(frame: targetFrame)
        tempView.fill(with: pendingView)

        let pendingViewImageView = UIImageView(frame: targetFrame)
        pendingViewImageView.image = UIImage.image(from: tempView)

        return pendingViewImageView
    }
    
}

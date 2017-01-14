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
    
    internal func performForwardCascadeAnimation(cascadeController: UIViewController, preAnimation: AnimationStageHandler?, postAnimation: AnimationStageHandler?, completion: AnimationStageHandler?) {
        
        // Add image representations
        let leftImageView = UIImageView(frame: leftViewContainer.frame)
        leftImageView.image = UIImage.image(fromView: leftController?.view)
        view.addSubview(leftImageView)
        
        let rightImageView = UIImageView(frame: rightViewContainer.frame)
        rightImageView.image = UIImage.image(fromView: rightController?.view)
        view.addSubview(rightImageView)
        
        // Add cascading view
        var cascadeFrame = rightViewContainer.frame
        cascadeFrame.origin.x += cascadeFrame.width
        
        let cascadeTempView = UIView(frame: cascadeFrame)
        cascadeTempView.fill(withSubview: cascadeController.view)
        view.addSubview(cascadeTempView)
        
        let cascadeImageView = UIImageView(frame: cascadeFrame)
        cascadeImageView.image = UIImage.image(fromView: cascadeTempView)
        view.addSubview(cascadeImageView)
        cascadeTempView.removeFromSuperview()
        
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
            leftImageView.frame = leftImageViewTargetFrame
            rightImageView.frame = rightImageViewTargetFrame
            cascadeImageView.frame = cascadeImageViewTargetFrame
            
            rightImageView.alpha = 0.5
            self.leftViewContainer.alpha = 1
            self.rightViewContainer.alpha = 1
            
        }, completion: { success in
            postAnimation?()
            
            leftImageView.removeFromSuperview()
            rightImageView.removeFromSuperview()
            cascadeImageView.removeFromSuperview()
            
            completion?()
        })
        
    }
    
}

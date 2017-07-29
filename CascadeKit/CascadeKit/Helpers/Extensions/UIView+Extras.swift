//
//  UIView+Extras.swift
//  CascadeKit
//
//  Created by Kevin Tulod on 1/7/17.
//  Copyright © 2017 Kevin Tulod. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Adds the given view as a subview of the receiver and achors the top, bottom, left, and right
    func fill(with subview: UIView) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        subview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        subview.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        subview.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    /// Adds an array of views as subviews of the receiver
    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach({ subview in
            self.addSubview(subview)
        })
    }
    
}

//
//  UIScreen+Extras.swift
//  CascadeKit
//
//  Created by Kevin Tulod on 1/7/17.
//  Copyright © 2017 Kevin Tulod. All rights reserved.
//

import UIKit

extension UIScreen {
    
    /// Returns the exact value of one pixel in the current screen's scale
    var onePx: CGFloat {
        return CGFloat(1)/nativeScale
    }
    
}

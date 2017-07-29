//
//  UIImage+Extras.swift
//  CascadeKit
//
//  Created by Kevin Tulod on 1/14/17.
//  Copyright © 2017 Kevin Tulod. All rights reserved.
//

import UIKit

extension UIImage {
    
    /// Creates an image of a UIView in the current context
    class func image(from view: UIView?) -> UIImage? {
        guard let view = view else { return nil }
        
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        
        var image: UIImage?
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        
        UIGraphicsEndImageContext()
        
        return image
    }

}

//
//  UIViewController+CascadeController.swift
//  CascadeKit
//
//  Created by Kevin Tulod on 1/14/17.
//  Copyright © 2017 Kevin Tulod. All rights reserved.
//

import UIKit

/// Extension for UIViewController that provides a reference to the containing CascadeController, if any
extension UIViewController {
    
    /// Provides a reference to the containing CascadeController, if any
    public var cascadingController: CascadeController? {
        var controller = self
        if let cascadeController = controller as? CascadeController {
            // If self is the CascadeController, return the casted form
            return cascadeController
        }
        
        // Look through the view controller parents for the CascadeController and return it if found
        while let parent = controller.parent {
            controller = parent
            
            if let cascadeController = controller as? CascadeController {
                return cascadeController
            }
        }
        
        // No CascadeController found in the parent hierarchy. Return nil
        return nil
        
    }
    
}

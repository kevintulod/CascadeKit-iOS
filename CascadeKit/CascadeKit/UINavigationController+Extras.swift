//
//  UINavigationController+Extras.swift
//  CascadeKit
//
//  Created by Kevin Tulod on 1/16/17.
//  Copyright © 2017 Kevin Tulod. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    var rootViewController: UIViewController? {
        if viewControllers.count > 0 {
            return viewControllers[0]
        } else {
            return nil
        }
    }
    
}

//
//  CascadingNavigationController.swift
//  CascadeExample
//
//  Created by Kevin Tulod on 1/7/17.
//  Copyright © 2017 Kevin Tulod. All rights reserved.
//

import UIKit
import CascadeKit

class CascadingNavigationController: UINavigationController {

    init(tableNumber: Int) {
        let tableController = CascadingTableViewController(panelNumber: tableNumber)
        super.init(rootViewController: tableController)
    }
    
    // Required initializers
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

}

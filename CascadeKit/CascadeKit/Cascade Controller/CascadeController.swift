//
//  CascadeController.swift
//  CascadeKit
//
//  Created by Kevin Tulod on 1/7/17.
//  Copyright © 2017 Kevin Tulod. All rights reserved.
//

import UIKit

public class CascadeController: UIViewController {
    
    @IBOutlet weak var leftViewContainer: UIView!
    @IBOutlet weak var rightViewContainer: UIView!
    
    @IBOutlet weak var dividerView: CascadeDividerView!
    @IBOutlet weak var dividerViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var dividerViewPositionConstraint: NSLayoutConstraint!
    
    internal var controllers = [UINavigationController]()
    
    internal weak var leftController: UINavigationController? {
        didSet {
            guard let leftController = leftController else {
                return
            }
            addChildViewController(leftController)
            leftViewContainer.fill(withSubview: leftController.view)
            leftController.rootViewController?.navigationItem.leftBarButtonItem = nil
        }
    }
    
    internal weak var rightController: UINavigationController? {
        didSet {
            guard let rightController = rightController else {
                return
            }
            addChildViewController(rightController)
            rightViewContainer.fill(withSubview: rightController.view)
            
            if controllers.count > 0 {
                rightController.rootViewController?.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(CascadeController.popLastViewController))
            }
        }
    }
    
    /// Minimum size for left and right views
    public var minimumViewSize = CGFloat(250)
    
    /// Duration of cascade animations in seconds
    public var animationDuration = TimeInterval(0.25)
    
    // MARK: - Creation
    private static let storyboardName = "Cascade"
    private static let storyboardIdentifier = "CascadeController"
    public static func create() -> CascadeController {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle(for: CascadeController.self))
        guard let controller = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? CascadeController else {
            fatalError("`Cascade` storyboard is missing required reference to `CascadeController`")
        }
        let _ = controller.view
        return controller
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        dividerView.delegate = self
        setupStyling()
    }
    
    public override func addChildViewController(_ childController: UIViewController) {
        super.addChildViewController(childController)
    }
    
    /// Sets up the cascade controller with the initial view controllers
    public func setup(first: UINavigationController, second: UINavigationController) {
        leftController = first
        rightController = second
    }
    
    /// Cascades the view controller to the top of the stack
    public func cascadeViewController(_ cascadeController: UINavigationController, sender: UINavigationController? = nil) {
        
        if sender === leftController {
            // If the provided sender is the second-to-last in the stack, replace the last controller
            popControllerFromStack()
            addControllerToStack(cascadeController)
            rightController = cascadeController
            
        } else {
            // All other cases, push the controller to the end
            
            performForwardCascadeAnimation(cascadeController: cascadeController, preAnimation: { Void in
                self.addControllerToStack(self.leftController)
                self.leftController = self.rightController
                
            }, postAnimation: { Void in
                self.rightController = cascadeController
                
            }, completion: nil)
        }
    }
    
    /// Pops the last controller off the top of the stack
    public func popLastViewController() {
        guard let poppedController = popControllerFromStack() else {
            NSLog("No controller in stack to pop.")
            return
        }
        
        performBackwardCascadeAnimation(cascadeController: poppedController, preAnimation: { Void in
            self.rightController = self.leftController
            
        }, postAnimation: { Void in
            self.leftController = poppedController
            
        }, completion: nil)
    }
    
    internal func addControllerToStack(_ controller: UINavigationController?) {
        if let controller = controller {
            controllers.append(controller)
        }
    }
    
    internal func popControllerFromStack() -> UINavigationController? {
        return controllers.popLast()
    }
    
}

extension CascadeController: CascadeDividerDelegate {
    
    func divider(_ divider: CascadeDividerView, shouldTranslateToCenter center: CGPoint) -> Bool {
        // Only allow the divider to translate if the minimum view sizes are met on the left and right
        return center.x >= minimumViewSize && center.x <= view.frame.width-minimumViewSize
    }
    
    func divider(_ divider: CascadeDividerView, didTranslateToCenter center: CGPoint) {
        dividerViewPositionConstraint.constant = center.x
    }
}

// MARK: - Styling
extension CascadeController {
    
    func setupStyling() {
        leftViewContainer.backgroundColor = .white
        rightViewContainer.backgroundColor = .white
        dividerViewWidthConstraint.constant = UIScreen.main.onePx
    }
    
}

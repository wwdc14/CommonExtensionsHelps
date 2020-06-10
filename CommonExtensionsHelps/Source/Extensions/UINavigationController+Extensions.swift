//
//  UINavigationController+Extensions.swift
//  mouplan
//
//  Created by 胡毅 on 2019/6/2.
//  Copyright © 2019 Hy. All rights reserved.
//

import UIKit
// MARK: - Methods
extension UINavigationController {
    
    /// SwifterSwift: Pop ViewController with completion handler.
    ///
    /// - Parameters:
    ///   - animated: Set this value to true to animate the transition (default is true).
    ///   - completion: optional completion handler (default is nil).
    func popViewController(animated: Bool = true, _ completion: (() -> Void)? = nil) {
        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        popViewController(animated: animated)
        CATransaction.commit()
    }
    
    /// SwifterSwift: Push ViewController with completion handler.
    ///
    /// - Parameters:
    ///   - viewController: viewController to push.
    ///   - completion: optional completion handler (default is nil).
    func pushViewController(_ viewController: UIViewController, completion: (() -> Void)? = nil) {
        // https://github.com/cotkjaer/UserInterface/blob/master/UserInterface/UIViewController.swift
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        pushViewController(viewController, animated: true)
        CATransaction.commit()
    }
    
    /// SwifterSwift: Make navigation controller's navigation bar transparent.
    ///
    /// - Parameter tint: tint color (default is .white).
    func makeTransparent(withTint tint: UIColor = .white) {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.tintColor = tint
        navigationBar.titleTextAttributes = [.foregroundColor: tint]
    }
    
    func removeViewControllerClass(_ removeViewControllerClass: AnyClass, animated: Bool = true) {
        removeViewControllerClasss([removeViewControllerClass], animated: animated)
    }
    
    func removeViewControllerClasss(_ removeViewControllerClasss: [AnyClass], animated: Bool = true) {
        let filter = viewControllers.filter { (viewController) -> Bool in
            removeViewControllerClasss.map{ return $0.description()
                }.contains(type(of: viewController).description())
        }
        removeViewControllers(filter, animated: animated)
    }
    
    func removeViewControllers(_ removeViewControllers: [UIViewController], animated: Bool = true) {
        let filter = viewControllers.filter { !removeViewControllers.contains($0) }
        setViewControllers(filter, animated: animated)
    }
    
    func removeViewController(_ removeViewController: UIViewController, animated: Bool = true) {
        removeViewControllers([removeViewController])
    }
    
}

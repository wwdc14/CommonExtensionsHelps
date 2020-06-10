//
//  UIViewControllerExtensions.swift
//  CommonExtensionsHelps
//
//  Created by 胡毅 on 2020/4/27.
//  Copyright © 2020 Hy. All rights reserved.
//

import MBProgressHUD

extension UIViewController {
    private var _window: UIView {
        if let window = view.window {
            return window
        } else if let window = UIApplication.shared.windows.first {
            return window
        } else {
            return view
        }
    }
    
    public var hud: MBProgressHUD {
        let _mbpro: MBProgressHUD
        if let mbpro = MBProgressHUD.forView(_window) {
            _mbpro = mbpro
        } else {
            _mbpro = MBProgressHUD(view: _window)
            _window.addSubview(_mbpro)
            _mbpro.applyHUDAppearanceStyle()
        }
        return _mbpro
    }
    
}

extension UIViewController: UIViewControllerPlaceholdersble {
    fileprivate struct AssociatedKeys {
        static let isLoading = "com.hy.isLoading"
        static var placeholder = "com.hy.placeholder"
        static let currentAnimator = "currentAnimator"
    }
    
    public var placeholdersMargin: UIEdgeInsets { .zero }
    
    public private(set) var placeholder: Placeholdersble {
        get {
            let _placeholder: Placeholdersble
            let pls = objc_getAssociatedObject(self, &AssociatedKeys.placeholder)
            if let pls = pls as? Placeholdersble {
                _placeholder = pls
            } else {
                _placeholder = DefaultPlaceholder()
                _set_placeholder(_placeholder)
            }
            view.bringSubviewToFront(_placeholder)
            return _placeholder
        }
        set {
            self.placeholder.removeFromSuperview()
            _set_placeholder(newValue)
        }
    }
    
    public func placeholdersProvider() -> UIViewControllerPlaceholdersbleProvider {
        return .default
    }
    
    /// 刷新当前占位视图
    public func setNeedsPlaceholderUpdate() {
        let provider = placeholdersProvider()
        switch provider {
        case .custom(view: let view):
            self.placeholder = view
        case .default:
            if !placeholder.isKind(of: DefaultPlaceholder.self) {
                let def = DefaultPlaceholder()
                placeholder = def
            }
        }
        placeholder.onState(.none)
    }
    
    private func _set_placeholder(_ newValue: Placeholdersble) {
        newValue.translatesAutoresizingMaskIntoConstraints = false
        objc_setAssociatedObject(self, &AssociatedKeys.placeholder, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        view.addSubview(newValue)
        NSLayoutConstraint.activate([
            newValue.topAnchor.constraint(equalTo: view.topAnchor, constant: placeholdersMargin.top),
            newValue.leftAnchor.constraint(equalTo: view.leftAnchor, constant: placeholdersMargin.left),
            newValue.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: placeholdersMargin.bottom),
            newValue.rightAnchor.constraint(equalTo: view.rightAnchor, constant: placeholdersMargin.right),
        ])
    }
    
}

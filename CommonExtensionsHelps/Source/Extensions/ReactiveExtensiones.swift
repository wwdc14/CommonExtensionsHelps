//
//  ReactiveExtensiones.swift
//  CommonExtensionsHelps
//
//  Created by 胡毅 on 2020/4/27.
//  Copyright © 2020 Hy. All rights reserved.
//

import SwiftyJSON
import RxSwift
import RxCocoa
import UIKit
import Moya

extension Reactive where Base: UIViewController {
    
    /// Bindable sink for `startAnimating()`, `stopAnimating()` methods.
    public var isLoading: Binder<Bool> {
        return Binder(self.base, binding: { (vc, active) in
            if let vc = vc as? UIViewControllerLoadingble {
                if active {
                    vc.startLoading()
                } else {
                    vc.stopLoading()
                }
            }
        })
    }
    
    public var state: Binder<PlaceholderState> {
        return Binder(self.base, binding: { (vc, state) in
            vc.placeholder.onState(state)
        })
    }
    
}

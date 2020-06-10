//
//  LoadingViewble.swift
//  CommonExtensionsHelps
//
//  Created by 胡毅 on 2020/4/27.
//  Copyright © 2020 Hy. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

public protocol UIViewControllerLoadingble {
    func startLoading()
    func stopLoading()
}

public protocol Placeholdersble where Self: UIView {
    func onState(_ state: PlaceholderState)
}

public protocol UIViewControllerPlaceholdersble where Self: UIViewController {
    
    /// 上下左右边距
    var placeholdersMargin: UIEdgeInsets { get }
    
    /// 网络请求的占位视图
    func placeholdersProvider() -> UIViewControllerPlaceholdersbleProvider
}


/// 仅仅给View扩展一个传值的方法...
public protocol ViewModelble where Self: UIView {
    associatedtype ModelType
    func update(_ object: ModelType)
    
}

public protocol ViewModelType {
    associatedtype Inputs
    associatedtype Outputs
    
    func transform(input: Inputs) -> Outputs
}

public protocol ViewModelControllerStateble {
    var state: Driver<PlaceholderState> { get }
    var loading: Driver<Bool> { get }
}

public protocol PushRegistrationType {
    static func register(for options: UNAuthorizationOptions) -> Observable<Bool>
    static func hasAuthorizedNotifications() -> Observable<Bool>
}

public protocol CameraRegistrationType {
    static func register() -> Single<Bool>
    static func hasAuthorizedCamera() -> Single<Bool>
}

public protocol PhotoRegistrationType {
    static func register() -> Single<Bool>
    static func hasAuthorizedPhotos() -> Single<Bool>
}

public protocol ServiceSuccessVerification {
    var statusCodes: [Int] { get }
    var statusKey: String { get }
    var messageKey: String { get }
    var contentKey: String { get }
}

//
//  Kingfisher+Rx.swift
//  CommonExtensionsHelps
//
//  Created by 胡毅 on 2020/5/7.
//  Copyright © 2020 Hy. All rights reserved.
//

import RxCocoa
import RxSwift
import Kingfisher

public extension Reactive where Base == KingfisherWrapper<KFCrossPlatformImageView> {
    func setImage(with source: Source?,
                         placeholder: Placeholder? = nil,
                         options: KingfisherOptionsInfo? = nil) -> Single<KFCrossPlatformImage> {
        return Single.create { [base] single in
            let task = base.setImage(with: source,
                                     placeholder: placeholder,
                                     options: options) { result in
                switch result {
                case .success(let value):
                    single(.success(value.image))
                case .failure(let error):
                    single(.error(error))
                }
            }
            
            return Disposables.create { task?.cancel() }
        }
    }
    
    func setImage(with resource: Resource?,
                         placeholder: Placeholder? = nil,
                         options: KingfisherOptionsInfo? = nil) -> Single<KFCrossPlatformImage> {
        let source: Source?
        if let resource = resource {
            source = Source.network(resource)
        } else {
            source = nil
        }
        return setImage(with: source, placeholder: placeholder, options: options)
    }

    func image(placeholder: Placeholder? = nil,
                      options: KingfisherOptionsInfo? = nil) -> Binder<Resource?> {
        // `base.base` is the `Kingfisher` class' associated `ImageView`.
        return Binder(base.base) { imageView, image in
            imageView.kf.setImage(with: image,
                                  placeholder: placeholder,
                                  options: options)
        }
    }
}

extension KingfisherWrapper: ReactiveCompatible { }



public extension Reactive where Base == KingfisherManager {
    func retrieveImage(with source: Source,
                              options: KingfisherOptionsInfo? = nil) -> Single<KFCrossPlatformImage> {
        return Single.create { [base] single in
            let task = base.retrieveImage(with: source,
                                          options: options) { result in
                switch result {
                case .success(let value):
                    single(.success(value.image))
                case .failure(let error):
                    single(.error(error))
                }
            }

            return Disposables.create { task?.cancel() }
        }
    }
    
    func retrieveImage(with resource: Resource,
                              options: KingfisherOptionsInfo? = nil) -> Single<KFCrossPlatformImage> {
        let source = Source.network(resource)
        return retrieveImage(with: source, options: options)
    }

}

extension KingfisherManager: ReactiveCompatible {
    open var rx: Reactive<KingfisherManager> {
        get { return Reactive(self) }
        set { }
    }
}

//
//  AuthorityManage.swift
//  CommonExtensionsHelps
//
//  Created by 胡毅 on 2020/5/1.
//  Copyright © 2020 Hy. All rights reserved.
//
import AVKit
import Photos
import RxSwift
import Foundation
import UserNotifications

public struct AuthorityManage {
    public static let current = AuthorityManage()
    public let pusherAuthority = RemotePusherAuthority.self
    public let cameraAuthority = CameraAuthority.self
    public let photosAuthority = PhotosAuthority.self
}

public extension AuthorityManage {
    struct RemotePusherAuthority { }
    struct CameraAuthority { }
    struct PhotosAuthority { }
    enum Error {
        case camera(_ des: String)
        case photos(_ des: String)
    }
}

extension AuthorityManage.PhotosAuthority: PhotoRegistrationType {
    public static func register() -> Single<Bool> {
        return Single.create { single -> Disposable in
            let authStatus = PHPhotoLibrary.authorizationStatus()
            if authStatus == .notDetermined {
                PHPhotoLibrary.requestAuthorization { status in
                    if status == .authorized {
                        single(.success(true))
                    } else {
                        single(.error(AuthorityManage.Error.photos("Photo access denied")))
                    }
                }
            } else if authStatus == .authorized {
                single(.success(true))
            } else {
                single(.error(AuthorityManage.Error.photos("Photo access denied")))
            }
            return Disposables.create()
        }
    }
    
    public static func hasAuthorizedPhotos() -> Single<Bool> {
        return Single.create { single -> Disposable in
            let authStatus = PHPhotoLibrary.authorizationStatus()
            if authStatus == .notDetermined {
                single(.success(false))
            } else if authStatus == .authorized {
                single(.success(true))
            } else {
                single(.error(AuthorityManage.Error.photos("Photo access denied")))
            }
            return Disposables.create()
        }
    }
    
    
}

extension AuthorityManage.CameraAuthority: CameraRegistrationType {
    public static func register() -> Single<Bool> {
        return Single.create { single -> Disposable in
            let videoAuthStatus = AVCaptureDevice.authorizationStatus(for: .video)
            if videoAuthStatus == .notDetermined {
                AVCaptureDevice.requestAccess(for: .video) { success in
                    single(.success(success))
                }
            } else if videoAuthStatus == .authorized {
                single(.success(true))
            } else {
                single(.error(AuthorityManage.Error.camera("Camera access denied")))
            }
            return Disposables.create()
        }
    }
    
    public static func hasAuthorizedCamera() -> Single<Bool> {
        return Single.create { single -> Disposable in
            let videoAuthStatus = AVCaptureDevice.authorizationStatus(for: .video)
            if videoAuthStatus == .notDetermined {
                single(.success(false))
            } else if videoAuthStatus == .authorized {
                single(.success(true))
            } else {
                single(.success(false))
            }
            return Disposables.create()
        }
    }
    
}

extension AuthorityManage.Error: Error { }

extension AuthorityManage.RemotePusherAuthority: PushRegistrationType {
   
    /// Returns a signal producer that emits an option `Bool` value representing whether or not the user
    /// granted the requested push notification permissions. This value is not returned on iOS versions < 10.0.
    /// The returned producer emits once and completes.
    /// - Parameter options: The types to register that we will request permissions for.
    /// - returns: A signal producer.
    public static func register(for options: UNAuthorizationOptions) -> Observable<Bool> {
        return Observable<Bool>.create { observer -> Disposable in
            UNUserNotificationCenter.current().requestAuthorization(options: options) { isGranted, _ in
                if isGranted {
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
                observer.onNext(isGranted)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    /// Returns a signal producer that emits a `Bool` value representing whether the user has allowed push
    /// notification permissions in the past.
    /// The returned producer emits once and completes
    /// - returns: A signal producer.
    public static func hasAuthorizedNotifications() -> Observable<Bool> {
        return Observable<Bool>.create { observer -> Disposable in
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                observer.onNext(settings.authorizationStatus == .authorized)
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}

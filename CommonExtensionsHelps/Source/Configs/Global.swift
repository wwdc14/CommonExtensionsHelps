//
//  Global.swift
//  CommonExtensionsHelps
//
//  Created by 胡毅 on 2020/4/28.
//  Copyright © 2020 Hy. All rights reserved.
//

import UIKit

public enum ServiceError: Error {
    case mapper(_ description: String)
    case serverApi(_ description: String)
    case other(_ description: String)
}

extension ServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case let .mapper(description): return description
        case let .serverApi(description): return description
        case let .other(description): return description
        }
    }
}


public enum UIViewControllerPlaceholdersbleProvider {
    case custom(view: Placeholdersble)
    case `default`
}


public enum PlaceholderState {
    case none
    case loading
    case error(_ error: Error)
    case success
}

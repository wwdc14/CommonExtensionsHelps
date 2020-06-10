//
//  Route.swift
//  CommonExtensionsHelps
//
//  Created by 胡毅 on 2020/4/29.
//  Copyright © 2020 Hy. All rights reserved.
//

import Moya

/// `Route` has HTTP method and URL path.
///
/// Example:
///
/// ```
/// .get("/me")
/// ```
public enum Route {
    case get(String)
    case post(String)
    case put(String)
    case delete(String)
    case options(String)
    case head(String)
    case patch(String)
    case trace(String)
    case connect(String)

    public var path: String {
        switch self {
        case let .get(path): return path
        case let .post(path): return path
        case let .put(path): return path
        case let .delete(path): return path
        case let .options(path): return path
        case let .head(path): return path
        case let .patch(path): return path
        case let .trace(path): return path
        case let .connect(path): return path
        }
    }

    public var method: Moya.Method {
        switch self {
        case .get: return .get
        case .post: return .post
        case .put: return .put
        case .delete: return .delete
        case .options: return .options
        case .head: return .head
        case .patch: return .patch
        case .trace: return .trace
        case .connect: return .connect
        }
    }
}

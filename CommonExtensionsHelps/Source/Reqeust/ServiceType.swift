//
//  ServiceType.swift
//  CommonExtensionsHelps
//
//  Created by 胡毅 on 2020/4/29.
//  Copyright © 2020 Hy. All rights reserved.
//
import Moya

public protocol ServiceType: TargetType {
    var url: URL { get }
    /// Returns `Route` which contains HTTP method and URL path information.
    ///
    /// Example:
    ///
    /// ```
    /// var route: Route {
    ///   return .get("/me")
    /// }
    /// ```
    var route: Route { get }
    var parameters: Parameters? { get }
}

public extension ServiceType {
    var url: URL {
        return self.defaultURL
    }

    var defaultURL: URL {
        return self.path.isEmpty ? self.baseURL : self.baseURL.appendingPathComponent(self.path)
    }

    var path: String {
        return self.route.path
    }

    var method: Moya.Method {
        return self.route.method
    }
    
}


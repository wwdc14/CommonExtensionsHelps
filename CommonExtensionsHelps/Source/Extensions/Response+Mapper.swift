//
//  Response+Mapper.swift
//  CommonExtensionsHelps
//
//  Created by 胡毅 on 2020/4/30.
//  Copyright © 2020 Hy. All rights reserved.
//

import Moya
import SwiftyJSON

public extension Response {
    
    func mapperSuccessfulValue<R: ServiceSuccessVerification>(_ value: R) -> Result<JSON, Error> {
        let result = mapperJSON()
        switch result {
        case .success(let json):
            let statusCode = json[value.statusKey].intValue
            if value.statusCodes.contains(statusCode) {
                return .success(json[value.contentKey])
            } else {
                if let errorMessage = json[value.messageKey].string {
                    return .failure(ServiceError.serverApi(errorMessage))
                } else {
                    return .success(json)
                }
            }
        case .failure(let error):
            return .failure(ServiceError.mapper(error.localizedDescription))
        }
        
    }
    
    func mapperJSON(atKeyPath keyPath: String? = nil, options: JSONSerialization.ReadingOptions = .allowFragments ) -> Result<JSON, Error> {
        do {
            let json = try JSON.init(data: data, options: options)
            if let keyPath = keyPath {
                return .success(json[keyPath])
            } else {
                return .success(json)
            }
        } catch {
            return .failure(ServiceError.mapper(error.localizedDescription))
        }
    }
    
}

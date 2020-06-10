//
//  Response+Mapper.swift
//  CommonExtensionsHelps
//
//  Created by 胡毅 on 2020/4/30.
//  Copyright © 2020 Hy. All rights reserved.
//

import Moya
import SwiftyJSON
import Foundation

public extension Response {
    
    func mapperSuccessfulValue<R: ServiceSuccessVerification>(_ value: R) throws -> JSON {
        
        do {
            let json = try mapperJSON()
            let statusCode = json[value.statusKey].intValue
            if value.statusCodes.contains(statusCode) {
                return json[value.contentKey]
            } else {
                if let errorMessage = json[value.messageKey].string {
                    throw ServiceError.serverApi(errorMessage)
                } else {
                    return json
                }
            }
        } catch {
            throw ServiceError.mapper(error.localizedDescription)
        }
        
    }
    
    func mapperJSON(atKeyPath keyPath: String? = nil, options: JSONSerialization.ReadingOptions = .allowFragments ) throws -> JSON {
        do {
            let json = try JSON.init(data: data, options: options)
            if let keyPath = keyPath {
                return json[keyPath]
            } else {
                return json
            }
        } catch {
            throw ServiceError.mapper(error.localizedDescription)
        }
    }
    
}

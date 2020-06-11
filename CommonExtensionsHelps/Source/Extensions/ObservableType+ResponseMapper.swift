import Foundation
import SwiftyJSON
import RxSwift
import RxCocoa
import Moya

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    
    public func mapperSuccessfulValue<R: ServiceSuccessVerification>(_ value: R) -> Single<Result<JSON, Error>> {
        return flatMap { .just($0.mapperSuccessfulValue(value)) }
    }
    
    public func mapperJSON(atKeyPath keyPath: String? = nil, options: JSONSerialization.ReadingOptions = .allowFragments ) -> Single<Result<JSON, Error>> {
        return flatMap { .just($0.mapperJSON(atKeyPath: keyPath, options: options)) }
    }
}

extension ObservableType where Element == Response {
    
    public func mapperSuccessfulValue<R: ServiceSuccessVerification>(_ value: R) -> Observable<Result<JSON, Error>> {
        return flatMap { Observable.just($0.mapperSuccessfulValue(value)) }
    }
    
    public func mapperJSON(atKeyPath keyPath: String? = nil, options: JSONSerialization.ReadingOptions = .allowFragments ) -> Observable<Result<JSON, Error>> {
        return flatMap { Observable.just($0.mapperJSON(atKeyPath: keyPath, options: options)) }
    }
}

import SwiftyJSON
import RxSwift
import RxCocoa
import Moya

extension PrimitiveSequence where Trait == SingleTrait, Element == Response {
    
    public func mapperSuccessfulValue<R: ServiceSuccessVerification>(_ value: R) -> Single<JSON> {
        return flatMap { .just(try $0.mapperSuccessfulValue(value)) }
    }
    
    public func mapperJSON(atKeyPath keyPath: String? = nil, options: JSONSerialization.ReadingOptions = .allowFragments ) -> Single<JSON> {
        return flatMap { .just(try $0.mapperJSON(atKeyPath: keyPath, options: options)) }
    }
}

extension ObservableType where Element == Response {
    
    public func mapperSuccessfulValue<R: ServiceSuccessVerification>(_ value: R) -> Observable<JSON> {
        return flatMap { Observable.just(try $0.mapperSuccessfulValue(value)) }
    }
    
    public func mapperJSON(atKeyPath keyPath: String? = nil, options: JSONSerialization.ReadingOptions = .allowFragments ) -> Observable<JSON> {
        return flatMap { Observable.just(try $0.mapperJSON(atKeyPath: keyPath, options: options)) }
    }
}

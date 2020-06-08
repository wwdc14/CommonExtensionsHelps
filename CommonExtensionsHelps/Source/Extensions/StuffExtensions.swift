import RxSwift
import RxCocoa
private struct AssociatedKeys {
    static var p_state_key = "com.CommonExtensionsHelps.p_state_key"
    static var p_loading_key = "com.CommonExtensionsHelps.p_loading_key"
}
public extension ViewModelControllerStateble where Self: Any {
    
    var state: Driver<PlaceholderState> {
        return _state.asDriver { error -> Driver<PlaceholderState> in
            return Driver.just(.error(error))
        }
    }
    
    var loading: Driver<Bool> {
        return _loading.asDriver(onErrorJustReturn: false)
    }
    
    var _loading: PublishSubject<Bool> {
        get {
            if let p_loading = objc_getAssociatedObject(self, &AssociatedKeys.p_loading_key) as? PublishSubject<Bool> {
                return p_loading
            }
            let p_loading = PublishSubject<Bool>.init()
            objc_setAssociatedObject(self, &AssociatedKeys.p_loading_key, p_loading, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return p_loading
        }
    }
    
    var _state: PublishSubject<PlaceholderState> {
        get {
            if let p_state = objc_getAssociatedObject(self, &AssociatedKeys.p_state_key) as? PublishSubject<PlaceholderState> {
                return p_state
            }
            let p_state = PublishSubject<PlaceholderState>.init()
            objc_setAssociatedObject(self, &AssociatedKeys.p_state_key, p_state, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return p_state
        }
    }
}

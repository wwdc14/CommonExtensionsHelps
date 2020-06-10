import RxSwift
import RxCocoa
import MJRefresh

//对MJRefreshComponent增加rx扩展
public extension Reactive where Base: MJRefreshComponent {
    
    //正在刷新事件
    var refreshing: ControlEvent<MJRefreshState> {
        let source: Observable<MJRefreshState> = Observable.create {
            [weak control = self.base] observer  in
            if let control = control {
                control.refreshingBlock = { [weak control] in
                    observer.on(.next(control?.state ?? .idle))
                }
            }
            return Disposables.create()
        }
        return ControlEvent(events: source)
    }
    
    //停止刷新
    var endRefreshing: Binder<Void> {
        return Binder(base) { refresh, isEnd in
            refresh.endRefreshing()
        }
    }
}

import Moya

open class ServiceAPI: ServiceType {
    
    let method: ModuleType
    public init(_ method: ModuleType) {
        self.method = method
    }
    
    public static func method(_ method: ModuleType) -> ServiceAPI { ServiceAPI(method) }
    
    public var route: Route {
        let path = method.path + "/" + method.part.route.path
        switch method.part.route {
        case .get(_):
            return .get(path)
        case .post(_):
            return .post(path)
        case .put(_):
            return .put(path)
        case .delete(_):
            return .delete(path)
        case .options(_):
            return .options(path)
        case .head(_):
            return .head(path)
        case .patch(_):
            return .patch(path)
        case .trace(_):
            return .trace(path)
        case .connect(_):
            return .connect(path)
        }
    }
    
    public var parameters: Parameters? { method.part.parameters }
    
    public var baseURL: URL { method.part.baseURL }
    
    public var sampleData: Data { method.part.sampleData }
    
    public var task: Task { method.part.task }
    
    public var headers: [String : String]? { method.part.headers }
    
}

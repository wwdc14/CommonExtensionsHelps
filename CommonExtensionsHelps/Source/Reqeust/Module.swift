import Moya
import Foundation
public protocol ModuleType {
    var path: String { get }
    var part: PartType { get }
 }
public protocol PartType {
    var route: Route { get }
    var parameters: Parameters? { get }
    var baseURL: URL { get }
    var sampleData: Data { get }
    var task: Task { get }
    var headers: [String : String]? { get }
 }

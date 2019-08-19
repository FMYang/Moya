import Foundation

/// The protocol used to define the specifications necessary for a `MoyaProvider`.
/// 定义MoyaProvider所需的协议
public protocol TargetType {

    /// The target's base `URL`.
    /// 服务器路径
    var baseURL: URL { get }

    /// The path to be appended to `baseURL` to form the full `URL`.
    /// 子路径
    var path: String { get }

    /// The HTTP method used in the request.
    /// HTTP请求方法
    var method: Moya.Method { get }

    /// Provides stub data for use in testing.
    /// 插桩数据，用于测试
    var sampleData: Data { get }

    /// The type of HTTP task to be performed.
    /// HTTP被执行的task
    var task: Task { get }

    /// The type of validation to perform on the request. Default is `.none`.
    /// 校验状态码
    /// none：不校验
    /// successCodes：校验成功状态码，2xx
    /// successAndRedirectCodes：校验成功和重定向的状态码 (only 2xx and 3xx).
    /// customCodes：校验自定义的状态码
    var validationType: ValidationType { get }

    /// The headers to be used in the request.
    var headers: [String: String]? { get }
}

public extension TargetType {

    /// The type of validation to perform on the request. Default is `.none`.
    var validationType: ValidationType {
        return .none
    }
}

import Foundation

/// These functions are default mappings to `MoyaProvider`'s properties: endpoints, requests, manager, etc.
public extension MoyaProvider {
    
    /// 默认Endpoint
    ///
    /// - Parameter target: target
    /// - Returns: Endpoint
    final class func defaultEndpointMapping(for target: Target) -> Endpoint {
        /// 1、拼接URL，使用URL+Moya扩展的方法 通过url、method、task、headers组装Endpoint
        return Endpoint(
            url: URL(target: target).absoluteString,
            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }

    /// 默认请求闭包
    ///
    /// - Parameters:
    ///   - endpoint: Endpoint
    ///   - closure: 请求闭包
    final class func defaultRequestMapping(for endpoint: Endpoint, closure: RequestResultClosure) {
        do {
            let urlRequest = try endpoint.urlRequest()
            closure(.success(urlRequest))
        } catch MoyaError.requestMapping(let url) {
            closure(.failure(MoyaError.requestMapping(url)))
        } catch MoyaError.parameterEncoding(let error) {
            closure(.failure(MoyaError.parameterEncoding(error)))
        } catch {
            closure(.failure(MoyaError.underlying(error, nil)))
        }
    }

    /// 默认使用Alamofire.SessionManager
    ///
    /// - Returns: <#return value description#>
    final class func defaultAlamofireManager() -> Manager {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders

        let manager = Manager(configuration: configuration)
        manager.startRequestsImmediately = false
        return manager
    }
}

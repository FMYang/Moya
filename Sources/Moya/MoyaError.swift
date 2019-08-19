import Foundation

/// A type representing possible errors Moya can throw.
public enum MoyaError: Swift.Error {

    /// Indicates a response failed to map to an image.
    /// 标识响应数据转image失败
    case imageMapping(Response)

    /// Indicates a response failed to map to a JSON structure.
    /// 标识响应数据转JSON结构失败
    case jsonMapping(Response)

    /// Indicates a response failed to map to a String.
    /// 标识响应数据转String失败
    case stringMapping(Response)

    /// Indicates a response failed to map to a Decodable object.
    /// 标识响应数据解析失败
    case objectMapping(Swift.Error, Response)

    /// Indicates that Encodable couldn't be encoded into Data
    /// 标识请求数据encoded失败
    case encodableMapping(Swift.Error)

    /// Indicates a response failed with an invalid HTTP status code.
    /// 标识响应失败，无效的http状态码
    case statusCode(Response)

    /// Indicates a response failed due to an underlying `Error`.
    /// 标识响应失败，基础错误
    case underlying(Swift.Error, Response?)

    /// Indicates that an `Endpoint` failed to map to a `URLRequest`.
    /// 标识Endpoint转URLRequest失败
    case requestMapping(String)

    /// Indicates that an `Endpoint` failed to encode the parameters for the `URLRequest`.
    /// 标识Endpointz从URLRequest解析参数失败
    case parameterEncoding(Swift.Error)
}

public extension MoyaError {
    /// Depending on error type, returns a `Response` object.
    var response: Moya.Response? {
        switch self {
        case .imageMapping(let response): return response
        case .jsonMapping(let response): return response
        case .stringMapping(let response): return response
        case .objectMapping(_, let response): return response
        case .encodableMapping: return nil
        case .statusCode(let response): return response
        case .underlying(_, let response): return response
        case .requestMapping: return nil
        case .parameterEncoding: return nil
        }
    }

    /// Depending on error type, returns an underlying `Error`.
    internal var underlyingError: Swift.Error? {
        switch self {
        case .imageMapping: return nil
        case .jsonMapping: return nil
        case .stringMapping: return nil
        case .objectMapping(let error, _): return error
        case .encodableMapping(let error): return error
        case .statusCode: return nil
        case .underlying(let error, _): return error
        case .requestMapping: return nil
        case .parameterEncoding(let error): return error
        }
    }
}

// MARK: - Error Descriptions

extension MoyaError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .imageMapping:
            return "Failed to map data to an Image."
        case .jsonMapping:
            return "Failed to map data to JSON."
        case .stringMapping:
            return "Failed to map data to a String."
        case .objectMapping:
            return "Failed to map data to a Decodable object."
        case .encodableMapping:
            return "Failed to encode Encodable object into data."
        case .statusCode:
            return "Status code didn't fall within the given range."
        case .underlying(let error, _):
            return error.localizedDescription
        case .requestMapping:
            return "Failed to map Endpoint to a URLRequest."
        case .parameterEncoding(let error):
            return "Failed to encode parameters for URLRequest. \(error.localizedDescription)"
        }
    }
}

// MARK: - Error User Info

extension MoyaError: CustomNSError {
    public var errorUserInfo: [String: Any] {
        var userInfo: [String: Any] = [:]
        userInfo[NSLocalizedDescriptionKey] = errorDescription
        userInfo[NSUnderlyingErrorKey] = underlyingError
        return userInfo
    }
}

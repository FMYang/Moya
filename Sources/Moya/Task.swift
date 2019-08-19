import Foundation

/// Represents an HTTP task.
public enum Task {

    /// A request with no additional data.
    /// 没有附加数据的请求（GET）
    case requestPlain

    /// A requests body set with data.
    /// body设置为data的请求
    case requestData(Data)

    /// A request body set with `Encodable` type
    /// body设置为Encodable类型的请求
    case requestJSONEncodable(Encodable)

    /// A request body set with `Encodable` type and custom encoder
    /// body设置为Encodable类型，并且自定义解码的请求
    case requestCustomJSONEncodable(Encodable, encoder: JSONEncoder)

    /// A requests body set with encoded parameters.
    /// body设置为ParameterEncoding的请求，即：name="xx"&age=10
    /// ParameterEncoding：name="xx"&age=10 (Content-Type：application/x-www-form-urlencoded; charset=utf-8)，参数拼接在url后面，参数以表单格式传输
    /// JSONEncoding：{"name": "xx", age: 10}  (Content-Type：application/json)，参数以JSON格式传输
    /// URLEncoding：(Content-Type：application/x-www-form-urlencoded; charset=utf-8) 参数以表单格式传输
    /// PropertyListEncoding： (Content-Type：application/x-plist) 参数以XML格式传输
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)

    /// A requests body set with data, combined with url parameters.
    case requestCompositeData(bodyData: Data, urlParameters: [String: Any])

    /// A requests body set with encoded parameters combined with url parameters.
    case requestCompositeParameters(bodyParameters: [String: Any], bodyEncoding: ParameterEncoding, urlParameters: [String: Any])

    /// A file upload task.
    /// 上传
    case uploadFile(URL)

    /// A "multipart/form-data" upload task.
    /// 多媒体上传
    case uploadMultipart([MultipartFormData])

    /// A "multipart/form-data" upload task  combined with url parameters.
    /// 多媒体上传，集合url参数
    case uploadCompositeMultipart([MultipartFormData], urlParameters: [String: Any])

    /// A file download task to a destination.
    /// 从目的地下载文件
    case downloadDestination(DownloadDestination)

    /// A file download task to a destination with extra parameters using the given encoding.
    /// 下载文件，结合额外的参数
    case downloadParameters(parameters: [String: Any], encoding: ParameterEncoding, destination: DownloadDestination)
}

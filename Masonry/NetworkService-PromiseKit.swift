//
//  NetworkService.swift
//

import Foundation
import PromiseKit

public typealias JSONDictionary = [String: Any]
public typealias JSONArray = [JSONDictionary]

public struct DataResponse {
    let data: Data
    let httpResponse: HTTPURLResponse
}
public struct JSONResponse {
    let json: JSON
    let httpResponse: HTTPURLResponse
}

public enum JSON {
    case dictionary(JSONDictionary)
    case array(JSONArray)
}
/// A type that can be decoded from JSON
public protocol JSONDecodable {

    /// Attempt to load the type from JSON.
    ///
    /// - throws: An `Error` if the passed in JSON does not match the format expected by this object
    init(json: JSONDictionary) throws

}

/// A service that speaks to a remote service via URLs
public protocol NetworkService: class {

    /// The base URL that requests made using this service will use.
    var baseURL: URL { get set }
    
    /// Requests a JSON Decodable object
    ///
    func requestObject<ObjectType: JSONDecodable>(_ request: URLRequest) -> Promise<ObjectType>

}


public enum NetworkError: Error {
    case unhandledJSON
    case non200StatusCode(statusCode: Int, data: Data?)
    case invalidResponseFormat
    case noDataInResponse
    case invalidResponseHeader
}

public class HTTPNetworkService: NetworkService {

    public var baseURL: URL

    private let urlSession = URLSession(configuration: .ephemeral)

    public init(baseURL: URL) {
        self.baseURL = baseURL
    }

    public func requestJSON(_ request: URLRequest) -> Promise<JSONResponse> {
        return requestData(request).map { (dataResponse: DataResponse) -> JSONResponse in
            guard let rawJSON = try? JSONSerialization.jsonObject(with: dataResponse.data) else {
                throw NetworkError.invalidResponseFormat
            }
            if let jsonDictionary = rawJSON as? JSONDictionary {
                return JSONResponse(json: .dictionary(jsonDictionary), httpResponse: dataResponse.httpResponse)
            }
            throw NetworkError.unhandledJSON
        }
    }

   public func requestObject<ObjectType: JSONDecodable>(_ request: URLRequest, responseHeaderHandler: ((ResponseHeaderHandlerParameters) -> Bool)?) -> Promise<ObjectType> {
        return requestJSON(request).map { jsonResponse -> ObjectType in
            guard case .dictionary(let jsonDictionary) = jsonResponse.json else {
                throw NetworkError.invalidResponseFormat
            }

            if let responseHeaderHandler = responseHeaderHandler {
                let httpResponse = jsonResponse.httpResponse
                let isHeaderValid = responseHeaderHandler((httpResponse.allHeaderFields, httpResponse.url))
                if !isHeaderValid {
                    throw NetworkError.invalidResponseHeader
                }
            }
            
            do {
                return try ObjectType(json: jsonDictionary)
            }
            catch {
                throw NetworkError.unhandledJSON
            }
        }
    }
}

extension JSONDecoder {
    static let networkJSONDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
}

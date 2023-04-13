//
//  NetworkService.swift
//  MovieApp
//
//  Created by Mohamed Tahoon on 11/04/2023.
//

import Foundation
import UIKit
import Alamofire

class NetworkService {
    
    static func request(url: String,
                        headers: HTTPHeaders? = nil,
                        httpMethod: HTTPMethod,
                        parameters: [String: Any]? = nil,
                        isPrintable: Bool,
                        imageParameters:[String: Any] = [:],
                        completion: @escaping (NetworkResponse) -> Void) {
        
        guard let encodedURL = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            print("❌ Network Service: Not Valid URL: \(url.description)")
            return
        }
        
        PrintHelper.logNetwork(
            """
            🙇‍♂️ \(httpMethod.rawValue.uppercased()) '\(url)':
            📝 Request headers = \(headers?.dictionary.json ?? "No Headers")
            📝 Request Body = \(parameters?.json ?? "No Parameters")
            """
        )
        
        // request timeout
        SessionManager.shared.manager.session.configuration.timeoutIntervalForRequest = 15
        SessionManager.shared.manager.request(encodedURL,
                                              method: httpMethod,
                                              parameters: parameters,
                                              encoding: httpMethod == .get ? URLEncoding.default : JSONEncoding.default, //URLEncoding.default
                                              headers: headers).responseData { response in
            
            NetworkService.handleResponseResult(response: response, url: url, isPrintable: isPrintable, completion: completion)
        }
        
        
    }
    
    static func handleResponseResult(response: AFDataResponse<Data>, url: String, isPrintable: Bool, completion: @escaping (NetworkResponse) -> Void) {
        switch response.result {
        case .success:
            
            guard let data = response.data else { return }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any], let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) else {
                return
            }
            
            let date = Date() // Date Now
            if isPrintable {
                PrintHelper.logNetwork("""
                    ✅ Response: \(response.request?.httpMethod?.uppercased() ?? "") '\(url)':
                    🧾 Status Code: \(response.response?.statusCode ?? 0), \(response.result), 💾 \(data), ⏳ time: \(Date().timeIntervalSince(date))
                    ⬇️ Response headers = \(response.response?.allHeaderFields.json ?? "No Headers")
                    ⬇️ Response Body = \(String(decoding: jsonData, as: UTF8.self))
                    """ )
            }
            
            completion(.success(data))
        case .failure(let error):
            // Log Error
            PrintHelper.logNetwork("""
                ❌ Error in response: \(response.request?.httpMethod?.uppercased() ?? "") '\(url)' (\(response.response?.statusCode ?? 0), \(response.result)):
                ❌ Error: \(error)
                ⬇️ Response headers = \(response.response?.allHeaderFields.json ?? "No Headers")
                """ )
            
            // handle parsing errors
            var parsedError: NetWorkError!
            if error._code == NSURLErrorTimedOut {
                parsedError = NetworkService.handleError(url: url, error: .noInternet, data: response.data)
            } else {
                switch response.response?.statusCode {
                case 422:
                    parsedError = NetworkService.handleError(url: url, error: .validationError, data: response.data)
                case 401, 400, 403:
                    parsedError = NetworkService.handleError(url: url, error: .unauthenticated, data: response.data)
                default:
                    parsedError = NetworkService.handleError(url: url, error: .serverError, data: response.data)
                }
            }
            
            completion(.failure(parsedError))
        }
    }
}

extension NetworkService {
    static func handleError(url: String, error: NetworkErrorType, data: Data?, checkMessage: Bool = false) -> NetWorkError {
        let errorResponse = NetworkService.parseResponse(data: data, returnType: EmptyModel.self)
        let error = NetWorkError(errorType: error, error: errorResponse)
        return error
    }
    
    static func parseResponse<T>(data: Data?, returnType: T.Type) -> T? where T: Codable {
        var response: T? = nil
        if let _ = data {
            do {
                response = try JSONDecoder().decode(T.self, from: data!)
            } catch {
                response = nil
            }
        }
        return response
    }
}

enum NetworkErrorType {
    case noInternet
    case uploadImageError
    case uploadError
    case couldNotParseJson
    case serverError
    case validationError
    case unauthenticated
    case parsingError
}

struct NetWorkError: Error {
    var errorType: NetworkErrorType?
    var error: EmptyModel?
    
    var description: String {
        get {
            return  "Something went wrong!"
        }
    }
} 

struct EmptyModel: Codable {
}

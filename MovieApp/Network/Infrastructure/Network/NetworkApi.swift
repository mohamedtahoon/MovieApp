//
//  NetworkApi.swift
//  MovieApp
//
//  Created by Mohamed Tahoon on 11/04/2023.
//

import Foundation
import Alamofire

class NetworkApi {
    static func request<T: Decodable>(url: String,
                                      headers: HTTPHeaders? = nil,
                                      httpMethod: HTTPMethod,
                                      parameters: [String: Any]? = nil,
                                      isPrintable: Bool,
                                      completion: @escaping Response<T>) {
        
        NetworkService.request(url: url, headers: headers, httpMethod: httpMethod, parameters: parameters, isPrintable: isPrintable) { (result) in
            
            
            switch result {
            case .success(let data):
                self.jsonParsing(url, data: data, completion: completion)
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    static func jsonParsing<T: Decodable>(_ url: String,
                                          data: Data,
                                          completion: @escaping Response<T>) {
        
        do {
            let decoder = JSONDecoder()
            let model = try decoder.decode(T.self, from: data)
            completion(.success(model))
        } catch let error {
            // return decoding failed
            let parsedError = NetworkService.handleError(url: url, error: .parsingError, data: data)
            completion(.failure(parsedError))
            PrintHelper.logNetwork("❌ Error in Mapping\n\(url)\nError:\n\(error)")
        }
    }
    
}

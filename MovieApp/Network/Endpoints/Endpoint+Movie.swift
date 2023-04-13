//
//  Endpoint+Account.swift
//  MovieApp
//
//  Created by Mohamed Tahoon on 11/04/2023.
//

import Foundation
import Alamofire

enum MovieAccount: Endpoint {
    
    case getMovies
    case getMovieDetails(id: Int)
    
    
    var method: HTTPMethod {
        switch self {
        case .getMovies, .getMovieDetails:
            return .get
        }
    }
    
    // services URL
    var serviceUrl: String {
        switch self {
        case .getMovies:
            return "discover/movie"
        case .getMovieDetails(let id):
            return "movie/\(id)"
        }
    }
    
    // headers
    var headers: HTTPHeaders? {
        
        var headers :HTTPHeaders  = [
        ]
        
        switch self {
        default:
            headers["Accept"] = RequestContentType.json.rawValue
        }
        return headers
    }
    // parameters
    var parameters: [String: Any]? {
        switch self {
            
        case .getMovies, .getMovieDetails:
            return["api_key": Constants.apiKey]
        }
    }
}

//
//  SessionManager.swift
//  MovieApp
//
//  Created by Mohamed Tahoon on 11/04/2023.
//

import Foundation
import Alamofire

class SessionManager {
    static let shared = SessionManager()
    
    let manager: Alamofire.Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = TimeInterval(Constants.requestTimeOut)
        return Alamofire.Session(
            configuration: configuration
        )
    }()
}

//
//  Constants.swift
//  MovieApp
//
//  Created by Mohamed Tahoon on 11/04/2023.
//

import Foundation

struct Constants {
    static let BASE_URL = BasUrls.base
    static let Environment = "Environment"
    static let apiKey = "c9856d0cb57c3f14bf75bdc6c063b8f3"
    static let requestTimeOut = 15
}

class BasUrls {
    static var base: String {
        return (UserDefaults.standard.value(forKey: Constants.Environment) as? String) ?? Environment.Development.rawValue
    }
}

enum Environment: String {
    
    case Development = "https://api.themoviedb.org/3/"
    
    case Testing = ""
    
    func changeTo() {
        UserDefaults.standard.setValue(self.rawValue, forKey: Constants.Environment)
        UserDefaults.standard.synchronize()
    }
    
    func current() -> Environment {
        return Environment(rawValue: UserDefaults.standard.value(forKey: Constants.Environment) as? String ?? "") ?? .Testing
    }
}

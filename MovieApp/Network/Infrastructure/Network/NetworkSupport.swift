//
//  NetworkSupport.swift
//  MovieApp
//
//  Created by Mohamed Tahoon on 11/04/2023.
//

import Foundation

enum NetworkResponse {
    case success(Data)
    case failure(NetWorkError)
}

typealias Response<T: Codable> = (Result<T, NetWorkError>) -> Void

class PrintHelper {
    
    static func logNetwork<T>(_ items: T, separator: String = " ", terminator: String = "\n") {
        print("""
            \n===================== 📟 ⏳ 📡 =========================
            \(items)
            ======================= 🚀 ⌛️ 📡 =========================
            """, separator: separator, terminator: terminator)
    }
}

class NetworkReachability: Reachability {
    static let reachability = Reachability()
    
    class var isReachable: Bool {
        return NetworkReachability.reachability?.isReachable ?? false
    }
}

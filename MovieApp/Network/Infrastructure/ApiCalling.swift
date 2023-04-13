//
//  ApiCalling.swift
//  MovieApp
//
//  Created by Mohamed Tahoon on 11/04/2023.
//

import Foundation
import Alamofire
import SwiftyJSON

enum RequestContentType: String {
    case json = "application/json"
    case urlEncoded  = "application/x-www-form-urlencoded"
}

class ApiCalling {
    class func request (requestUrl url : String,
                        httpMethod : HTTPMethod = .post ,
                        paramter : [String : Any]? = nil ,
                        contentType :String = RequestContentType.urlEncoded.rawValue  ,
                        Result:@escaping(_ result : Any? ,_ responseCode : Int , _ errorMessage : Any?)->()) {
        
        let headers :HTTPHeaders  = [:]
        
        
        
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 15
        
        SessionManager.shared.manager.request( url.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? url ,
                                               method: httpMethod ,
                                               parameters: paramter ,
                                               encoding: httpMethod == .get ? URLEncoding.default : JSONEncoding.default,
                                               headers: headers )
        .responseJSON(completionHandler: {
            
            response in
            
            let statusCode = response.response?.statusCode
            
            switch response.result
            {
            case .failure(let error) :
                //print("> Error on Response JSON " , error.localizedDescription)
                let errorMessage = "\(error.localizedDescription)"
                PrintHelper.logNetwork("""
                        ❌ Error in response: \(response.request?.httpMethod?.uppercased() ?? "") '\(url)' (\(response.response?.statusCode ?? 0), \(response.result)):
                        ❌ Error: \(error)
                        ⬇️ Response headers = \(response.response?.allHeaderFields.json ?? "No Headers")
                        """ )
                
                guard let code = statusCode, statusCode != 408 else { // timeout request
                    Result(nil , statusCode ?? 0, errorMessage)
                    return
                }
                
                Result(nil , code, errorMessage)
                
                return
            case .success(let requestResult):
                //print("///////////////////---->",JSON(requestResult))
                guard let data = response.data else { return }
                PrintHelper.logNetwork("""
                        ✅ Response: \(response.request?.httpMethod?.uppercased() ?? "") '\(url)':
                        ⬇️ Response headers = \(response.response?.allHeaderFields.json ?? "No Headers")
                        ⬇️ Response Body = \(String(data: data, encoding: String.Encoding.utf8) ?? "")
                        """ )
                
                if statusCode == 200 {
                    Result(requestResult, statusCode ?? 0 , nil)
                } else {
                    do {
                        guard let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {return}
                        
                        // handle if error comes as and array or single msg
                        if let errors = jsonResponse["errors"] as? [[String:Any]], let firstError = errors.first?["message"] as? String {
                            Result(requestResult, statusCode ?? 0 , firstError)
                        } else {
                            Result(requestResult, statusCode ?? 0 , jsonResponse["msg"] ?? "")
                        }
                    } catch let jsonErr {
                        print(jsonErr.localizedDescription)
                        Result(requestResult, statusCode ?? 0 , jsonErr.localizedDescription)
                    }
                }
                return
            }
        })
    }
}

extension String {
    func base64Encoded() -> String {
        return (data(using: .utf8)?.base64EncodedString())!
    }
    
    func base64Decoded() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}

extension Dictionary {
    var json: String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
            return String(bytes: jsonData, encoding: String.Encoding.utf8) ?? "Not a valid JSON"
        } catch {
            return "Not a valid JSON"
        }
    }
}

//
//  BaseViewModel.swift
//  MovieApp
//
//  Created by Mohamed Tahoon on 11/04/2023.
//

import Foundation
import UIKit

class BaseViewModel {
    var isLoading: Bool = false {
        didSet {
            if isLoading {
                self.showLoading()
            } else {
                self.hideLoading()
            }
        }
    }
    
    var error: String? {
        didSet {
            if let errorMsg = error {
                if NetworkReachability.isReachable == false {
                    self.showError("Check your network")
                }
                self.showError(errorMsg)
            }
        }
    }
    
    
    var showError:(_ errMsg: String)->() = {_ in}
    var showLoading:()->() = {}
    var hideLoading:()->() = {}
    var completionHandler:()->() = {}
   
    func startLoading() {
        self.isLoading = true
    }
    
    func stopLoading() {
        self.isLoading = false
    }
}

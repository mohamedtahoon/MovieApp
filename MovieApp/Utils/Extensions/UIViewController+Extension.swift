//
//  UIViewController+Extension.swift
//  MovieApp
//
//  Created by Mohamed Tahoon on 12/04/2023.
//

import Foundation
import NVActivityIndicatorView
 

extension UIViewController {
    var activityIndicatorTag: Int { return 999999 }
    
    func startLoading() {
        self.startActivityIndicator()
    }
    
    func stopLoading() {
        self.stopActivityIndicator()
    }
    
    func startActivityIndicator(style: NVActivityIndicatorType = .circleStrokeSpin, location: CGPoint? = nil) {
        
        //Set the position - defaults to `center` if no`location`
        //argument is provided
        
        let loc = location ?? self.view.center
        
        //Ensure the UI is updated from the main thread
        
        //in case this method is called from a closure
        
        DispatchQueue.main.async {
            
            //Create the activity indicator
            
            let activityIndicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 60, height: 60), type: style, color: .gray, padding: nil)
            
            //Add the tag so we can find the view in order to remove it later
            activityIndicator.tag = self.activityIndicatorTag
            
            //Set the location
            activityIndicator.center = loc
            
            //Start animating and add the view
            activityIndicator.startAnimating()
            self.view.addSubview(activityIndicator)
        }
    }
    
    func stopActivityIndicator() {
        
        //Again, we need to ensure the UI is updated from the main thread!
        
        DispatchQueue.main.async {
            //Here we find the `UIActivityIndicatorView` and remove it from the view
            
            if let activityIndicator = self.view.subviews.filter (
                { $0.tag == self.activityIndicatorTag}).first as? NVActivityIndicatorView {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
        }
    }
}

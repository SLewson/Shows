//
//  ShowsAPI.swift
//  Shows
//
//  Created by Spencer Lewson on 11/11/14.
//  Copyright (c) 2014 Ian Mitchell. All rights reserved.
//

import Foundation

class ShowsAPI {
    
    func getMessage(completionHandler:(message: String, error: NSError?)->()) -> Void {
        let session = NSURLSession.sharedSession()
        
        let task1 = session.dataTaskWithURL(NSURL(string: "http://localhost:3000")!, completionHandler: { (data, response, error) -> Void in
            
            var error: NSError?
            if let jsonDict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error){
                
                if let error = error {
                    print(error)
                }
                if let jsonDictionary = jsonDict as? NSDictionary {
                    //print(jsonDict["message"])
                    if let message = jsonDict["message"] as? String {
                        
                        completionHandler(message: message, error: nil)
                    }
                }
                else {
                    completionHandler(message: "", error: nil)
                }
            }
            else {
                completionHandler(message: "", error: nil)
            }
        })
        task1.resume()
    }
}
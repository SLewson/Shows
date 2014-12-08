//
//  ShowsAPI.swift
//  Shows
//
//  Created by Spencer Lewson on 11/11/14.
//  Copyright (c) 2014 Ian Mitchell. All rights reserved.
//

import Foundation

class ShowsAPI {
    
    var session: NSURLSession
    
    init() {
        session = NSURLSession.sharedSession()
    }
    
    func getAllShows(completionHandler:(shows: [Show]?, error: NSError?)->()) -> Void {
        let task1 = session.dataTaskWithURL(NSURL(string: "http://localhost:3000/shows")!, completionHandler: { (data, response, error) -> Void in
            
            var error: NSError?
            if let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error){
                if let error = error {
                    print(error)
                    completionHandler(shows: nil, error: error)
                }
                if let showArray = jsonArray as? NSArray {
                    var shows: [Show] = []
                    for showJsonDict in showArray {
                        shows.append(Show(jsonDict: showJsonDict as NSDictionary))
                    }
                    completionHandler(shows: shows, error: nil)
                }
            }
        })
        task1.resume()
    }
    
    func getSearchResults(query: String, completionHandler: (shows: [Show]?, error: NSError?)->()) -> Void {
        println("getSearchResults")
        let searchTask = session.dataTaskWithURL(NSURL(string: "http://localhost:3000/shows/search/arrow")!, completionHandler: {
            (data, response, error) -> Void in
            println(response)
            var error: NSError?
            if let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error){
                if let error = error {
                    print(error)
                    completionHandler(shows: nil, error: error)
                }
                if let showArray = jsonArray as? NSArray {
                    var shows: [Show] = []
                    for showJsonDict in showArray {
                        shows.append(Show(jsonDict: showJsonDict as NSDictionary))
                    }
                    completionHandler(shows: shows, error: nil)
                }
            }
        })
        searchTask.resume()
    }
}
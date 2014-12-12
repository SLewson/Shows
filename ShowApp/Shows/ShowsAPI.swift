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
    
    func addEpisode(episode: Episode, completionHandler:(episode: Episode?, error: NSError?)->()) -> Void {
        let task1 = session.dataTaskWithURL(NSURL(string: "http://localhost:3000/episodes/add_watched/\(episode.id)/?user_token=\(UserManagement.getAuthToken()!)")!, completionHandler: { (data, response, error) -> Void in
            
            var error: NSError?
            if let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error){
                if let error = error {
                    print(error)
                    completionHandler(episode: nil, error: error)
                }
                if let showArray = jsonArray as? NSDictionary {
                    if let status = showArray["status"] as? NSString {
                        if status == "success" {
                            println("success")
                            completionHandler(episode: episode, error: nil)
                        }
                        else {
                            println("failure 1")
                            completionHandler(episode: nil, error: error)
                        }
                    }
                    else {
                        println("failure 2")
                        completionHandler(episode: nil, error: error)
                    }
                }
                else {
                    println("failure 3")
                    completionHandler(episode: nil, error: error)
                }
            }
        })
        task1.resume()
    }
    
    func removeEpisode(episode: Episode, completionHandler:(episode: Episode?, error: NSError?)->()) -> Void {
        let task1 = session.dataTaskWithURL(NSURL(string: "http://localhost:3000/episodes/remove_watched/\(episode.id)/?user_token=\(UserManagement.getAuthToken()!)")!, completionHandler: { (data, response, error) -> Void in
            
            var error: NSError?
            if let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error){
                if let error = error {
                    print(error)
                    completionHandler(episode: nil, error: error)
                }
                if let showArray = jsonArray as? NSDictionary {
                    if let status = showArray["status"] as? NSString {
                        if status == "success" {
                            println("success")
                            completionHandler(episode: episode, error: nil)
                        }
                        else {
                            println("failure 1")
                            completionHandler(episode: nil, error: error)
                        }
                    }
                    else {
                        println("failure 2")
                        completionHandler(episode: nil, error: error)
                    }
                }
                else {
                    println("failure 3")
                    completionHandler(episode: nil, error: error)
                }
            }
        })
        task1.resume()
    }
    
    func getEpisodes(id:Int, completionHandler:(episodes: [Episode]?, error: NSError?)->()) -> Void {
        let task1 = session.dataTaskWithURL(NSURL(string: "http://localhost:3000/shows/\(id)/episodes?user_token=\(UserManagement.getAuthToken()!)")!, completionHandler: { (data, response, error) -> Void in
            
            var error: NSError?
            if let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error){
                if let error = error {
                    print(error)
                    completionHandler(episodes: nil, error: error)
                }
                if let episodeArray = jsonArray as? NSArray {
                    var episodes: [Episode] = []
                    for showJsonDict in episodeArray {
                        episodes.append(Episode(jsonDict: showJsonDict as NSDictionary))
                    }
                    completionHandler(episodes: episodes, error: nil)
                }
            }
        })
        task1.resume()
    }


    func getFavorites(completionHandler:(shows: [Show]?, error: NSError?)->()) -> Void {
        let task1 = session.dataTaskWithURL(NSURL(string: "http://localhost:3000/profiles/get_favorites/?user_token=\(UserManagement.getAuthToken()!)")!, completionHandler: { (data, response, error) -> Void in
            
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
    
    func addFavorite(show: Show, completionHandler:(show: Show?, error: NSError?)->()) -> Void {
        let task1 = session.dataTaskWithURL(NSURL(string: "http://localhost:3000/profiles/add_favorite/\(show.id)/?user_token=\(UserManagement.getAuthToken()!)")!, completionHandler: { (data, response, error) -> Void in
            
            var error: NSError?
            if let jsonArray = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error){
                if let error = error {
                    print(error)
                    completionHandler(show: nil, error: error)
                }
                if let showArray = jsonArray as? NSDictionary {
                    if let status = showArray["status"] as? NSString {
                        if status == "success" {
                            println("success")
                            completionHandler(show: show, error: nil)
                        }
                        else {
                            println("failure 1")
                            completionHandler(show: nil, error: error)
                        }
                    }
                    else {
                        println("failure 2")
                        completionHandler(show: nil, error: error)
                    }
                }
                else {
                    println("failure 3")
                    completionHandler(show: nil, error: error)
                }
            }
        })
        task1.resume()
    }

    func getSearchResults(query: String, completionHandler: (show: Show?, error: NSError?)->()) -> Void {
        let safe_query = query.stringByReplacingOccurrencesOfString(" ", withString: "%20", options: NSStringCompareOptions.LiteralSearch, range: nil)

        let searchTask = session.dataTaskWithURL(NSURL(string: "http://localhost:3000/shows/search/\(safe_query)?user_token=\(UserManagement.getAuthToken()!)")!, completionHandler: {
            (data, response, error) -> Void in
            var error: NSError?
            if let jsonDict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error){
                if let error = error {
                    completionHandler(show: nil, error: error)
                }
                if let jsonDict = jsonDict as? NSDictionary {
                    if let status = jsonDict["status"] {
                        completionHandler(show: nil, error: error)
                    }
                    else {
                        var show = Show(jsonDict: jsonDict)
                        completionHandler(show: show, error: nil)
                    }
                }
                else {
                    completionHandler(show: nil, error: error)
                }
            }
        })
        searchTask.resume()
    }
}
//
//  Episode.swift
//  Shows
//
//  Created by Ian Mitchell on 12/12/14.
//  Copyright (c) 2014 Ian Mitchell. All rights reserved.
//

import Foundation

class Episode {
    var id: Int
    var name: String
    var huluId: Int
    var watched: Bool
    
    init(id: Int, name: String, huluId: Int, watched: Bool) {
        self.id = id
        self.name = name
        self.huluId = huluId
        self.watched = watched
    }
    
    convenience init(jsonDict: NSDictionary) {
        let id = jsonDict.objectForKey("id") as? Int
        let name = jsonDict.objectForKey("name") as? String
        let huluId = jsonDict.objectForKey("hulu_video_id") as? Int
        //let watched = jsonDict.objectForKey("watched") as? Bool
        
        self.init(id: id!, name: name!, huluId: huluId!, watched: false)
    }
}

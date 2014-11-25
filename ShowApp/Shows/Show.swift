//
//  Show.swift
//  Shows
//
//  Created by Spencer Lewson on 11/24/14.
//  Copyright (c) 2014 Ian Mitchell. All rights reserved.
//

import Foundation

class Show {
    var id: Int
    var name: String
    var huluId: Int
    var description: String
    
    init(id: Int, name: String, huluId: Int, desc: String) {
        self.id = id
        self.name = name
        self.huluId = huluId
        self.description = desc
    }
    
    convenience init(jsonDict: NSDictionary) {
        let id = jsonDict.objectForKey("id") as? Int
        let name = jsonDict.objectForKey("name") as? String
        let huluId = jsonDict.objectForKey("hulu_id") as? Int
        let desc = jsonDict.objectForKey("description") as? String
        
        self.init(id: id!, name: name!, huluId: huluId!, desc: desc!)
    }
}

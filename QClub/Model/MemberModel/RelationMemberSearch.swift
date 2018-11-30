//
//  RelationMemberSearch.swift
//  QClub
//
//  Created by SMR on 10/25/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class RelationMemberSearch: Mappable {
    
    var age : Int?
    var body : String?
    var height : Int?
    var job : String?
    var level : String?
    var location : String?
    var nickname : String?
    var representPicture : String?
    var userSeq : Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        age <- map["age"]
        body <- map["body"]
        height <- map["height"]
        job <- map["job"]
        level <- map["level"]
        location <- map["location"]
        nickname <- map["nickname"]
        representPicture <- map["representPicture"]
        userSeq <- map["userSeq"]
    }
    
}

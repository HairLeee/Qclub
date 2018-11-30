//
//  BattleUser.swift
//  QClub
//
//  Created by TuanNM on 11/17/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import Foundation
import ObjectMapper

class BattleUser: Mappable {
    
    var age : Int = 0
    var body : String = ""
    var gender : String = ""
    var height : Int = 0
    var job : String = ""
    var likability : Int = 0
    var location : String = ""
    var messageStatus : String = ""
    var nickName :String = ""
    var profilePicture : String = ""
    var level : String = ""
    var userSeq : Int = 0
    var hasPaid = false
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        age <- map["age"]
        body <- map["body"]
        gender <- map["gender"]
        height <- map["height"]
        job <- map["job"]
        likability <- map["likability"]
        location <- map["location"]
        messageStatus <- map["messageStatus"]
        nickName <- map["nickName"]
        profilePicture <- map["profilePicture"]
        level <- map["qlevel"]
        userSeq <- map["userSeq"]
    }
}

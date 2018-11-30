//
//  MemberHistoryObject.swift
//  QClub
//
//  Created by SMR on 10/31/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class MemberHistoryObject: Mappable {
    var location:String = ""
    var job:String = ""
    var profilePicture:String?
    var body:String = ""
    var age:Int?
    var matchTodaySeq:Int?
    var userSeq:Int?
    var targetUserSeq:Int?
    var matchedDate:Double?
    var paidDate:Double?
    
    var height:Int?
    var nickname:String = ""
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        location <- map["location"]
        job <- map["job"]
        profilePicture <- map["profilePicture"]
        body <- map["body"]
        age <- map["age"]
        matchTodaySeq <- map["matchTodaySeq"]
        userSeq <- map["userSeq"]
        targetUserSeq <- map["targetUserSeq"]
        matchedDate <- map["matchedDate"]
        paidDate <- map["paidDate"]
        
        height <- map["height"]
        nickname <- map["nickname"]
    }
    
}

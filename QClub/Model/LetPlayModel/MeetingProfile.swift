//
//  MeetingProfile.swift
//  QClub
//
//  Created by SMR on 11/15/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class MeetingProfile: Mappable {
    
    var userSeq:Int = 0
    var height:Int = 0
    var nickName:String = ""
    var location:String = ""
    var birthYear:Int = 0
    var gender:String = ""
    var marital:String = ""
    var blood:String = ""
    var style:String = ""
    var body:String = ""
    var school:String = ""
    var company:String = ""
    var appeal:String = ""
    var job:String = ""
    var profilePicture:String = ""
    var level: String = ""
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        userSeq <- map["userSeq"]
        height <- map["height"]
        nickName <- map["nickName"]
        location <- map["location"]
        birthYear <- map["birthYear"]
        gender <- map["gender"]
        marital <- map["marital"]
        blood <- map["blood"]
        style <- map["style"]
        body <- map["body"]
        school <- map["school"]
        company <- map["company"]
        appeal <- map["appeal"]
        job <- map["job"]
        profilePicture <- map["profilePicture"]
        profilePicture = "http://" + profilePicture
        
        gender = (gender == "M" ? "남" : "여")
        
    }
    
    
}

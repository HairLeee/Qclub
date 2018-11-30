//
//  GIMember.swift
//  QClub
//
//  Created by TuanNM on 11/7/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import Foundation
import ObjectMapper

class GIMember: Mappable {
    
    var userSeq : Int = 0
    var age : Int = 0
    var height : Int = 0
    var representPicture : String = ""
    var location : String = ""
    var job : String = ""
    var body : String = ""
    var introduceSeq : Int = 0
    var reviewCnt : Int = 0
    var nickname : String = ""
    var introduce :String = ""
    var level : String = ""
    var review : String = ""
    var isLock = false
    var paidDate:Date?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mappingMember(member:Member){
        userSeq = member.userSeq
        //age = member.
        height = member.height
        location = member.locationName
        job = member.job
        body = member.bodyName
        nickname = member.nickname
        level = member.levelName
        representPicture = member.profilePicture?[0].profilePictureUrl ?? ""
    }
    
    func mapping(map: Map)
    {
        userSeq <- map["userSeq"]
        age <- map["age"]
        height <- map["height"]
        representPicture <- map["representPicture"]
        location <- map["location"]
        job <- map["job"]
        body <- map["body"]
        introduceSeq <- map["introduceSeq"]
        reviewCnt <- map["reviewCnt"]
        nickname <- map["nickname"]
        introduce <- map["introduce"]
        level <- map["level"]
        review <- map["review"]
        representPicture = "http://" + representPicture
    }
}


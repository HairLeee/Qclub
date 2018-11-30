//
//  TargetUserInfo.swift
//  QClub
//
//  Created by SMR on 11/13/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class TargetUserInfo: Mappable {

    var nickName: String?
    var gender: String?
    var location: String?
    var job: String?
    var profilePicture: String = ""
    var body: String?
    var messageStatus: String?
    var qlevel: String?
    var userSeq: Int?
    var height: Int?
    var age: Int?
    var likability: Int?
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map)
    {
        nickName <- map["nickName"]
        gender <- map["gender"]
        location <- map["location"]
        job <- map["job"]
        profilePicture <- map["profilePicture"]
        body <- map["body"]
        messageStatus <- map["messageStatus"]
        qlevel <- map["qlevel"]
        userSeq <- map["userSeq"]
        height <- map["height"]
        age <- map["age"]
        likability <- map["likability"]
        if !profilePicture.hasPrefix("http://"){
            profilePicture = "http://" + profilePicture
        }
    }
}

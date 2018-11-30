//
//  UserMeetingRoom.swift
//  QClub
//
//  Created by SMR on 11/13/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class UserMeetingRoom: Mappable {

    var nickName: String?
    var gender: String?
    var profile_picture: String?
    var appeal: String?
    var qlevel: String?
    var paidDate: Double?
    var userSeq: Int?
    var targetUserSeq: Int?
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map)
    {
        nickName <- map["nickName"]
        gender <- map["gender"]
        //profile_picture <- map["profile_picture"]
        profile_picture <- map["profilePicture"]
        appeal <- map["appeal"]
        qlevel <- map["qlevel"]
        paidDate <- map["paidDate"]
        userSeq <- map["userSeq"]
        targetUserSeq <- map["targetUserSeq"]
        if let avatarUrl = profile_picture {
            profile_picture = "http://" + avatarUrl
        }
    }
}

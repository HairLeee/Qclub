//
//  MeetingMember.swift
//  QClub
//
//  Created by SMR on 11/6/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class MeetingMember: Mappable {
    
    var userSeq : Int?
    var targetUserSeq : Int?
    var appeal : String?
    var profile_picture : String?
    var gender : String?
    var paidDate : Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        userSeq <- map["userSeq"]
        targetUserSeq <- map["targetUserSeq"]
        appeal <- map["appeal"]
        profile_picture <- map["profile_picture"]
        gender <- map["gender"]
        paidDate <- map["paidDate"]
    }
}

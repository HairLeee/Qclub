//
//  ItItemLikeUser.swift
//  QClub
//
//  Created by SMR on 12/21/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class ItItemLikeUser: Mappable {
    
    var userSeq : Int = 0
    var profilePicture : String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        userSeq <- map["userSeq"]
        profilePicture <- map["profilePicture"]
        profilePicture = "http://" + profilePicture
    }
}


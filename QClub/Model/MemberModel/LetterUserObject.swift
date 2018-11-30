//
//  LetterUserObject.swift
//  QClub
//
//  Created by SMR on 11/10/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class LetterUserObject: Mappable {
    
    var userSeq : Int?
    var interestMessageSeq : Int?
    var fromUserSeq : Int?
    var toUserSeq : Int?
    var message : String?
    var confirm : String?
    var paidDate : Double?
    var sendDate : Double?
    var user : TargetUserInfo?

    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        userSeq <- map["userSeq"]
        interestMessageSeq <- map["interestMessageSeq"]
        fromUserSeq <- map["fromUserSeq"]
        toUserSeq <- map["toUserSeq"]
        message <- map["message"]
        confirm <- map["confirm"]
        paidDate <- map["paidDate"]
        sendDate <- map["sendDate"]
        user <- map["user"]
    }
    
}

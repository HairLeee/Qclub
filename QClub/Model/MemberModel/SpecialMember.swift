//
//  SpecialMember.swift
//  QClub
//
//  Created by SMR on 11/16/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class SpecialMember: Mappable {
    
    var matchSpecialSeq : Int?
    var userSeq : Int?
    var sendUserSeq : Int?
    var paidTarget = "N"
    var response : String?
    var nickname : String?
    var profilePicture : String = ""
    var exposeDate : Double?
    var hideDate : Double?
    var paidDate : Double?
    var createDate : Double?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        matchSpecialSeq <- map["matchSpecialSeq"]
        userSeq <- map["userSeq"]
        sendUserSeq <- map["sendUserSeq"]
        paidTarget <- map["paidTarget"]
        profilePicture <- map["representPicture"]
        response <- map["response"]
        nickname <- map["nickname"]
        exposeDate <- map["exposeDate"]
        hideDate <- map["hideDate"]
        paidDate <- map["paidDate"]
        createDate <- map["createDate"]
        profilePicture = "http://" + profilePicture
    }
    
}

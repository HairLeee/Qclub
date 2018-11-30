//
//  ItemDetailObject.swift
//  QClub
//
//  Created by SMR on 11/17/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class ItemDetailObject : Mappable {
    
    var itItemSeq : Int = -1
    var userSeq : Int = -1
    var likeCnt : Int = -1
    var myLikeCnt : Int = -1
    var registerName : String = ""
    var registerProfilePic : String = ""
    var sameGender : String = ""
    var gender : String = ""
    var isRegister : String = ""
    var title : String = ""
    var createDate : String = ""
    var itItemPictures : [ItItemPictures]?
    var itItemLikeUsers : [ItItemLikeUser]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        itItemSeq <- map["itItemSeq"]
        userSeq <- map["userSeq"]
        likeCnt <- map["likeCnt"]
        myLikeCnt <- map["myLikeCnt"]
        registerName <- map["registerName"]
        title <- map["title"]
        sameGender <- map["sameGender"]
        gender <- map["gender"]
        isRegister <- map["isRegister"]
        itItemPictures <- map["itItemPictures"]
        itItemLikeUsers <- map["itItemLikeUsers"]
        registerProfilePic <- map["registerProfilePic"]
        registerProfilePic = "http://" + registerProfilePic
    }
}


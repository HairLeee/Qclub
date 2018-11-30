//
//  OurStory.swift
//  QClub
//
//  Created by Dreamup on 11/8/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper
class OurStory: Mappable {
    
    
    

    
    
    var birthMonth:String = ""
    var birthDay: String = ""
    var updateDate:String = ""
    var gender:String = ""
    var birthYear:String = ""
    var name: String = ""
    var nickname:String = ""
    var mobile:String = ""
    var id:String = ""
    var createDate: String = ""
    var userSeq:Int = 0

    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        birthMonth <- map["birthMonth"]
        birthDay <- map["birthDay"]
        updateDate <- map["updateDate"]
        gender <- map["gender"]
        birthYear <- map["birthYear"]
        name <- map["name"]
        nickname <- map["nickname"]
        mobile <- map["mobile"]
        id <- map["id"]
        createDate <- map["createDate"]
        userSeq <- map["userSeq"]
    
    }
}


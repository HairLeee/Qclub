//
//  ItemObject.swift
//  QClub
//
//  Created by SMR on 11/17/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class ItemObject: Mappable {
    
    var itItemSeq : Int = -1
    var likeCnt : Int = -1
    var title : String = ""
    var itItemPicture : String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        itItemSeq <- map["itItemSeq"]
        likeCnt <- map["likeCnt"]
        title <- map["title"]
        itItemPicture <- map["itItemPicture"]
        
        itItemPicture = "http://" + itItemPicture
        
    }
}

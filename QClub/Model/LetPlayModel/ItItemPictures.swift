//
//  ItItemPictures.swift
//  QClub
//
//  Created by SMR on 11/17/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class ItItemPictures: Mappable {
    
    var description : String = ""
    var itItemPicture : String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        description <- map["description"]
        itItemPicture <- map["itItemPicture"]
        itItemPicture = "http://" + itItemPicture
    }
}

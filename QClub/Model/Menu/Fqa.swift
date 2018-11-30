//
//  Fqa.swift
//  QClub
//
//  Created by Dreamup on 10/9/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class Fqa: Mappable {

    
    var title:String = ""
    var descriptionFqa: String = ""
    var createDate:String = ""
    var updateDate:String = ""


    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        title <- map["title"]
        descriptionFqa <- map["description"]
        createDate <- map["createDate"]
        updateDate <- map["updateDate"]
    }
}

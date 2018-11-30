//
//  Board1Model.swift
//  QClub
//
//  Created by Dreamup on 10/23/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class Board1Model: Mappable {
    
    
    var title:String = ""
    var nickName: String = ""

    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        title <- map["title"]
        nickName <- map["nickName"]
 
    }
}

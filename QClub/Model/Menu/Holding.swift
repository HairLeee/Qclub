//
//  Holding.swift
//  QClub
//
//  Created by Dreamup on 10/17/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class Holding: Mappable {
    
    
    var holdingExpDate:String = ""
    var holdingBeginDate: String = ""

    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        holdingExpDate <- map["holdingExpDate"]
        holdingBeginDate <- map["holdingBeginDate"]
     }
}

//
//  Store.swift
//  QClub
//
//  Created by Dreamup on 10/17/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class Store: Mappable {
    
    
    var priceDetail:String = ""
    var price: Int = 0
    var heartCntDetail:Float = 0.0
    var heartCnt:String = ""
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        priceDetail <- map["priceDetail"]
        price <- map["price"]
        heartCntDetail <- map["heartCntDetail"]
        heartCnt <- map["heartCnt"]
    }
}


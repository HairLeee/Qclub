//
//  Heart.swift
//  QClub
//
//  Created by Dreamup on 10/30/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper
class Heart: Mappable {
    
    
    
    
    var heartCount:Int = 0
    var heartCurrentCount: Int = 0
    var insertDate:String = ""
    var historyType:String = ""
    var heartDetail:String = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        heartCount <- map["heartCount"]
        heartCurrentCount <- map["heartCurrentCount"]
        insertDate <- map["insertDate"]
        historyType <- map["historyType"]
        heartDetail <- map["heartDetail"]
    }
}

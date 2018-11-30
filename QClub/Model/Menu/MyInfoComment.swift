//
//  Comment.swift
//  QClub
//
//  Created by Dreamup on 11/9/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper
class MyInfoComment: Mappable {
    
    
    var adviceSeq:Int = 0
    var paidDate: String?
    var advice:String = ""

    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        adviceSeq <- map["adviceSeq"]
        paidDate <- map["paidDate"]
        advice <- map["advice"]
    }
}

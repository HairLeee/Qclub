//
//  RankObject.swift
//  QClub
//
//  Created by SMR on 11/14/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class RankObject: Mappable {
    
    var userSeq : Int?
    var charmRank : Double?
    var charmRatio : Float?
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        userSeq <- map["userSeq"]
        charmRank <- map["charmRank"]
        charmRatio <- map["charmRatio"]
    }
}


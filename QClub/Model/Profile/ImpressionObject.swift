//
//  ImpressionObject.swift
//  QClub
//
//  Created by SMR on 10/23/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class ImpressionObject: Mappable{
    
    var impressionMaster : Int?
    var impressionDetail : Int?
    var impression : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        impressionMaster <- map["impressionMaster"]
        impressionDetail <- map["impressionDetail"]
        impression <- map["impression"]
    }
}

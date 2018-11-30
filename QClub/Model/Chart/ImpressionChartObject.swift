//
//  impressionObject.swift
//  QClub
//
//  Created by SMR on 11/14/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class ImpressionChartObject: Mappable {
    
    var percentage : Int?
    var name : String?

    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        percentage <- map["percentage"]
        name <- map["name"]
    }
}


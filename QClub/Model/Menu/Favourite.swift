//
//  Favourite.swift
//  QClub
//
//  Created by Dreamup on 11/17/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper
class Favourite:Mappable {
    
    var ageRange = ""
    var locationDetailChar = ""
    var styleDetailChar = ""
    var heightDetailChar = ""
    var bodyDetailChar = ""
    var relegionMatch = ""
    var drinkingDetailChar = ""
    var smokingDetailChar = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        ageRange <- map["ageRange"]
        locationDetailChar <- map["locationDetailChar"]
        styleDetailChar <- map["styleDetailChar"]
        heightDetailChar <- map["heightDetailChar"]
        bodyDetailChar <- map["bodyDetailChar"]
        relegionMatch <- map["relegionMatch"]
        drinkingDetailChar <- map["drinkingDetailChar"]
        smokingDetailChar <- map["smokingDetailChar"]
    }
}

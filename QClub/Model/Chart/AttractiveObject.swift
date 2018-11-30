//
//  AttractiveObject.swift
//  QClub
//
//  Created by SMR on 11/14/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class AttractiveObject: Mappable {
    
    var impressions : [ImpressionChartObject]?
    var lik : LikObject?
    var rank : RankObject?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        impressions <- map["impressions"]
        lik <- map["lik"]
        rank <- map["rank"]
    }
}

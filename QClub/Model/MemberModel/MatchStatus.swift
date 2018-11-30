//
//  MatchStatus.swift
//  QClub
//
//  Created by SMR on 11/16/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class MatchStatus: Mappable {
    
    var special = 0
    var candy = 0
    var today = 0
    var meeting = 0

    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        special <- map["special"]
        candy <- map["candy"]
        today <- map["today"]
        meeting <- map["meeting"]
    }
    
}

//
//  LikabilityObject.swift
//  QClub
//
//  Created by SMR on 10/23/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class LikabilityObject: Mappable{
    
    var likabilitySeq : Int?
    var score : Int?
    var evaluationDate : String?
    var impression : [ImpressionObject]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        likabilitySeq <- map["likabilitySeq"]
        score <- map["score"]
        evaluationDate <- map["evaluationDate"]
        impression <- map["impression"]
    }
}

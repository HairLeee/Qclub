//
//  CompletionObject.swift
//  QClub
//
//  Created by SMR on 10/23/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class CompletionObject: Mappable{
    
    var completionSeq : Int?
    var score : Int?
    var evaluationDate : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        completionSeq <- map["completionSeq"]
        score <- map["score"]
        evaluationDate <- map["evaluationDate"]
    }
}

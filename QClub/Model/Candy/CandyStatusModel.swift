//
//  CandyStatusModel.swift
//  QClub
//
//  Created by SMR on 10/30/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

enum CandyStatus : String {
    case freeCandy = "F"
    case waitingCandy = "R"
    case candyInChat = "T"
    
}

class CandyStatusModel: Mappable {
    var candyStatusSeq : Int?
    var userSeq : Int?
    var candyUserCount : Int?
    var hostUserSeq : Int?
    var status : CandyStatus?
    var introduce : String?
    var changeDate : Int?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        candyStatusSeq <- map["candyStatusSeq"]
        userSeq <- map["userSeq"]
        candyUserCount <- map["candyUserCount"]
        hostUserSeq <- map["hostUserSeq"]
        status <- map["status"]
        introduce <- map["introduce"]
        changeDate <- map["changeDate"]
    }
}

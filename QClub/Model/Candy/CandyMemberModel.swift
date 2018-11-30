//
//  CandyMemberModel.swift
//  QClub
//
//  Created by SMR on 10/30/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class CandyMemberModel: Mappable {

    var introduce = ""
    var userSeq = 0
    var userInfo : TargetUserInfo?
    var candyListSeq : Int = 0
    var requestDate : Double?
    var responseDate : Double?
    var finished : Bool?
    var candyViewPaid : Double?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        introduce <- map["introduce"]
        userSeq <- map["userSeq"]
        userInfo <- map["userInfo"]
        candyListSeq <- map["candyListSeq"]
        requestDate <- map["requestDate"]
        responseDate <- map["responseDate"]
        finished <- map["finished"]
        candyViewPaid <- map["candyViewPaid"]
    }
}

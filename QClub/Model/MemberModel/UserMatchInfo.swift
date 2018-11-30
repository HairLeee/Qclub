//
//  UserMatchInfo.swift
//  QClub
//
//  Created by SMR on 10/16/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class UserMatchInfo: NSObject, Mappable {
    
    var matchTodaySeq : Int?
    var interestMatchSeq : Int?
    var interestDate : Double?
    var targetUserSeq: Int?
    var userSeq: Int?
    var matchedDate: Double?
    var paidDate: Double?

    var targetUserInfo : TargetUserInfo?
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map)
    {
        matchTodaySeq <- map["matchTodaySeq"]
        interestMatchSeq <- map["interestMatchSeq"]
        interestDate <- map["interestDate"]
        targetUserSeq <- map["targetUserSeq"]
        userSeq <- map["userSeq"]
        matchedDate <- map["matchedDate"]
        paidDate <- map["paidDate"]
        if let _ = map["targetUserInfo"].currentValue {
            targetUserInfo <- map["targetUserInfo"]
        }
        if let _ = map["userInfo"].currentValue {
            targetUserInfo <- map["userInfo"]
        }
    }
}

//
//  LikObject.swift
//  QClub
//
//  Created by SMR on 11/14/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

//
//  likObject.swift
//  QClub
//
//  Created by SMR on 11/14/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class LikObject: Mappable {
    
    var userSeq : Int?
    var s1 : Int?
    var s2 : Int?
    var s3 : Int?
    var s4 : Int?
    var s5 : Int?
    var s6 : Int?
    var s7 : Int?
    var s8 : Int?
    var s9 : Int?
    var s10 : Int?
    var ageRange : Int?
    var myAvg : Float?
    var maleAvg : Float?
    var femaleAvg : Float?
    var maleAgeAvg : Float?
    var femaleAgeAvg : Float?
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        userSeq <- map["userSeq"]
        s1 <- map["s1"]
        s2 <- map["s2"]
        s3 <- map["s3"]
        s4 <- map["s4"]
        s5 <- map["s5"]
        s6 <- map["s6"]
        s7 <- map["s7"]
        s8 <- map["s8"]
        s9 <- map["s9"]
        s10 <- map["s10"]
        ageRange <- map["ageRange"]
        myAvg <- map["myAvg"]
        maleAvg <- map["maleAvg"]
        femaleAvg <- map["femaleAvg"]
        maleAgeAvg <- map["maleAgeAvg"]
        femaleAgeAvg <- map["femaleAgeAvg"]
    }
}


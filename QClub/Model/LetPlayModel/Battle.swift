//
//  Battle.swift
//  QClub
//
//  Created by TuanNM on 11/10/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import Foundation
import ObjectMapper

class Battle: Mappable {
    
    var battleSeq : Int = -1
    var currentBattle : Int = -1
    var currentRound : Int = -1
    var user1 : BattleUser?
    var user2 : BattleUser?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        battleSeq <- map["battleSeq"]
        currentBattle <- map["currentBattle"]
        currentRound <- map["currentRound"]
        user1 <- map["user1"]
        user2 <- map["user2"]
    }
}

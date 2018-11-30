//
//  QclubInfo.swift
//  QClub
//
//  Created by Dreamup on 11/9/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import  ObjectMapper
class QclubInfo: Mappable {
    
    
    var currentLv:String = ""
    var status: String = ""
 
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        currentLv <- map["currentLv"]
        status <- map["status"]
  
    }
}


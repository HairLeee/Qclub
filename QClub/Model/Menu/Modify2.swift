//
//  Modify2.swift
//  QClub
//
//  Created by Dreamup on 10/20/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper
class Modify2:Mappable {
    
    
    var annualIncome:Int = 0
    var   propertyFlag:String = ""
    var  carFlag:String = ""
    var  carModel:String = ""
    var    personality:String = ""
    var hobby:String = ""
    var  travel:String = ""
    var  wishes:String = ""
    

    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        annualIncome <- map["annualIncome"]
        propertyFlag <- map["propertyFlag"]
        carFlag <- map["carFlag"]
        personality <- map["personality"]
        
        hobby <- map["hobby"]
        travel <- map["travel"]
        wishes <- map["wishes"]
 
    }
}

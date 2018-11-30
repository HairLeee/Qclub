//
//  MasterDataObject.swift
//  QClub
//
//  Created by SMR on 10/24/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class MasterDataObject: Mappable {
    
    var masterSeq : Int?
    var detailSeq : Int?
    var masterName : String?
    var detailName : String?
    var refDetailName : String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        masterSeq <- map["masterSeq"]
        detailSeq <- map["detailSeq"]
        masterName <- map["masterName"]
        detailName <- map["detailName"]
        refDetailName <- map["refDetailName"]
        
        detailName = detailName?.replacingOccurrences(of: "<br/>", with: "\n")
    }

}

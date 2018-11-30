//
//  ServerResponse.swift
//  NetNews
//
//  Created by HungVo on 48/30/17.
//  Copyright © 2017 Vietel Media. All rights reserved.
//

import Foundation
import ObjectMapper

class ServerResponse: Mappable{
    
    var code : Int?
    var message : String?
    var data : AnyObject?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        code <- map["code"]
        message <- map["message"]
        data <- map["data"]
    }
}

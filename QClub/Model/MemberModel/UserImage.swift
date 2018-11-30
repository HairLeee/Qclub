//
//  UserImage.swift
//  QClub
//
//  Created by SMR on 10/10/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class UserImage: NSObject, Mappable {

    var descriptionString : String?
    var orderSeq : Int?
    var profilePicture : UIImage?
    var profilePictureUrl : String = ""
    
    init(descriptionString : String?, orderSeq : Int?, profilePicture : UIImage?, profilePictureUrl : String? = nil) {
        super.init()
        self.descriptionString = descriptionString
        self.orderSeq = orderSeq
        self.profilePicture = profilePicture
        if let profilePictureUrl = profilePictureUrl{
            self.profilePictureUrl = profilePictureUrl
        }
        
    }
    
    override init() {}
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map)
    {
        descriptionString <- map["description"]
        orderSeq <- map["orderSeq"]
        profilePictureUrl <- map["profilePicture"]
        profilePictureUrl = "http://" + profilePictureUrl
    }
}

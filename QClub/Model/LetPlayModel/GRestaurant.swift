//
//  GFood.swift
//  QClub
//
//  Created by TuanNM on 11/9/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import Foundation

import ObjectMapper

class GRestaurant: Mappable {
    
    var userSeq : Int = 0
    var tastySeq : Int = 0
    var likeCnt : Int = 0
    var myLikeCnt : Int = 0
    var mainDish : String = ""
    var tastyLocation : String = ""
    var restaurant : String = ""
    var tastyPicture : String = ""
    var registerName : String = ""
    var registerProfilePic : String = ""
    var sameGender : String = ""
    var isRegister : String = ""
    var createDate : String = ""
    var gender : String = ""
    var tastyLikeUsers:[AnyObject]?
    var tastyPictures :[String] = []
    var address : String = ""
    var price : String = ""
    var contact : String = ""
    var description : String = ""
    
    var tastyData : [UIImage] = []
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
         contact <- map["contact"]
        price <- map["price"]
        tastySeq <- map["tastySeq"]
        userSeq <- map["userSeq"]
        likeCnt <- map["likeCnt"]
        myLikeCnt <- map["myLikeCnt"]
        mainDish <- map["mainDish"]
        tastyLocation <- map["tastyLocation"]
        restaurant <- map["restaurant"]
        registerName <- map["registerName"]
        registerProfilePic <- map["registerProfilePic"]
        sameGender <- map["sameGender"]
        isRegister <- map["isRegister"]
        address <- map["address"]
        description <- map["description"]
        createDate <- map["createDate"]
        gender <- map["gender"]
        tastyPictures <- map["tastyPictures"]
        tastyPicture <- map["tastyPicture"]
        tastyLikeUsers <- map["tastyLikeUsers"]
        
        tastyPicture = "http://" + tastyPicture
        
    }
}


//
//  UserLogin.swift
//  QClub
//
//  Created by SMR on 10/5/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class UserLogin: NSObject, Mappable, NSCoding {
    
    var id : String?
    var password: String?
    var name: String?
    var gender : String?
    var birthDay : String?
    var birthMonth : String?
    var birthYear : String?
    var mobile: String?
    var nickname : String?
    var userSeq : Int?
    var isWaitingAccept : Int?
    var updateDate : String?
    var createDate : String?
    var userProfilePicture:[UserImage]?
    var avatar : String?
    var latestLoginTime:String?
    
    override init() {}
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
    
    func mapping(map: Map)
    {
        id <- map["id"]
        password <- map["password"]
        latestLoginTime <- map["latestLoginTime"]
        name <- map["name"]
        gender <- map["gender"]
        birthDay <- map["birthDay"]
        birthMonth <- map["birthMonth"]
        birthYear <- map["birthYear"]
        mobile <- map["mobile"]
        nickname <- map["nickname"]
        userSeq <- map["userSeq"]
        updateDate <- map["updateDate"]
        createDate <- map["createDate"]
        userProfilePicture <- map["userProfilePicture"]
        if let images = userProfilePicture {
            if images.count > 0 {
                self.avatar = images[0].profilePictureUrl
            }
        }
    }
    
    required init(coder decoder: NSCoder) {
        self.id = decoder.decodeObject(forKey: "id") as? String ?? ""
        self.password = decoder.decodeObject(forKey: "password") as? String ?? ""
        self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
        self.gender = decoder.decodeObject(forKey: "gender") as? String ?? ""
        self.birthDay = decoder.decodeObject(forKey: "birthDay") as? String ?? ""
        self.birthMonth = decoder.decodeObject(forKey: "birthMonth") as? String ?? ""
        self.birthYear = decoder.decodeObject(forKey: "birthYear") as? String ?? ""
        self.mobile = decoder.decodeObject(forKey: "mobile") as? String ?? ""
        self.nickname = decoder.decodeObject(forKey: "nickname") as? String ?? ""
        self.updateDate = decoder.decodeObject(forKey: "updateDate") as? String ?? ""
        self.createDate = decoder.decodeObject(forKey: "createDate") as? String ?? ""
        self.userSeq = decoder.decodeObject(forKey: "userSeq") as? Int
        self.isWaitingAccept = decoder.decodeObject(forKey: "isWaitingAccept") as? Int
        self.avatar = decoder.decodeObject(forKey: "avatar") as? String ?? ""
        self.latestLoginTime = decoder.decodeObject(forKey: "latestLoginTime") as? String ?? ""
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(password, forKey: "password")
        coder.encode(name, forKey: "name")
        coder.encode(gender, forKey: "gender")
        coder.encode(birthDay, forKey: "birthDay")
        coder.encode(birthMonth, forKey: "birthMonth")
        coder.encode(birthYear, forKey: "birthYear")
        coder.encode(mobile, forKey: "mobile")
        coder.encode(nickname, forKey: "nickname")
        coder.encode(updateDate, forKey: "updateDate")
        coder.encode(createDate, forKey: "createDate")
        coder.encode(userSeq, forKey: "userSeq")
        coder.encode(isWaitingAccept, forKey: "isWaitingAccept")
        coder.encode(avatar, forKey: "avatar")
        coder.encode(latestLoginTime, forKey: "latestLoginTime")
    }
}

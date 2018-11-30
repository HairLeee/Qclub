//
//  UserLogin.swift
//  QClub
//
//  Created by SMR on 10/5/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class UserJoin: NSObject {
    
    //Join1
    var id : String?
    var password: String?
    var name: String?
    var gender : String?
    var birthDay : String?
    var birthMonth : String?
    var birthYear : String?
    var mobile: String?
    var sourceInfo : Int?
    var sourceInfoEtc : String?
    var recommendId : String?
    
    //Join2
    var nickName: String?
    var local: Int?
    var localEtc: String?
    var bloodType: Int?
    var height: Int?
    var bodyType: Int?
    
    //Join3
    var styles: [Int]?
    
    //Join4
    var school: String?
    var company: String?
    var job: String?
    var religion: Int?
    var religionEtc: String?
    var maritalStatus: String?
    var matchingTarget: String?
    var smoking: Int?
    var drinking: Int?
    
    //Join5
    var profilePictures: [UserImage]?
}

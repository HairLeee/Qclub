//
//  Member.swift
//  QClub
//
//  Created by Dream on 9/18/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class Member: NSObject, Mappable {
    
    var userSeq:Int = 0
    var height:Int = 0
    var annualIncome:Int = 0
    var certQ1Cnt:Int = 0
    var certQ2Cnt:Int = 0
    var certQ3Cnt:Int = 0
    var certQsCnt:Int = 0
    var pictureScore:Int = 0
    var informationScore:Int = 0
    var introduceScore:Int = 0
    var idealScore:Int = 0
    var q1Score:Int = 0
    var q2Score:Int = 0
    var q3Score:Int = 0
    var likabilityScore:Int = 0
    var totalScore:Int = 0
    var matchSpecialSeq:Int = 0
    var nickname:String = ""
    var levelName:String = ""
    var locationName:String = ""
    var birthYear:String = ""
    var gender:String = ""
    var maritalStatus:String = ""
    var bloodName:String = ""
    var bodyName:String = ""
    var userStyles:String = ""
    var affiliatedSchool:String = ""
    var affiliatedCompany:String = ""
    var job:String = ""
    var relegionName:String = ""
    var drinkingName:String = ""
    var smokingName:String = ""
    var propertyFlag:String = ""
    var carFlag:String = ""
    var carModel:String?
    var personality:String?
    var hobby:String?
    var travel:String?
    var wishes:String?
    var words:String?
    var appearance:String?
    var inHoliday:String?
    var lookFor:String?
    var profilePicture:[UserImage]?
    var matchStatus : MatchStatus?
    
    var isMemberShip = false
    
    func setMember(){
        isMemberShip = true
    }
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        userSeq <- map["userSeq"]
        height <- map["height"]
        annualIncome <- map["annualIncome"]
        certQ1Cnt <- map["certQ1Cnt"]
        certQ2Cnt <- map["certQ2Cnt"]
        certQ3Cnt <- map["certQ3Cnt"]
        certQsCnt <- map["certQsCnt"]
        pictureScore <- map["pictureScore"]
        informationScore <- map["informationScore"]
        introduceScore <- map["introduceScore"]
        idealScore <- map["idealScore"]
        q1Score <- map["q1Score"]
        q2Score <- map["q2Score"]
        q3Score <- map["q3Score"]
        likabilityScore <- map["likabilityScore"]
        totalScore <- map["totalScore"]
        nickname <- map["nickname"]
        levelName <- map["levelName"]
        locationName <- map["locationName"]
        maritalStatus <- map["maritalStatus"]
        birthYear <- map["birthYear"]
        gender <- map["gender"]
        bloodName <- map["bloodName"]
        bodyName <- map["bodyName"]
        userStyles <- map["userStyles"]
        affiliatedSchool <- map["affiliatedSchool"]
        affiliatedCompany <- map["affiliatedCompany"]
        job <- map["job"]
        relegionName <- map["relegionName"]
        drinkingName <- map["drinkingName"]
        smokingName <- map["smokingName"]
        propertyFlag <- map["propertyFlag"]
        carModel <- map["carModel"]
        carFlag <- map["carFlag"]
        personality <- map["personality"]
        hobby <- map["hobby"]
        wishes <- map["wishes"]
        words <- map["words"]
        appearance <- map["appearance"]
        inHoliday <- map["inHoliday"]
        lookFor <- map["lookFor"]
        profilePicture <- map["profilePicture"]
          travel <- map["travel"]
          matchStatus <- map["matchStatus"]
        
        userStyles = userStyles.replacingOccurrences(of: "<br/>", with: "")
    }
    
    
}

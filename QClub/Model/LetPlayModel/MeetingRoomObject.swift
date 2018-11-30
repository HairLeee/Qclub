//
//  MeetingRoomObject.swift
//  QClub
//
//  Created by SMR on 11/6/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class MeetingRoomObject: Mappable {

    var meetingDate : Double?
    var meetingSeq : Int?
    var users : [UserMeetingRoom]?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        meetingDate <- map["meetingDate"]
        meetingSeq <- map["meetingSeq"]
        users <- map["users"]
    }
}

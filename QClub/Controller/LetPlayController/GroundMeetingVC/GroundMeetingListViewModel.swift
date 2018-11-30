//
//  GroundMeetingListViewModel.swift
//  QClub
//
//  Created by SMR on 11/6/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class GroundMeetingListViewModel: NSObject {

    var rooms  = [MeetingRoomObject]()
    
    func numberOfRooms() -> Int {
        return rooms.count
    }
    
    
    
}

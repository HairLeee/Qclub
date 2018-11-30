//
//  Int.swift
//  QClub
//
//  Created by SMR on 11/6/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

extension Double {
    func toMeetingRoomString() -> String {
        let dateCurrent = Date.init(timeIntervalSince1970: self/1000)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd. HH:mm"
        let myStringafd = formatter.string(from: dateCurrent)
        return myStringafd
    }
    
    func toLetterTimeString() -> String {
        let dateCurrent = Date.init(timeIntervalSince1970: self/1000)
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd"
        let myStringafd = formatter.string(from: dateCurrent)
        return myStringafd
    }
    
    func toDate() -> Date {
        return Date.init(timeIntervalSince1970: self/1000)
    }
}

extension Int {
    func toStringWithComma() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:self)) ?? ""
    }
}

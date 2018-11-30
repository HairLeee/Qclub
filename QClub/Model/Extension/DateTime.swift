//
//  DateTime.swift
//  QClub
//
//  Created by SMR on 10/30/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = NSTimeZone.init(abbreviation: "UTC") as TimeZone!
        
        let myString = formatter.string(from: self)
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "yyyy-MM-dd"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        
        return myStringafd
    }
    
    
    func toMatchHistoryString() -> String {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.timeZone = NSTimeZone.init(abbreviation: "UTC") as TimeZone!
        
        let myString = formatter.string(from: self)
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MM"
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "dd"
        // again convert your date to string
        let monthString = monthFormatter.string(from: yourDate!)
        let dayString = dayFormatter.string(from: yourDate!)
        
        return monthString + "월" + " " + dayString + "일"
    }
}

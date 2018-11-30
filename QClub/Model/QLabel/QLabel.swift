//
//  QLabel.swift
//  QClub
//
//  Created by TuanNM on 10/23/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class QLabel: UILabel {

    override func layoutSubviews() {
        super.layoutSubviews()
        setFont()
    }

    func setFont(){
        var fontSize:CGFloat = 14
        switch UIDevice().screenType {
        case .iPhone4,.iPhones_5_5s_5c_SE:
            fontSize = 10
            break
        case .iPhones_6_6s_7_8,.iPhoneX:
            fontSize = 11.5
            break
        default:
            break
        }
        self.font =  UIFont(name: "NanumSquareOTF", size: fontSize)
    }
    
    
}

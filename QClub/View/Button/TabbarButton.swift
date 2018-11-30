//
//  TabbarButton.swift
//  QClub
//
//  Created by Dream on 9/14/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class TabbarButton: UIButton {

    let circle = UIView()
    
    override func setTitleColor(_ color: UIColor?, for state: UIControlState) {
        
        super.setTitleColor(color, for: state)
        
        circle.frame = CGRect(x: self.frame.size.width/2, y: 4, width: 6.0, height: 6.0)
        
        if color?.toHexString.lowercased() == ORANGE_COLOR{
            circle.layer.cornerRadius = 3
            circle.backgroundColor = UIColor(hexString: LIGHT_ORANGE_COLOR)
            circle.clipsToBounds = true
            self.addSubview(circle)
            return
        }
        circle.removeFromSuperview()
    }
    

}

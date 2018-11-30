//
//  SlideButton.swift
//  QClub
//
//  Created by Dream on 9/14/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class SlideButton: UIButton {

    func setSelect(isSelected:Bool){
        self.backgroundColor = UIColor(hexString: isSelected ? LIGHT_ORANGE_COLOR :LIGHT_GRAY_COLOR)
        self.setTitleColor(UIColor(hexString: isSelected ? "ffffff" : GRAY_COLOR), for: .normal)
    }

}

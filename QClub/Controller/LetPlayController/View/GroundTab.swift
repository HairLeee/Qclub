//
//  GroundTab.swift
//  QClub
//
//  Created by TuanNM on 10/23/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class GroundTab: UIButton {

    func setSelected(isSelect:Bool){
        let color = isSelect ? UIColor.white : UIColor.darkGray
        let backgroundColor = isSelect ? ORANGE_COLOR : LIGHT_GRAY_COLOR
        
        self.backgroundColor = UIColor.init(hexString: backgroundColor)
        self.setTitleColor(color, for: .normal)
    }

}

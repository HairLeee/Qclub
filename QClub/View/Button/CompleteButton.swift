//
//  CompleteButton.swift
//  QClub
//
//  Created by SMR on 10/3/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class CompleteButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        changeState(isActive: false)
    }

    func changeState(isActive: Bool, isChangeColor : Bool? = nil) {
        if isActive {
            if let _ = isChangeColor {
            } else {
                self.setTitleColor(buttonActiveColor, for: .normal)
                self.borderColor = buttonActiveColor
            }
            self.isUserInteractionEnabled = true
        } else {
            if let _ = isChangeColor {
            } else {
                self.setTitleColor(buttonInActiveColor, for: .normal)
                self.borderColor = buttonInActiveColor
            }
            self.isUserInteractionEnabled = false
        }
    }
}

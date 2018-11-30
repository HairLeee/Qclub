//
//  PurseCharsePopup.swift
//  QClub
//
//  Created by SMR on 10/9/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class PurseCharsePopup: PopupView {

    var actionCancel: (() -> ())?
    var actionOk: (() -> ())?
    
    class func instanceFromNib() -> PurseCharsePopup {
        let joinView = UINib(nibName: "PurseCharsePopup", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! PurseCharsePopup
        joinView.popupFrame = CGRect.init(x: 20, y: (SCREEN_HEIGHT - 130)/2 , width: SCREEN_WIDTH - 40, height: 130)
        return joinView
    }

    @IBAction func CancelTUI(_ sender: Any) {
        hide()
        if let action = actionCancel {
            action()
        }
    }
    @IBAction func OKTUI(_ sender: Any) {
        hide()
        if let action = actionOk {
            action()
        }
    }
}

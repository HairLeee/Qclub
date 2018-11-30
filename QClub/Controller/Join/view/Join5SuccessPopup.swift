//
//  join5SuccessPopup.swift
//  QClub
//
//  Created by SMR on 11/29/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class Join5SuccessPopup: PopupView {
    
    var okAction : (()->())?
    
    class func instanceFromNib() -> Join5SuccessPopup {
        let joinView = UINib(nibName: "Join5SuccessPopup", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Join5SuccessPopup
        joinView.popupFrame = CGRect.init(x: 20, y: (SCREEN_HEIGHT - 250)/2 , width: SCREEN_WIDTH - 40, height: 250)
        joinView.layer.cornerRadius = 5
        joinView.clipsToBounds = true
        joinView.isEnableTouchOutsideToDissmiss = false
        return joinView
        
    }

    @IBAction func okAction(_ sender: Any) {
        okAction?()
        hide()
    }
}

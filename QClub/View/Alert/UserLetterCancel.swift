//
//  UserLetterCancel.swift
//  QClub
//
//  Created by SMR on 11/8/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class UserLetterCancel: PopupView {

    @IBOutlet weak var lbName: UILabel!
    
    var action: (() -> ())?
    
    class func instanceFromNib() -> UserLetterCancel {
        let joinView = UINib(nibName: "UserLetterCancel", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UserLetterCancel
        joinView.lbName.text = Context.getUserLogin()?.nickname
        joinView.popupFrame = CGRect.init(x: 20, y: (SCREEN_HEIGHT - 250)/2 , width: SCREEN_WIDTH - 40, height: 250)
        joinView.layer.cornerRadius = 5
        joinView.clipsToBounds = true
        return joinView
    }
    
    @IBAction func okActionTUI(_ sender: Any) {
        hide()
        action?()
    }
    

}

//
//  UserPopup1.swift
//  QClub
//
//  Created by SMR on 10/10/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class UserPopup1: PopupView {

    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbHeart: UILabel!
    
    var okAction : (() -> ())?
    
    class func instanceFromNib(numberOfHeart: Int) -> UserPopup1 {
        let joinView = UINib(nibName: "UserPopup1", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UserPopup1
        joinView.lbContent.attributedText = Utils.getAtributedStringWithLinespace(text: "다른 큐클럽 회원님들은 상대 회원님을\n어떤 분으로 평가했을까요?\n궁금하시고 관심 있으시면 확인해보셔야죠~")

        joinView.popupFrame = CGRect.init(x: 0, y: (SCREEN_HEIGHT - 250), width: SCREEN_WIDTH, height: 250)
        joinView.lbHeart.text = "\(numberOfHeart) 개"
        return joinView
    }
    
    
    @IBAction func okTUI(_ sender: Any) {
        hide()
        if let action = okAction {
            action()
        }
    }
    
}

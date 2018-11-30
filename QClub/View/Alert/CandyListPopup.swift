//
//  CandyListPopup.swift
//  QClub
//
//  Created by SMR on 10/18/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class CandyListPopup: PopupView {

    @IBOutlet weak var lbHeart: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    
    var action: (() -> ())?
    
    class func instanceFromNib(numberOfHeart: Int) -> CandyListPopup {
        let joinView = UINib(nibName: "CandyListPopup", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CandyListPopup
        joinView.popupFrame = CGRect.init(x: 0, y: SCREEN_HEIGHT - 245 , width: SCREEN_WIDTH, height: 245)
        joinView.animationType = .upDown
        joinView.lbHeart.text = "\(numberOfHeart)"
        joinView.lbContent.attributedText = Utils.getAtributedStringWithLinespace(text: "나의 캔디는 어떤 분이었을까요?\n좀 더 알고 싶으시죠~\n캔디의 상세프로필을 확인하실 수 있어요")
        return joinView
    }
    @IBAction func okTUI(_ sender: Any) {
        hide()
        action?()
    }
}

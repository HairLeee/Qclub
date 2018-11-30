//
//  CandySearchPayPopup.swift
//  QClub
//
//  Created by SMR on 12/1/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class CandySearchPayPopup: PopupView {

    @IBOutlet weak var lbHeart: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    
    var action: (() -> ())?
    
    class func instanceFromNib(numberOfHeart: Int) -> CandySearchPayPopup {
        let joinView = UINib(nibName: "CandySearchPayPopup", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CandySearchPayPopup
        joinView.popupFrame = CGRect.init(x: 0, y: SCREEN_HEIGHT - 245 , width: SCREEN_WIDTH, height: 245)
        joinView.animationType = .upDown
        joinView.lbHeart.text = "\(numberOfHeart)"
        joinView.lbContent.attributedText = Utils.getAtributedStringWithLinespace(text: "서로 동감과 경청!\n내 안의 캔디를 찾아보세요~\n2명의 캔디 후보가 검색됩니다.")
        return joinView
    }
    @IBAction func okTUI(_ sender: Any) {
        hide()
        action?()
    }
}


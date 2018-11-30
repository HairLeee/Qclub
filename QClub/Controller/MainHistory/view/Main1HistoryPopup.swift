//
//  Main1HistoryPopup.swift
//  QClub
//
//  Created by SMR on 10/13/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

/*
 Page 44 in StoryBoard
 */

class Main1HistoryPopup: PopupView {

    @IBOutlet weak var lbHeart: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    

    var actionOK : (() -> ())?
    
    @IBAction func actionOk(_ sender: Any) {
        hide()
        actionOK?()
    }
    
    class func instanceFromNib(numberOfHeart: Int) -> Main1HistoryPopup {
        let joinView = UINib(nibName: "Main1HistoryPopup", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Main1HistoryPopup
        joinView.popupFrame = CGRect.init(x: 0, y: (SCREEN_HEIGHT - CGFloat(245)), width: SCREEN_WIDTH, height: CGFloat(245))
        
        joinView.lbContent.attributedText = Utils.getAtributedStringWithLinespace(text: "바쁘셔서 미처 확인하지 못한 분이 계실 수 있어요~\n다시 보니 호감이 가시는 분일 수도 있구요\n확인하지 못한 인연카드를 확인해보세요~")
        joinView.lbHeart.text = "\(numberOfHeart) 개"
        joinView.animationType = .upDown
        return joinView
    }
}

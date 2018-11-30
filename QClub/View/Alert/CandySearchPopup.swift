//
//  CandySearchPopup.swift
//  QClub
//
//  Created by SMR on 10/18/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class CandySearchPopup: PopupView {

    @IBOutlet weak var lbHeart: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    
    var action: (() -> ())?
    
    class func instanceFromNib(numberOfHeart: Int) -> CandySearchPopup {
        let joinView = UINib(nibName: "CandySearchPopup", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CandySearchPopup
        joinView.popupFrame = CGRect.init(x: 0, y: SCREEN_HEIGHT - 410 , width: SCREEN_WIDTH, height: 410)
        joinView.animationType = .upDown
        joinView.lbHeart.text = "\(numberOfHeart)"
        joinView.lbContent.attributedText = Utils.getAtributedStringWithLinespace(text: "캔디였던 회원에게 스페셜인연을 신청해서\n인연을 이어가실 수 있습니다.\n캔디였던 분이 회원님께 큰 호감을 갖고 있을 수 있습니다.\n‘스페셜 인연’을 신청하시면\n상대 회원에게 ‘스페셜 인연’ 신청이 알림으로 전해지고,\n다음날 낮 12시에 상대 회원은\n신청한 회원을 확인할 수 있습니다.\n스페셜 인연을 확인할 때까지\n누가 보냈는지 확인을 할 수 없답니다.\n설레임을 주세요~ 스페셜하게 다가가세요~\n‘스페셜 인연’ 입니다")
        return joinView
    }
    @IBAction func okTUI(_ sender: Any) {
        hide()
        action?()
    }
    
}

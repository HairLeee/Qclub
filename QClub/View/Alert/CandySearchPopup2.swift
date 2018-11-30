//
//  CandySearchPopup2.swift
//  QClub
//
//  Created by SMR on 10/18/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class CandySearchPopup2: PopupView {

    @IBOutlet weak var lbHeart: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    
    var action: (() -> ())?
    
    class func instanceFromNib(numberOfHeart: Int) -> CandySearchPopup2 {
        let joinView = UINib(nibName: "CandySearchPopup2", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CandySearchPopup2
        joinView.lbContent.attributedText = Utils.getAtributedStringWithLinespace(text: "캔디를 신청하시면 대화창이 개설되고, 선택하신 캔디 회원에게 알림이 전달됩니다.\n캔디회원이 대화에 참여한 시점부터 48시간 동안 대화창이 개설됩니다.\n\n48시간이 지나서 대화창이 닫힌 후,나의 캔디 리스트에서 캔디였던 분의 상세프로필을 확인하실 수 있으며, 스페셜 인연신청도 가능하게 됩니다.\n\n캔디를 선택하였는데, 캔디가 48시간 내에 대화에 응하지 않았을 경우, 캔디선택이 취소되고 하트가 환불됩니다.\n나만의 캔디~ 따뜻한 대화 나누셔요~")
        joinView.lbHeart.text = "\(numberOfHeart)"
        
        joinView.popupFrame = CGRect.init(x: 0, y: SCREEN_HEIGHT - 560 , width: SCREEN_WIDTH, height: 560)
        joinView.animationType = .upDown
        return joinView
    }

    @IBAction func okTUI(_ sender: Any) {
        hide()
        action?()
    }
}

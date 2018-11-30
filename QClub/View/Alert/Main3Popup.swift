//
//  Main3Popup1.swift
//  QClub
//
//  Created by SMR on 10/17/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class Main3Popup: PopupView {

    @IBOutlet weak var lbHeart: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var freeImv: UIImageView!
    
    enum Main3PopupType {
        case popup1
        case popup2
    }
    
    var okAction : (()->())?
    
    class func instanceFromNib(numberOfHeart: Int, type : Main3PopupType,nickname:String) -> Main3Popup {
        let joinView = UINib(nibName: "Main3Popup", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Main3Popup
        joinView.animationType = .upDown
        switch type {
        case .popup1:
            joinView.freeImv.isHidden = true
            joinView.lbTitle.text = "내게 호감 있는 인연보기"
            joinView.lbContent.attributedText = Utils.getAtributedStringWithLinespace(text: "와아~ 추카드려요~~\n회원님께 남다른 호감을 주신 분이 계셔요~\n좋은 인연 되시길 바랍니다~")
            joinView.btnOk.setTitle("내게 호감있는 회원 상세프로필 보기", for: .normal)
            break
        case .popup2:
            joinView.freeImv.isHidden = true
            joinView.lbTitle.text = "내게 관심편지를 보낸 인연"
            joinView.lbContent.attributedText = Utils.getAtributedStringWithLinespace(text: "왕왕추카 드립니다!!!\n아무에게나 관심편지 보내지 않죠~ 님은 분명 매력덩어리~")
            joinView.btnOk.setTitle("관심편지 확인하기", for: .normal)
        }
        joinView.lbHeart.text = "\(numberOfHeart)"
        joinView.popupFrame = CGRect.init(x: 0, y: SCREEN_HEIGHT - 260 , width: SCREEN_WIDTH, height: 260)
        return joinView
    }
    
    @IBAction func okActionTUI(_ sender: Any) {
        hide()
        okAction?()
    }
}

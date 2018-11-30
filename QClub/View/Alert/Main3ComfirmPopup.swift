//
//  Main3ComfirmPopup.swift
//  QClub
//
//  Created by SMR on 10/17/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class Main3ComfirmPopup: PopupView {

    @IBOutlet weak var lbContent: UILabel!
    
    var action: (() -> ())?
    
    class func instanceFromNib(nickName:String) -> Main3ComfirmPopup {
        let joinView = UINib(nibName: "Main3ComfirmPopup", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Main3ComfirmPopup
        joinView.lbContent.attributedText = Utils.getAtributedStringWithLinespace(text: "왕왕 추카 드립니다!!\n배려심이 많은 \(nickName)님께서\n관심편지 확인 하트를 동봉해서 보내셨어요~!\n아무에게나 관심편지 보내지 않죠~\n님은 분명 매력덩어리~")
        joinView.popupFrame = CGRect.init(x: 20, y: (SCREEN_HEIGHT - 250)/2 , width: SCREEN_WIDTH - 40, height: 250)
        return joinView
    }

    @IBAction func actionOk(_ sender: Any) {
        hide()
        action?()
    }
}

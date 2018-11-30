//
//  SettingPopup.swift
//  QClub
//
//  Created by Dreamup on 11/16/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class SettingPopup: PopupView {
    
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    
    var actionCancel: (() -> ())?
    var actionOk: (() -> ())?
    
    class func instanceFromNib() -> SettingPopup {
        let joinView = UINib(nibName: "SettingPopup", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! SettingPopup
//        joinView.lbName.text = Context.getUserLogin()?.nickname
//        joinView.lbContent.text = "절 좋게 봐주셔서 고맙습니다.\n저도 \(Context.getUserLogin()?.nickname ?? "")님께 호감이 갑니다.\n즐거운 대화 나누고 싶습니다."
        joinView.popupFrame = CGRect.init(x: 20, y: 20 , width: SCREEN_WIDTH - 40, height: SCREEN_HEIGHT - 60)
        joinView.layer.cornerRadius = 5
        joinView.clipsToBounds = true
        return joinView
    }
    
    @IBAction func cancelTUI(_ sender: Any) {
        hide()
        actionCancel?()
    }
    @IBAction func okTUI(_ sender: Any) {
        hide()
        actionOk?()
    }
}

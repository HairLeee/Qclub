//
//  MainPopup6.swift
//  QClub
//
//  Created by SMR on 10/6/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class MainPopup6: PopupView {

    @IBOutlet weak var lbContent: UILabel!
    var actionCancel: (() -> ())?
    var actionOk: (() -> ())?
    
    class func instanceFromNib() -> MainPopup6 {
        let joinView = UINib(nibName: "MainPopup6", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! MainPopup6
        joinView.setTextContent(text: "Q클럽이 처음이시군요.\n본인의 매력을 상대방이 충분히 알 수 있도록\n상세정보와 자기소개를 작성해주세요.\n정성과 진심이 담긴 본인소개가 아주 중요합니다\n상대방에게 회원님의 진정성을 전해주셔요.", label: joinView.lbContent)
        joinView.popupFrame = CGRect.init(x: 20, y: (SCREEN_HEIGHT - 230)/2 , width: SCREEN_WIDTH - 40, height: 230)
        return joinView
    }
    
    @IBAction func actionCancel(_ sender: Any) {
        self.hide()
        if let action = actionCancel {
            action()
        }
    }
    
    @IBAction func actionOk(_ sender: Any) {
        self.hide()
        if let action = actionOk {
            action()
        }
    }
    
    func setTextContent(text: String, label: UILabel) {
        let attributedString = NSMutableAttributedString(string: text)
        
        let paragraphStyle = NSMutableParagraphStyle()
        
        paragraphStyle.lineSpacing = 5
        paragraphStyle.alignment = .center
        
        attributedString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        label.attributedText = attributedString
    }
    
}

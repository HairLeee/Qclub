//
//  UserSpecialPopup.swift
//  QClub
//
//  Created by SMR on 10/6/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class UserSpecialPopup: PopupView {
    
    enum PopupType : Int {
        case candy = 0
        case meeting = 1
        case other = 2
    }
    
    @IBOutlet weak var lbHeartCount: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    var request40 : (() -> ())?
    var request42 : (() -> ())?
    
    class func instanceFromNib(type: PopupType, heartCount: Int) -> UserSpecialPopup {
        let joinView = UINib(nibName: "UserSpecialPopup", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UserSpecialPopup
        
        joinView.lbHeartCount.text = "\(heartCount) 개"
        var height = 0
        switch type {
        case .candy:
//            joinView.lbContent.attributedText = Utils.getAtributedStringWithLinespace(text: "캔디였던 회원에게 스페셜인연을 신청해서 본인의 프로필을 보여주실 수 있습니다.\n캔디였던 분이 회원님께 큰 호감을 갖고 있을 수 있습니다.\n‘스페셜 인연’을 신청하시면 상대 회원에게 ‘스페셜 인연’ 신청이 알림으로 전해지고,다음날 낮 12시에 상대 회원은 신청한 회원을 확인할 수 있습니다.\n스페셜 인연을 확인할 때까지 누가 보냈는지 확인을 할 수 없답니다.\n설레임을 주세요~ 스페셜하게 다가가세요~\n‘스페셜 인연’ 입니다")
            height = 400
        case .meeting:
//            joinView.lbContent.attributedText = Utils.getAtributedStringWithLinespace(text: "인연은 되지 못했지만, 스페셜인연을 신청해서 인연의 끈을 이어가실 수 있습니다.\n‘스페셜 인연’을 신청하시면 상대 회원에게 ‘스페셜 인연’ 신청이 알림으로 전해지고,다음날 낮 12시에 상대 회원은 신청한 회원을 확인할 수 있습니다.\n스페셜 인연을 확인할 때까지 누가 보냈는지 확인을 할 수 없답니다.\n설레임을 주세요~ 스페셜하게 다가가세요~\n‘스페셜 인연’ 입니다")
            height = 400
        case .other:
//            joinView.lbContent.attributedText = Utils.getAtributedStringWithLinespace(text: "나의 인연을 어디에서 찾을 수 있을까요?\n스쳐 지나가는 그 사람이~ 바로 나의 연인일 수도 있습니다.\n‘스페셜 인연’을 신청하시면 상대 회원에게 ‘스페셜 인연’ 신청이 알림으로 전해지고,다음날 낮 12시에 상대 회원은 신청한 회원을 확인할 수 있습니다.\n스페셜 인연을 확인할 때까지 누가 보냈는지 확인을 할 수 없답니다.\n설레임을 주세요~ 스페셜하게 다가가세요~\n‘스페셜 인연’ 입니다")
            height = 400
        }
        joinView.lbContent.attributedText = Utils.getAtributedStringWithLinespace(text: "작은 스침이 인연이 됩니다.\n지금 스친 분을 다시는 만나지 못할 수도 있습니다\n스페셜 인연을 통해서 작은 스침을 인연으로 만들어 보세요")
        
        
        joinView.popupFrame = CGRect.init(x: 0, y: SCREEN_HEIGHT - CGFloat(height) , width: SCREEN_WIDTH, height: CGFloat(height))
        return joinView
    }

    @IBAction func request40TUI(_ sender: Any) {
        hide()
        if let request = request40 {
            request()
        }
    }
    
    @IBAction func request42TUI(_ sender: Any) {
        hide()
        if let request = request42 {
            request()
        }
    }
}

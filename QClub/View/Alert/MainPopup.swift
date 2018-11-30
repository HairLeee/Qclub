//
//  Main1Popup.swift
//  QClub
//
//  Created by SMR on 10/6/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

enum PopupType : Int {
    case main1 = 0
    case main2 = 1
    case main31 = 2
    case main32 = 3
    case main4 = 4
    case main5 = 5
}

class MainPopup: PopupView {
    
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var imgFree: UIImageView!
    @IBOutlet weak var lbNumberOfHeartNeed: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    var numberOfHeart = 0
    var popupType : PopupType?
    @IBOutlet weak var lbHeart: UILabel!
    var okAction : (() -> ())?
    
    class func instanceFromNib(type: PopupType, numberOfHeart: Int, senderNickname : String? = nil) -> MainPopup {
        let joinView = UINib(nibName: "MainPopup", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! MainPopup
        var height = 0
        joinView.popupType = type
        switch joinView.popupType {
        case .main1?:
            height = 245
            joinView.lbTitle.text = "오늘의 두 번째 인연 확인 !"
            joinView.setTextContent(text: "오늘의 인연을 선택하셨죠? 나머지 분도 호감이 가신다면\n하트를 사용해서 상세프로필을 확인하실 수 있어요~", label: joinView.lbContent)
            joinView.btnOk.setTitle("인연카드 더 보기", for: .normal)
            joinView.lbNumberOfHeartNeed.text = "3"
        case .main2?:
            height = 245
            joinView.lbTitle.text = "오늘의 인연 더 보기 !"
            joinView.setTextContent(text: "오늘은 왠지 연애세포가 무지 살아나는 날이네요~\n추가로 2명의 회원을 더 만나실 수 있어요.", label: joinView.lbContent)
            joinView.btnOk.setTitle("인연카드 2장 더 보기", for: .normal)
            joinView.lbNumberOfHeartNeed.text = "5"
        case .main31?:
            height = 265
            joinView.lbTitle.text = "스페셜 인연 확인 !"
            joinView.setTextContent(text: "회원님께 스페셜한 마음을 가진 분이 계십니다!!!\n아무나 스페셜 인연카드를 받지 못합니다.\n오늘 참 좋은 날이네요~", label: joinView.lbContent)
            joinView.btnOk.setTitle("스페셜인연카드 확인하기", for: .normal)
            joinView.lbNumberOfHeartNeed.text = "2"
        case .main32?:
            height = 300
            joinView.lbTitle.text = "스페셜 인연 확인 !"
            let nickName = senderNickname ?? ""
            joinView.setTextContent(text: "회원님께 스페셜한 마음을 가진 분이 계십니다!!!\n배려심 많은 \(nickName)님이 상세프로필을 볼 수 있도록\n미리 하트를 지급해주셨습니다\n아무나 스페셜인연카드를 받지 못합니다.\n오늘 참 좋은 날이네요~", label: joinView.lbContent)
            joinView.btnOk.setTitle("스페셜인연카드 확인하기", for: .normal)
            joinView.imgFree.isHidden = false
        case .main4?:
            height = 245
            joinView.lbTitle.text = "Q1이상 등급 회원 카드 받기!"
            joinView.setTextContent(text: "신뢰도가 높은 Q1이상 등급 회원과 인연이 되실 수 있습니다\n나는 소중하니까~ 스스로 찾는 소중한 인연~ Q클럽~", label: joinView.lbContent)
            joinView.btnOk.setTitle("Q1이상 회원카드 받기", for: .normal)
            joinView.lbNumberOfHeartNeed.text = "5"
        case .main5?:
            height = 265
            joinView.lbTitle.text = "매력도 상위 20% 회원 카드 받기!"
            joinView.setTextContent(text: "매력도 상위 20% 회원님과 인연이 될 수 있습니다!\n외롭다고 아무나 만날 순 없죠~\n바로, 내가 만날 사람이니까~♥", label: joinView.lbContent)
            joinView.btnOk.setTitle("상위 20% 회원 카드받기", for: .normal)
            joinView.lbNumberOfHeartNeed.text = "5"
        default:
            break
        }
        joinView.animationType = .upDown
        joinView.popupFrame = CGRect.init(x: 0, y: (SCREEN_HEIGHT - CGFloat(height)), width: SCREEN_WIDTH, height: CGFloat(height))
        joinView.lbHeart.text = "\(numberOfHeart) 개"
        return joinView
    }
    
    
    @IBAction func okAction(_ sender: Any) {
        hide()
        okAction?()
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

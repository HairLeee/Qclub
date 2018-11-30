//
//  BoardDetailDialog.swift
//  QClub
//
//  Created by Dreamup on 10/23/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class BoardDetailDialog:  PopupView {
    
    
    var action: (() -> ())?
    
  
    @IBOutlet var lbTitle: UILabel!
    @IBOutlet var lbHeart: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    class func instanceFromNib(typeOfDialog: String, numberOfHeart: Int) -> BoardDetailDialog {
        let joinView = UINib(nibName: "BoardDetailDialog", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BoardDetailDialog
        
        
        var mTitle = ""
        var pTitle = ""
        switch typeOfDialog {
        case "GROUND_FOOD_DETAIL":
            joinView.btnOk.setTitle("상세 프포릴 확인하기", for: .normal)
            pTitle = "상세 프로필 확인하기"
            mTitle = "맛집을 소개한 회원의\n상세프로필을 확인하실 수 있습니다~\n"
        case "BOARD_DETAIL":
            pTitle = "상세프로필 보기!"
            mTitle = "글을 작성한 회원분이 어떤 분인지 궁금하시죠? \n 상세프로필을 확인하실 수 있어요~"
        default:
            pTitle = "상세프로필 보기!"
            mTitle = "글을 작성한 회원분이 어떤 분인지 궁금하시죠? \n 상세프로필을 확인하실 수 있어요~"
        }
        
        
        joinView.lbContent.attributedText = Utils.getAtributedStringWithLinespace(text: mTitle)
         joinView.lbTitle.attributedText = Utils.getAtributedStringWithLinespace(text: pTitle)
        joinView.lbHeart.text = "\(numberOfHeart)"
        
        joinView.popupFrame = CGRect.init(x: 0, y: SCREEN_HEIGHT - (SCREEN_WIDTH*2/3 + 50) , width: SCREEN_WIDTH, height: SCREEN_WIDTH*2/3 + 50)
        joinView.animationType = .upDown
        return joinView
    }
    
    @IBAction func okTUI(_ sender: Any) {
        hide()
        action?()
    }
    
    
    @IBOutlet var btnOk: UIButton!
    
    @IBAction func btnOk(_ sender: Any) {
        
          action?()
        
    }
    
}

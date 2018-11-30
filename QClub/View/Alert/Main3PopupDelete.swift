//
//  Main3PopupDelete.swift
//  QClub
//
//  Created by SMR on 10/18/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class Main3PopupDelete: PopupView {
    
    enum DeleteSide {
        case outSideChat
        case inSideChat
    }

    @IBOutlet weak var lbContent: UILabel!
    
    var actionCancel: (() -> ())?
    var actionOk: (() -> ())?

    
    class func instanceFromNib(deleteSide: DeleteSide) -> Main3PopupDelete {
        let joinView = UINib(nibName: "Main3PopupDelete", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Main3PopupDelete
        if deleteSide == .inSideChat {
            joinView.lbContent.attributedText = Utils.getAtributedStringWithLinespace(text: "대화창을 삭제하시면,\n다시 대화창이 복원되지 않습니다.\n대화창을 삭제하시겠어요?")
            joinView.popupFrame = CGRect.init(x: 20, y: (SCREEN_HEIGHT - 310)/2 , width: SCREEN_WIDTH - 40, height: 310)
        } else {
            joinView.lbContent.attributedText = Utils.getAtributedStringWithLinespace(text: "해당 내역을 삭제 하시겠습니까?")
            joinView.popupFrame = CGRect.init(x: 20, y: (SCREEN_HEIGHT - 260)/2 , width: SCREEN_WIDTH - 40, height: 260)
        }
        
        joinView.layer.cornerRadius = 5
        joinView.clipsToBounds = true
        return joinView
    }
    
    @IBAction func actionCancel(_ sender: Any) {
        hide()
        actionCancel?()
    }
    
    @IBAction func actionOk(_ sender: Any) {
        hide()
        actionOk?()
    }
    
}

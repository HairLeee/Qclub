//
//  Main3PopupMessage.swift
//  QClub
//
//  Created by SMR on 10/17/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit


class Main3PopupMessage: PopupView {

    @IBOutlet weak var imageBackground: UIImageView!
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var lbname: UILabel!
    @IBOutlet weak var textviewContent: UITextView!
    @IBOutlet weak var viewActionTo: UIView!
    @IBOutlet weak var viewActionFrom: UIView!
    @IBOutlet weak var lbTo: UILabel!
    @IBOutlet weak var sendBTN: CompleteButton!
    
    var actionTo : ((_ content: String)->())?
    var actionFromCancel : ((_ content: String)->())?
    var actionFromAccept : ((_ content: String)->())?
    
    enum MessageType {
        case from
        case to
    }
    
    class func instanceFromNib(type : MessageType ,userInfo : TargetUserInfo) -> Main3PopupMessage {
        let joinView = UINib(nibName: "Main3PopupMessage", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Main3PopupMessage
        switch type {
        case .from:
            joinView.viewActionTo.isHidden = false
            joinView.viewActionFrom.isHidden = true
            joinView.lbTo.text = "To. "
            joinView.textviewContent.isEditable = false
            joinView.getMessage(userSeq: userInfo.userSeq ?? 0)
            joinView.imageAvatar.kf.setImage(with: URL.init(string: Context.getUserLogin()?.avatar ?? "" ))
        case .to:
            joinView.viewActionTo.isHidden = true
            joinView.viewActionFrom.isHidden = false
            joinView.lbTo.text = "From. "
            joinView.imageAvatar.kf.setImage(with: URL.init(string: userInfo.profilePicture ))
            joinView.imageBackground.kf.setImage(with: URL.init(string: userInfo.profilePicture ))
        }
        joinView.clipsToBounds = true
        joinView.layer.cornerRadius = 5
        joinView.lbname.text = userInfo.nickName ?? ""
        joinView.imageAvatar.clipsToBounds = true
        joinView.imageAvatar.layer.cornerRadius = joinView.imageAvatar.frame.size.height/2
        joinView.isHandleKeyboard = true
        joinView.popupFrame = CGRect.init(x: 20, y: (SCREEN_HEIGHT - 340)/2 , width: SCREEN_WIDTH - 40, height: 340)
        return joinView
    }
    
    func getMessage(userSeq: Int) {
        MessageService.getLastSentMessage(targetUserSeq: userSeq, completion: { (response) in
            if let letter = response.data as? LetterUserObject {
                self.textviewContent.text = letter.message
            }
        }) { (error) in
            self.hide()
            UIApplication.shared.keyWindow?.makeToast((error as NSError).domain, duration: 2.0, position: .center)
        }
    }
    
    @IBAction func toTUI(_ sender: Any) {
        hide()
        actionTo?(textviewContent.text)
    }
    
    @IBAction func from1TUI(_ sender: Any) {
        hide()
        actionFromCancel?(textviewContent.text)
    }
    
    @IBAction func from2TUI(_ sender: Any) {
        hide()
        actionFromAccept?(textviewContent.text)
    }
}

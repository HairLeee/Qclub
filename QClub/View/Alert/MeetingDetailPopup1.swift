//
//  MeetingDetailPopup1.swift
//  QClub
//
//  Created by SMR on 11/15/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class MeetingDetailPopup1: PopupView {

    @IBOutlet weak var imageLevel: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var lbIntroduce: UILabel!
    @IBOutlet weak var lbBody: UILabel!
    @IBOutlet weak var lbStyle: UILabel!
    @IBOutlet weak var lbJob: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    var user : MeetingProfile?
    
    @IBAction func selectionTUI(_ sender: Any) {
        hide()
        select?()
    }
    
    @IBAction func closeTUI(_ sender: Any) {
        hide()
    }
    
    override func awakeFromNib() {
        textView.isEditable = false
    }
    
    var select: (() -> ())?
    
    class func instanceFromNib(user : MeetingProfile?) -> MeetingDetailPopup1 {

        let joinView = UINib(nibName: "MeetingDetailPopup1", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! MeetingDetailPopup1
        joinView.user = user
        joinView.popupFrame = CGRect.init(x: 20, y: (SCREEN_HEIGHT - 450)/2 , width: SCREEN_WIDTH - 40, height: 450)
        joinView.layer.cornerRadius = 5
        joinView.clipsToBounds = true
        joinView.setupUserDisplay()
        return joinView
    }
    
    func setupUserDisplay() {
        if let user = self.user {
            imageAvatar.kf.setImage(with: URL.init(string: user.profilePicture))
            imageAvatar.layer.cornerRadius = imageAvatar.frame.size.width/2
            imageAvatar.clipsToBounds = true
            image.kf.setImage(with: URL.init(string: user.profilePicture))
            lbName.text = user.nickName
            lbIntroduce.text = "\(user.location)에 사는 \(user.birthYear)년생 \(user.gender)\(user.marital)이고, 혈액형은 \(user.blood)입니다."
            lbBody.text = "키는 \(user.height)cm이고, \(user.body)체형입니다."
            lbStyle.text = "\(user.style) 스타일 입니다."
            lbJob.text = "\(user.school)에서 공부했고, \(user.company)의 \(user.job)입니다."
            textView.text = user.appeal
            
            let stampMember:[String] = ["stamp_q1.png","stamp_q2.png","stamp_q3.png","stamp_qs.png"]
            
            switch self.user?.level {
            case "Q1"?:
                imageLevel.image = UIImage(named: stampMember[0])
                break
            case "Q2"?:
                imageLevel.image = UIImage(named: stampMember[1])
                break
            case "Q3"?:
                imageLevel.image = UIImage(named: stampMember[2])
                break
            case "QS"?:
                imageLevel.image = UIImage(named: stampMember[3])
                break
            default:
                imageLevel.isHidden = true
                break
            }
        }
    }
}

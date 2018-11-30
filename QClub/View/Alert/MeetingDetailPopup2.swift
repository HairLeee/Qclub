//
//  MeetingDetailPopup2.swift
//  QClub
//
//  Created by SMR on 11/15/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class MeetingDetailPopup2: PopupView {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imgGender: UIImageView!
    @IBOutlet weak var imgBackground: UIImageView!
    @IBOutlet weak var lbIntroduce: UILabel!
    @IBOutlet weak var lbBody: UILabel!
    @IBOutlet weak var lbStyle: UILabel!
    @IBOutlet weak var lbJob: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var avatar: UIImageView!
    
    @IBOutlet var imageLevel: UIImageView!
    var select40: (() -> ())?
    var select42: (() -> ())?
    
    var user: MeetingProfile?
    
    class func instanceFromNib(user: MeetingProfile?) -> MeetingDetailPopup2 {
        let joinView = UINib(nibName: "MeetingDetailPopup2", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! MeetingDetailPopup2
        joinView.user = user

        joinView.popupFrame = CGRect.init(x: 20, y: 40 , width: SCREEN_WIDTH - 40, height: SCREEN_HEIGHT - 80)
        joinView.layer.cornerRadius = 5
        joinView.clipsToBounds = true
        joinView.setupUserDisplay()
        return joinView
    }
    
    func setupUserDisplay() {
        if let user = self.user {
            avatar.kf.setImage(with: URL.init(string: user.profilePicture))
            avatar.layer.cornerRadius = avatar.frame.size.width/2
            avatar.clipsToBounds = true
            image.kf.setImage(with: URL.init(string: user.profilePicture))
            lbName.text = user.nickName
            lbIntroduce.text = "\(user.location)에 사는 \(user.birthYear)년생 \(user.gender)\(user.marital)이고, 혈액형은 \(user.blood)입니다."
            lbBody.text = "키는 \(user.height)cm이고, \(user.body) 체형입니다."
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

    @IBAction func closeTUI(_ sender: Any) {
        hide()
    }
    
    @IBAction func action40(_ sender: Any) {
        hide()
        select40?()
    }
    
    @IBAction func action42(_ sender: Any) {
        hide()
        select42?()
    }
    
}

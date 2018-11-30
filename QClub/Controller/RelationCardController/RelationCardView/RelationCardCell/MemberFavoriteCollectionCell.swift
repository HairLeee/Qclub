//
//  MemberFavoriteCell.swift
//  QClub
//
//  Created by SMR on 10/17/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import Kingfisher

class MemberFavoriteCollectionCell: UICollectionViewCell {

    @IBOutlet weak var letterImage: UIImageView!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var viewDetail: UIView!
    @IBOutlet weak var viewLike: UIView!
    @IBOutlet weak var lbNumberOfLike: UILabel!
    @IBOutlet weak var lbname: UILabel!
    @IBOutlet weak var lbHeight: UILabel!
    @IBOutlet weak var lbAge: UILabel!
    @IBOutlet weak var lbJob: UILabel!
    @IBOutlet weak var lbBody: UILabel!
    @IBOutlet weak var lbLocation: UILabel!
    @IBOutlet weak var iconMemberShopImv: UIImageView!
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var letterButton: UIButton!
    @IBOutlet weak var lockImv: UIImageView!
    
    var letterAction : ((_ status : MessageStatus) ->())?
    var deleteAction : ((_ status : MessageStatus) ->())?
    var target : TargetUserInfo?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewDetail.layer.borderColor = UIColor.gray.cgColor
        viewDetail.layer.borderWidth = 1.0
        viewDetail.clipsToBounds = true
        viewDetail.layer.cornerRadius = 5.0
    }
    @IBAction func letterTUI(_ sender: Any) {
        if let target  = self.target {
            if let messageStatus = target.messageStatus {
                switch messageStatus {
                case "S":
                    letterAction?(.sendFavoriteLetter)
                case "R" :
                    letterAction?(.receiveFavoriteLetter)
                case "A":
                    letterAction?(.talk)
                default :
                    letterAction?(.none)
                }
            } else {
                letterAction?(.none)
            }
        }

        
    }
    
    func setupLetter(user : LetterUserObject) {
        if let targetUser = user.user {
            lockImv.isHidden = true
            self.target = targetUser
            avatar.kf.setImage(with: URL.init(string: targetUser.profilePicture))
            if let name = targetUser.nickName {
                lbname.text = name
            }
            if let address = targetUser.location {
                lbLocation.text = address
            }
            if let age = targetUser.age {
                lbAge.text = "\(age)" + "세"
            }
            if let job = targetUser.job {
                lbJob.text = job
            }
            if let height = targetUser.height {
                lbHeight.text = "\(height)cm"
            }
            if let body = targetUser.body {
                lbBody.text = body
            }
            
            if let _ = targetUser.qlevel {
                iconMemberShopImv.isHidden = false
            } else {
                iconMemberShopImv.isHidden = true
            }
            if targetUser.likability != nil && targetUser.likability! > 0 {
                viewLike.isHidden = false
                lbNumberOfLike.text = "\(targetUser.likability!)"
            } else {
                viewLike.isHidden = true
            }
            
            if let intDate = user.sendDate {
                lbTime.text = intDate.toLetterTimeString()
            }
            
            let messageStatus = targetUser.messageStatus != nil ?  targetUser.messageStatus! : "non"
            
            switch messageStatus.uppercased(){
            case  "S":
                letterImage.image = #imageLiteral(resourceName: "ic_letter_send")
                break
            case  "R":
                letterImage.image = #imageLiteral(resourceName: "ic_letter_received")
                break
            case  "A":
                letterImage.image = #imageLiteral(resourceName: "ic_letter_talk")
                break
            default:
                letterImage.image = #imageLiteral(resourceName: "ic_letter")
                break
            }
        }
    }
    
    func setup(data : UserMatchInfo) {
        if let targetUser = data.targetUserInfo {
            
            if data.userSeq == Context.getUserLogin()?.userSeq {
                // Frome me
                lockImv.isHidden = true
            } else {
                // To me
                lockImv.isHidden = (data.paidDate != nil || (data.targetUserInfo?.likability ?? 0) > 0)
            }
            
            self.target = data.targetUserInfo
            avatar.kf.setImage(with: URL.init(string: targetUser.profilePicture))
            if let name = targetUser.nickName {
                lbname.text = name
            }
            if let address = targetUser.location {
                lbLocation.text = address
            }
            if let age = targetUser.age {
                lbAge.text = "\(age)" + "세"
            }
            if let job = targetUser.job {
                lbJob.text = job
            }
            if let height = targetUser.height {
                lbHeight.text = "\(height)cm"
            }
            if let body = targetUser.body {
                lbBody.text = body
            }
            
            if let _ = targetUser.qlevel {
                iconMemberShopImv.isHidden = false
            } else {
                iconMemberShopImv.isHidden = true
            }
            if targetUser.likability != nil && targetUser.likability! > 0 {
                viewLike.isHidden = false
                lbNumberOfLike.text = "\(targetUser.likability!)"
            } else {
                viewLike.isHidden = true
            }
            
            if let intDate = data.interestDate {
                lbTime.text = intDate.toLetterTimeString()
            }
            
            let messageStatus = targetUser.messageStatus != nil ?  targetUser.messageStatus! : "non"
            
            switch messageStatus.uppercased(){
            case  "S":
                letterImage.image = #imageLiteral(resourceName: "ic_letter_send")
                break
            case  "R":
                letterImage.image = #imageLiteral(resourceName: "ic_letter_received")
                break
            case  "A":
                letterImage.image = #imageLiteral(resourceName: "ic_letter_talk")
                break
            default:
                letterImage.image = #imageLiteral(resourceName: "ic_letter")
                break
            }
        }
    }

}

//
//  MemberInfomationCell.swift
//  QClub
//
//  Created by Dream on 9/18/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import Kingfisher

enum MessageStatus : String {
    case none = ""
    case sendFavoriteLetter = "S"
    case receiveFavoriteLetter = "R"
    case talk = "A"
}

class MemberInfomationCell: UICollectionViewCell {
    
    var callBackShowInfo:((_ cell:MemberInfomationCell)->Void)?
    var callBackShowMembershipInfo:((_ cell:MemberInfomationCell)->Void)?
    var callBackShowEmail:((_ status: MessageStatus)->Void)?
    var fontSize:CGFloat = 11
    
    
    @IBOutlet weak var emailImage: UIImageView!
    @IBOutlet weak var emailImv: UIButton!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var addressLb: UILabel!
    @IBOutlet weak var ageLb: UILabel!
    @IBOutlet weak var jobLb: UILabel!
    @IBOutlet weak var heightLb: UILabel!
    @IBOutlet weak var bodyLb: UILabel!
    @IBOutlet weak var numberLikesLb: UILabel!
    
    @IBOutlet weak var viewLikes: UIView!
    @IBOutlet weak var infoNewMemberBtn: UIButton!
    
    @IBOutlet weak var infoMemberShipbtn: UIButton!
    @IBOutlet weak var iconMemberShopImv: UIImageView!
    
    @IBOutlet weak var blueView: UIView!
    
    @IBOutlet weak var lockImv: UIImageView!
    
    
    var member : UserMatchInfo?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLb.font = UIFont.systemFont(ofSize: fontSize)
        addressLb.font = UIFont.systemFont(ofSize: fontSize)
        ageLb.font = UIFont.systemFont(ofSize: fontSize)
        jobLb.font = UIFont.systemFont(ofSize: fontSize)
        heightLb.font = UIFont.systemFont(ofSize: fontSize)
        bodyLb.font = UIFont.systemFont(ofSize: fontSize)
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        
        
    }
    
    func setData(member:UserMatchInfo, isBlur: Bool){
        self.member = member
        //blueView.isHidden = !isBlur
        lockImv.isHidden = !isBlur
        
        if let targetUser = member.targetUserInfo {
            
            let messageStatus = targetUser.messageStatus != nil ?  targetUser.messageStatus! : "non"
            
            switch messageStatus.uppercased(){
            case  "S":
                emailImage.image = #imageLiteral(resourceName: "ic_letter_send")
                break
            case  "R":
                emailImage.image = #imageLiteral(resourceName: "ic_letter_received")
                break
            case  "A":
                emailImage.image = #imageLiteral(resourceName: "ic_letter_talk")
                break
            default:
                emailImage.image = #imageLiteral(resourceName: "ic_letter")
                break
            }
            
            let picture = targetUser.profilePicture
            
            if let url = URL(string: picture){
                ImageDownloader.default.downloadImage(with:url, retrieveImageTask: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, url, data) in
                    if let image = image{
                        self.avatar.image = image
                    } else {
                        self.avatar.image = UIImage.init(named: "ic_photo")
                    }
                })
            } else {
                self.avatar.image = UIImage.init(named: "ic_photo")
            }
            
            if let name = targetUser.nickName {
                nameLb.text = name
            }
            if let address = targetUser.location {
                addressLb.text = address
            }
            if let age = targetUser.age {
                ageLb.text = "\(age)" + "세"
            }
            if let job = targetUser.job {
                jobLb.text = job
            }
            if let height = targetUser.height {
                heightLb.text = "\(height)cm"
            }
            if let body = targetUser.body {
                bodyLb.text = body
            }
            
            
            if let _ = targetUser.qlevel {
                iconMemberShopImv.isHidden = false
                infoMemberShipbtn.isHidden = false
            } else {
                iconMemberShopImv.isHidden = true
                infoMemberShipbtn.isHidden = true
            }
            if targetUser.likability != nil && targetUser.likability! > 0 {
                viewLikes.isHidden = false
                numberLikesLb.text = "\(targetUser.likability!)"
                infoNewMemberBtn.isHidden = false
            } else {
                infoNewMemberBtn.isHidden = true
                viewLikes.isHidden = true
            }
        }
    }
    
    @IBAction func showInfoMemberShipAction(_ sender: Any) {
        callBackShowMembershipInfo?(self)
    }
    
    @IBAction func infoAction(_ sender: Any) {
        callBackShowInfo?(self)
    }
    
    @IBAction func emailAction(_ sender: Any) {
        if let user  = self.member {
            if let target = user.targetUserInfo {
                if let messageStatus = target.messageStatus {
                    if let status = MessageStatus.init(rawValue: messageStatus) {
                        callBackShowEmail?(status)
                    }
                } else {
                    callBackShowEmail?(.none)
                }
            }
        }
    }
    
}

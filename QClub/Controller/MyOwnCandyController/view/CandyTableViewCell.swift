//
//  CandyTableViewCell.swift
//  QClub
//
//  Created by SMR on 10/18/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import Kingfisher

class CandyTableViewCell: UITableViewCell {

    @IBOutlet weak var vDescription: UIView!
    @IBOutlet weak var vInfo: UIView!
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbLocation: UILabel!
    @IBOutlet weak var lbAge: UILabel!
    @IBOutlet weak var lbJob: UILabel!
    @IBOutlet weak var lbHeight: UILabel!
    @IBOutlet weak var lbBody: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    
    var selectCell: (()->())?
    var letterAction: ((_ userInfo : TargetUserInfo)->())?
    var member : CandyMemberModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        vInfo.clipsToBounds = true
        vInfo.layer.cornerRadius = 5
        vInfo.layer.borderWidth = 1
        vInfo.layer.borderColor = UIColor.gray.cgColor
        
        vDescription.clipsToBounds = true
        vDescription.layer.cornerRadius = 5
        vDescription.layer.borderWidth = 1
        vDescription.layer.borderColor = UIColor.gray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func letterAction(_ sender: Any) {
        if let member = self.member {
            if let user = member.userInfo {
                letterAction?(user)
            }
        }
    }
    @IBAction func selectTUI(_ sender: Any) {
        selectCell?()
    }
    
    func setData(member: CandyMemberModel) {
        self.member = member
        if let target = member.userInfo {
            imageAvatar.kf.setImage(with: URL.init(string: target.profilePicture))
            lbName.text = target.nickName
            lbLocation.text = target.location
            if let age : Int = target.age {
                lbAge.text = "\(age)" + "세"
            }
            lbJob.text = target.job
            if let height : Int = target.height {
                lbHeight.text = "\(height) cm"
            }
            lbBody.text = target.body
            
            
        }

    }
    
}

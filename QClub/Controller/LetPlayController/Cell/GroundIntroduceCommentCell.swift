//
//  GroundIntroduceCommentCell.swift
//  QClub
//
//  Created by TuanNM on 10/16/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class GroundIntroduceCommentCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var avatarImv: UIImageView!
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var addressLb: UILabel!
    @IBOutlet weak var ageLb: UILabel!
    @IBOutlet weak var jobLb: UILabel!
    @IBOutlet weak var heightLb: UILabel!
    @IBOutlet weak var bodyLb: UILabel!
    @IBOutlet weak var introduceLb: UILabel!
    
    @IBOutlet weak var dateLb: UILabel!
    @IBOutlet weak var lineHeightConstraint: NSLayoutConstraint!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.borderWidth = 0.5
        lineHeightConstraint.constant = 0.5
        avatarImv.layer.cornerRadius = avatarImv.frame.size.width/2
        avatarImv.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(member:GIMember){
        
        avatarImv.kf.setImage(with: URL(string: member.representPicture))
        nameLb.text = member.nickname
        addressLb.text = member.location
        ageLb.text = "\(member.age)세"
        jobLb.text = member.job
        heightLb.text = "\(member.height)cm"
        bodyLb.text = member.body
        introduceLb.text = member.review
    }

}

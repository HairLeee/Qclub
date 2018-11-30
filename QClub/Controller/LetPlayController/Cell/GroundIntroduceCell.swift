//
//  GroundIntroduceCell.swift
//  QClub
//
//  Created by TuanNM on 10/16/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class GroundIntroduceCell: UITableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var avatarImv: UIImageView!
    @IBOutlet weak var nameLb: QLabel!
    @IBOutlet weak var addressLb: QLabel!
    @IBOutlet weak var ageLb: QLabel!
    @IBOutlet weak var jobLb: QLabel!
    @IBOutlet weak var heightLb: QLabel!
    @IBOutlet weak var bodyLb: QLabel!
    @IBOutlet weak var introduceLb: QLabel!
    
    @IBOutlet weak var numberView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.borderColor = UIColor.init(hexString: LINE_GRAY_COLOR)?.cgColor
        containerView.layer.borderWidth = 0.6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(user:GIMember){
        
        avatarImv.kf.setImage(with: URL(string: user.representPicture))
        nameLb.text = user.nickname
        addressLb.text = user.location
        ageLb.text = "\(user.age)세"
        jobLb.text = user.job
        heightLb.text = "\(user.height)cm"
        bodyLb.text = user.body
        introduceLb.text = user.introduce
        numberView.text = "\(user.reviewCnt)"
    }

}

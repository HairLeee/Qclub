//
//  PlayerSearchCell.swift
//  QClub
//
//  Created by TuanNM on 10/13/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class PlayerSearchCell: UICollectionViewCell {
    
    var callBackShowEmail:((_ cell:PlayerSearchCell)->Void)?
    var fontSize:CGFloat = 11
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var addressLb: UILabel!
    @IBOutlet weak var ageLb: UILabel!
    @IBOutlet weak var jobLb: UILabel!
    @IBOutlet weak var heightLb: UILabel!
    @IBOutlet weak var bodyLb: UILabel!
    @IBOutlet weak var blueView: UIView!
    @IBOutlet weak var stampImv: UIImageView!
    
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
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    @IBAction func emailAction(_ sender: Any) {
        callBackShowEmail?(self)
    }
    
    func setData(member:GIMember) {
        nameLb.text = member.nickname
        addressLb.text = member.location
        ageLb.text = "\(member.age)세"
        jobLb.text = member.job
        heightLb.text = "\(member.height)cm"
        bodyLb.text = member.body
        
        blueView.isHidden = member.isLock ? false : true
        
        avatar.kf.setImage(with: URL.init(string: member.representPicture))
        
        switch member.level {
        case "Q1":
            stampImv.image = UIImage(named: "stamp_q1")
            break
        case "Q2":
            stampImv.image = UIImage(named: "stamp_q2")
            break
        case "Q3":
            stampImv.image = UIImage(named: "stamp_q3")
            break
        case "QS":
            stampImv.image = UIImage(named: "stamp_qs")
            break
        default:
            break
        }
        
        
    }
    
}

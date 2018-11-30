//
//  SpeciaMemberCell.swift
//  QClub
//
//  Created by Dream on 9/18/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import Kingfisher

class SpeciaMemberCell: UICollectionViewCell {
    
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var icMemberShipImv: UIImageView!
    @IBOutlet weak var icMarkSpecialMember: UIImageView!
    @IBOutlet weak var blueView: UIView!
    
    var disableBubble : (() ->())?
    
    func setData(member:SpecialMember){

        if let url = URL(string: member.profilePicture){
            ImageDownloader.default.downloadImage(with:url, retrieveImageTask: nil, options: nil, progressBlock: nil, completionHandler: { (image, error, url, data) in
                if let image = image{
                    self.avatar.image = image
                }
            })
        }
        
        blueView.isHidden = (member.paidDate != nil)
        icMarkSpecialMember.isHidden = (member.paidDate != nil)
    }
    
    func addFakeButtonDisableBuble() {
        let button = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: self.frame.size.width, height: 50))
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(disableBuble), for: .touchUpInside)
        self.addSubview(button)
    }
    
    @objc func disableBuble() {
        disableBubble?()
    }
}

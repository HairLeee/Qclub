//
//  MyInfomationCollectionViewCell.swift
//  QClub
//
//  Created by Dreamup on 10/25/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import Kingfisher
class MyInfomationCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var imvAvatar: UIImageView!
    @IBOutlet weak var viewOder: UIView!
    @IBOutlet weak var lbOder: UILabel!
    @IBOutlet weak var imgPlus: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bidingData(url:UserImage, index : Int){
        if url.orderSeq != -1 {
            if let image = url.profilePicture {
                imvAvatar.image = image
            } else {
                imvAvatar.kf.setImage(with: URL.init(string: url.profilePictureUrl))
            }
            imvAvatar.isHidden = false
            imgPlus.isHidden = true
            viewOder.isHidden = false
            let seq : Int = index + 1
            lbOder.text = "\(seq)"
        } else {
            imvAvatar.isHidden = true
            imgPlus.isHidden = false
            viewOder.isHidden = true
        }
        
      
        
    }

}

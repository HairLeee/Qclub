//
//  GroundItemCell.swift
//  QClub
//
//  Created by TuanNM on 10/26/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class GroundItemCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImv: UIImageView!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var likeView: UIView!
    @IBOutlet weak var numberLilkeLb: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.init(hexString: LINE_GRAY_COLOR)?.cgColor
        
        likeView.layer.cornerRadius = 3
        likeView.clipsToBounds = true
    }
    
    func setData(item: ItemObject){
        itemImv.kf.setImage(with: URL.init(string: item.itItemPicture))
        itemName.text = item.title
        if item.likeCnt > 0 {
            likeView.isHidden = false
            numberLilkeLb.text = "\(item.likeCnt)"
        } else {
            likeView.isHidden = true
        }
        
    }
}

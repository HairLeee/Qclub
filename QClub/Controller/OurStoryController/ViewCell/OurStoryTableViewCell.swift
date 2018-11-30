//
//  OurStoryTableViewCell.swift
//  QClub
//
//  Created by Dreamup on 10/23/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class OurStoryTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var imvAvatar: UIImageView!
    
    
    @IBOutlet weak var lbTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bidingData(OurStoryModel:OurStoryModel){
        
        lbTitle.text = OurStoryModel.mTitle
        imvAvatar.image = UIImage(named:OurStoryModel.mNameOfIcon)
        
    }
    
}

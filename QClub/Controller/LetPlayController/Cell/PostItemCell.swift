//
//  PostItemCell.swift
//  QClub
//
//  Created by SMR on 11/17/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class PostItemCell: UICollectionViewCell {
    
    var actionMoreItem : (()->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func Action(_ sender: Any) {
        actionMoreItem?()
    }
}

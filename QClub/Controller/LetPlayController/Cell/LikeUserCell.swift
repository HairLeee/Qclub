//
//  LikeUserCell.swift
//  QClub
//
//  Created by TuanNM on 10/25/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class LikeUserCell: UICollectionViewCell {
    
    @IBOutlet weak var avatar: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.contentView.frame = self.bounds
    }

}

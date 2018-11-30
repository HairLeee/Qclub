//
//  ModifyTwoCollectionViewCell.swift
//  QClub
//
//  Created by Dreamup on 10/25/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class ModifyTwoCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet var tbTitle: UILabel!
    
    @IBOutlet var viewCell: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 0.5
        self.backgroundColor = UIColor.orange
    }
    
    func configBackgroundForSelected(isSelected: Bool) {
        if isSelected {
            self.backgroundColor = UIColor.orange
        } else {
            self.backgroundColor = UIColor.white
        }
    }

}

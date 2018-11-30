//
//  Join3CollectionViewCell.swift
//  QClub
//
//  Created by SMR on 10/2/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class Join3CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 0.5
    }
    
    func configBackgroundForSelected(isSelected: Bool) {
        if isSelected {
            self.backgroundColor = UIColor.init(hexString: "#ffaa4f")
        } else {
            self.backgroundColor = UIColor.white
        }
    }
}

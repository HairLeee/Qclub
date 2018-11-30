//
//  HeartCollectionViewCell.swift
//  QClub
//
//  Created by Dreamup on 10/30/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class HeartCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lbPosition: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bidingData(position:Int){
        
        lbPosition.text = String(position)
        
    }

}

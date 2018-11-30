//
//  AreaCelll.swift
//  QClub
//
//  Created by Dreamup on 10/16/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class AreaCelll: UICollectionViewCell {
    
    
    
    var isAllowToChoose = true
    @IBOutlet weak var lbName: UILabel!
   
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
    
    func checkBox() {
        
        
        
        
    }
}

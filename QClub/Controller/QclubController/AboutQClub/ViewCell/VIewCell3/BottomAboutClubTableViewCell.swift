//
//  BottomAboutClubTableViewCell.swift
//  QClub
//
//  Created by Dreamup on 11/13/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class BottomAboutClubTableViewCell: UITableViewCell {

    
    var goToContact: (()->())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func btnLeftAction(_ sender: Any) {
        
    }
    
    @IBAction func btnRightAction(_ sender: Any) {
        goToContact?()
    }
}

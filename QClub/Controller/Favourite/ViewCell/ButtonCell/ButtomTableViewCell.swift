//
//  ButtomTableViewCell.swift
//  QClub
//
//  Created by Dreamup on 11/28/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class ButtomTableViewCell: UITableViewCell {
    
    var onItemClick:OnClickListener?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func btnUploadAction(_ sender: Any) {
        onItemClick?.clickOkAction()
    }
    
    
}

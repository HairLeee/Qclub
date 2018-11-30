//
//  AcceptSpecialRelationCell.swift
//  QClub
//
//  Created by SMR on 10/9/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class AcceptSpecialRelationCell: ProfileBaseCell {

    var actionCancel : (() -> ())?
    var actionOk : (() -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func cancelTUI(_ sender: Any) {
        actionCancel?()
    }
    
    @IBAction func acceptTUI(_ sender: Any) {
        actionOk?()
    }
}

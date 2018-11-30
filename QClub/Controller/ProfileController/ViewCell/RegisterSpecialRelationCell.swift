//
//  RegisterSpecialRelationCell.swift
//  QClub
//
//  Created by SMR on 10/9/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit


class RegisterSpecialRelationCell: ProfileBaseCell {
    var requestSpecialRelationShip : (()->())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func showPopup(_ sender: Any) {
        requestSpecialRelationShip?()
    }
}

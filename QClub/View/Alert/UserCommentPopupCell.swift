//
//  UserCommentPopupCell.swift
//  QClub
//
//  Created by SMR on 10/10/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class UserCommentPopupCell: UITableViewCell {

    @IBOutlet weak var lbContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isUserInteractionEnabled = true
    }
    
    func configBackgroundForSelected(isSelected: Bool) {
        if isSelected {
            self.contentView.backgroundColor = backgroundCellSelectedColor
        } else {
            self.contentView.backgroundColor = UIColor.white
        }
    }
}

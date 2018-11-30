//
//  FriendlyScoreChartCell.swift
//  QClub
//
//  Created by SMR on 10/9/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

protocol FriendlyScoreChartCellDelegate {
    func showChart()
}

class FriendlyScoreChartCell: ProfileBaseCell {
    
    var delegate : FriendlyScoreChartCellDelegate?
    var member : Member?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(member: Member) {
        self.member = member
    }

    @IBAction func showChart(_ sender: Any) {
        UserCommentPopup.instanceFromNib(userSeq: 3).show()
    }
}

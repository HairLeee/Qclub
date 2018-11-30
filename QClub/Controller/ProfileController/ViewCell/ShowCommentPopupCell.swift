//
//  ShowCommentPopupCell.swift
//  QClub
//
//  Created by SMR on 10/9/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class ShowCommentPopupCell: ProfileBaseCell {

    var member : Member?
     var delegate : FriendlyScoreChartCellDelegate?
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

    @IBAction func showPoupTUI(_ sender: Any) {
        Utils.checkHeartIsEnough(viewController: (UIApplication.shared.keyWindow?.currentViewController())!, numberOfHeartIsNeed: 1, completion: { (isEnough, count) in
            if isEnough {
                let popup = UserPopup1.instanceFromNib(numberOfHeart: count)
                popup.animationType = .upDown
                popup.okAction = {
                    self.delegate?.showChart()
                }
                popup.show()
            }
        }) { (error) in
            
        }
    }
}

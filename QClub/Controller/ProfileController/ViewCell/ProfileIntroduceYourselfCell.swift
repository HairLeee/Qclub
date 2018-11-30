//
//  ProfileIntroduceYourselfCell.swift
//  QClub
//
//  Created by Dream on 9/22/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class ProfileIntroduceYourselfCell: ProfileBaseCell {

    @IBOutlet weak var lbOutsideLook: UILabel!
    @IBOutlet weak var lbBody: UILabel!
    @IBOutlet weak var lbInholiday: UILabel!
    @IBOutlet weak var lbLookfor: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(member:Member){
        if let words = member.words {
            lbOutsideLook.text = words
        }
        if let appearance = member.appearance {
            lbBody.text = appearance
        }
        if let inHoliday = member.inHoliday {
            lbInholiday.text = inHoliday
        }
        if let lookFor = member.lookFor {
            lbLookfor.text = lookFor
        }
        
    }

}

//
//  ProfileMyInfoCell.swift
//  QClub
//
//  Created by Dream on 9/22/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class ProfileMyInfoCell: ProfileBaseCell {
    
    var member: Member?

    @IBOutlet weak var lbIntroduce: UILabel!
    @IBOutlet weak var lbBody: UILabel!
    @IBOutlet weak var lbStyle: UILabel!
    @IBOutlet weak var lbJob: UILabel!
    @IBOutlet weak var lbReligion: UILabel!
    @IBOutlet weak var lbDrinkAndSmoke: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(member:Member){
        self.member = member
    
        lbIntroduce.text = member.locationName + "에 사는 " + member.birthYear + "년생 " + member.gender + " " + (member.maritalStatus) + "이고, 혈액형은 " + member.bloodName + "입니다."
        lbBody.text = "키는 " + "\(member.height)" + "cm 이고, " + member.bodyName + " 체형입니다."
        lbStyle.text = member.userStyles + " 스타일입니다."
        lbJob.text = member.affiliatedSchool + "에서 공부했고, " +  member.affiliatedCompany + "의 " + member.job  + "입니다."
        lbReligion.text = member.relegionName + " 입니다."
        member.drinkingName = member.drinkingName.replacingOccurrences(of: "심", with: "시")
        lbDrinkAndSmoke.text = "술은 " + member.drinkingName + "고, " + member.smokingName + "자입니다."
    }
    
}


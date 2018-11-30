//
//  ProfileMoreInfoCell.swift
//  QClub
//
//  Created by Dream on 9/22/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class ProfileMoreInfoCell: ProfileBaseCell {
    
    @IBOutlet weak var lbIncome: UILabel!
    @IBOutlet weak var lbCar: UILabel!
    @IBOutlet weak var lbPersonality: UILabel!
    @IBOutlet weak var lbHobby: UILabel!
    @IBOutlet weak var lbTravel: UILabel!
    @IBOutlet weak var lbWish: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setData(member:Member){
        
        if member.propertyFlag == "Y" {
            lbIncome.text = "연 소득 \(member.annualIncome.toStringWithComma())만원이고"
        } else {
            lbIncome.text = "연 소득 \(member.annualIncome.toStringWithComma())만원이고"
        }
        
        if member.carFlag == "Y" {
            if let carModel = member.carModel {
                lbCar.text = "\(carModel)가 저의 애마입니다."
            }
        } else {
            lbCar.text = "자동차는 없습니다."
        }
        
        if let personality = member.personality {
            lbPersonality.text = personality
        }
        if let hobby = member.hobby {
            lbHobby.text = hobby
        }
        if let travel = member.travel {
            lbTravel.text = travel
        }
        if let wish = member.wishes {
            lbWish.text = wish
        }
        
    }
    
}

//
//  MyInfoMainMidTableViewCell.swift
//  QClub
//
//  Created by Dreamup on 10/25/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

protocol GoToAnotherScreenFromCell {
    func goToAnotherScreenFromCell(nameOfScreen:String)
}

class MyInfoMainMidTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lbAboutMe: UILabel!
    @IBOutlet weak var lbAboutBody: UILabel!
    @IBOutlet weak var lbStyle: UILabel!
    @IBOutlet weak var lbJob: UILabel!
    @IBOutlet weak var lbReligion: UILabel!
    @IBOutlet weak var lbDrinkAndSmoke: UILabel!
    @IBOutlet weak var lbIncome: UILabel!
    @IBOutlet weak var lbCar: UILabel!
    @IBOutlet weak var lbCharacter: UILabel!
    
    @IBOutlet weak var lbHobby: UILabel!
   
    @IBOutlet weak var lbAttractions: UILabel!
 
    @IBOutlet weak var lbWish: UILabel!
    
    
    @IBOutlet weak var lbExpression: UILabel!
    
    @IBOutlet weak var lbAppearanceFeatures: UILabel!
    
    
    @IBOutlet weak var lbHoliday: UILabel!
    
    @IBOutlet weak var lbWorkingFor: UILabel!
    
    @IBOutlet weak var lbCandy: NSLayoutConstraint!
    
    @IBOutlet weak var lbCandyNum: UILabel!
    
    var start:GoToAnotherScreenFromCell?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func bidingData(member:Member){
        
        
        lbAboutMe.text = member.locationName + "에 사는 " + member.birthYear + "년생 " + member.gender + member.maritalStatus + "이고, 혈액형은 " + member.bloodName + "입니다."
        lbAboutBody.text = "키는 " + "\(member.height) " + "cm이고, " + member.bodyName + "체형입니다."
        lbStyle.text = member.userStyles + " 스타일입니다."
        lbJob.text = "출신" + member.affiliatedSchool + "나왔고," + member.affiliatedCompany + "의" + member.job + "입니다."
        lbReligion.text = member.relegionName + "입니다."
        lbDrinkAndSmoke.text = "술은" + member.drinkingName + "이고," + member.smokingName + "자입니다."
        

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
            lbCar.text = member.carFlag
        }

        if let personality = member.personality {
            lbCharacter.text = personality
        }
        if let hobby = member.hobby {
            lbHobby.text = hobby
        }
        
        if let travel = member.travel {
            lbHoliday.text = travel
        }
        if let wish = member.wishes {
            lbWish.text = wish
        }
  
        
        
        if let words = member.words {
            lbExpression.text = words
        }
        if let appearance = member.appearance {
            lbAppearanceFeatures.text = appearance
        }
        if let inHoliday = member.inHoliday {
            lbHoliday.text = inHoliday
        }
        if let lookFor = member.lookFor {
            lbWorkingFor.text = lookFor
        }
     
    
   
        lbAttractions.text = member.travel

  
    }
    
    
    @IBAction func btnMyInfoModify1(_ sender: Any) {
        start?.goToAnotherScreenFromCell(nameOfScreen: "MyInfoModifyOneViewController")
        
    }
    
    
    @IBAction func btnMyInfoModify2(_ sender: Any) {
        
        start?.goToAnotherScreenFromCell(nameOfScreen: "MyinfoModifyTwoViewController")
        
    }
    
    
    @IBOutlet weak var btnMyInfoModify3: UIButton!
    
    @IBAction func btnMyInfoModify3(_ sender: Any) {
        start?.goToAnotherScreenFromCell(nameOfScreen: "MyinfoModifyThreeViewController")
        
    }
    
}

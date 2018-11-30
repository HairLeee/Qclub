//
//  BottomCell.swift
//  QClub
//
//  Created by Dreamup on 10/10/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit


protocol OnClickListener {
    func clickOkAction()
}

class BottomCellModify2: UITableViewCell {
    
    
    @IBOutlet weak var tfCharacter: UITextView!
    
    @IBOutlet weak var tfHabit: UITextView!
    
    
    
    
    
    @IBOutlet weak var tfThePlacesThatYouHaveArrived: UITextView!
    var delegate:protocolTextFieldChang?
    
    @IBOutlet weak var tfYourHope: UITextView!
    
    var OnOkClickListener:OnClickListener?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tfCharacter.delegate = self
        tfHabit.delegate = self
        tfThePlacesThatYouHaveArrived.delegate = self
        tfYourHope.delegate = self
           btnOkOutlet.isEnabled = false
    }
    
    
    @IBAction func btnOkAction(_ sender: Any) {
        OnOkClickListener?.clickOkAction()
    }
    
    
    @IBOutlet var btnOkOutlet: UIButton!
    func bidingData(pMember:Member){
        
//        tfCharacter.text = pMember.personality
//        tfHabit.text = pMember.personality
//        tfThePlacesThatYouHaveArrived.text = pMember.affiliatedCompany
//
//        tfYourHope.text = pMember.wishes
//
    }
    
    
    
    func checkValidate(pMember:Modify2){
        
        
        if checkValidate(String(pMember.annualIncome)) && checkValidate(pMember.carFlag)  && checkValidate(pMember.carModel) && checkValidate(pMember.hobby) && checkValidate(pMember.personality) && checkValidate(pMember.propertyFlag) && checkValidate(pMember.travel) {
            
            btnOkOutlet.layer.cornerRadius = 22.5
             btnOkOutlet.layer.borderWidth = 1
             btnOkOutlet.layer.borderColor = UIColor.orange.cgColor
             btnOkOutlet.setTitleColor(UIColor.orange, for: .normal)
            btnOkOutlet.isEnabled = true
            
        } else {
            btnOkOutlet.layer.cornerRadius = 22.5
            btnOkOutlet.layer.borderWidth = 1
            btnOkOutlet.layer.borderColor = UIColor.gray.cgColor
             btnOkOutlet.setTitleColor(UIColor.gray, for: .normal)
             btnOkOutlet.isEnabled = false
        }
        
        
        
    }
    
    func checkValidate(_ text:String) -> Bool{
        
        if  text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0 {
            
            
            return false
        }
          return true
    }
    
}
extension BottomCellModify2: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        switch textView {
        case tfCharacter:
            delegate?.whenActionChange(typeOfTextField: 4, contentOfTextField: tfCharacter.text!)
        case tfHabit:
            delegate?.whenActionChange(typeOfTextField: 5, contentOfTextField: tfHabit.text!)
        case tfThePlacesThatYouHaveArrived:
            delegate?.whenActionChange(typeOfTextField: 6, contentOfTextField: tfThePlacesThatYouHaveArrived.text!)
        case tfYourHope:
            delegate?.whenActionChange(typeOfTextField: 7, contentOfTextField: tfYourHope.text!)
        default:
            break
        }
    }
}

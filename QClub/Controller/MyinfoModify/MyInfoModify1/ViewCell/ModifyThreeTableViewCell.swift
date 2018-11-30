//
//  ModifyThreeTableViewCell.swift
//  QClub
//
//  Created by Dreamup on 10/25/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import IQDropDownTextField
class ModifyThreeTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet var tfReligion: IQDropDownTextField!
    
    
    @IBOutlet var tfDrink: IQDropDownTextField!
    
    
    @IBOutlet var tfSmokeOrNot: IQDropDownTextField!
    
    @IBOutlet var btnOkOutlet: UIButton!
    
    @IBOutlet var viewObtion: UIView!
    
    var delegate:protocolTextFieldChang?
    
    var religions = ["기독교","천주교","불교","무교","기타"]
    var drinks = ["전혀 안마심" , "어쩔 수 없을 때만 마심" , "가끔 마심" , "즐기는 정도" , "자주 마심"]
    var smokes = ["흡연" , "비흡연"]
    
    var marialStatus = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        configDropDownTextField()
        viewObtion.isHidden = true
 
    }
    
    func configDropDownTextField() {
        tfReligion.isOptionalDropDown = true
        tfReligion.itemList = religions
        tfReligion.delegate = self
        
        tfDrink.isOptionalDropDown = true
        tfDrink.itemList = drinks
        tfDrink.delegate = self
        
        tfSmokeOrNot.isOptionalDropDown = true
        tfSmokeOrNot.itemList = smokes
        tfSmokeOrNot.delegate = self
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func btnAccept(_ sender: Any) {
 
        delegate?.whenActionChange(typeOfTextField: 12, contentOfTextField: "S")
        viewObtion.isHidden = false
    }
    
    
    @IBAction func btnNotAccept(_ sender: Any) {
        viewObtion.isHidden = true
        delegate?.whenActionChange(typeOfTextField: 13, contentOfTextField: "R")
        
    }
    
    @IBAction func matchingTarget(_ sender: Any) {
        
          delegate?.whenActionChange(typeOfTextField: 14, contentOfTextField: "Y")
        
    }
    
    
    @IBAction func matchingTargetNo(_ sender: Any) {
        
         delegate?.whenActionChange(typeOfTextField: 15, contentOfTextField: "N")
        
    }
    
    
    
    @IBOutlet var nameOfCompany: TextfieldQClub!
    
    @IBOutlet var nameOfColleage: TextfieldQClub!
    
    @IBAction func nameOfColleage(_ sender: Any) {
        
        delegate?.whenActionChange(typeOfTextField: 8, contentOfTextField: nameOfColleage.text!)
        
    }
    
    @IBAction func nameOfCompany(_ sender: Any) {
        
        delegate?.whenActionChange(typeOfTextField: 9, contentOfTextField: nameOfCompany.text!)
        
    }
    
    @IBOutlet var nameOfJob: TextfieldQClub!
    @IBAction func nameOfJob(_ sender: Any) {
        
        delegate?.whenActionChange(typeOfTextField: 10, contentOfTextField: nameOfJob.text!)
        
    }
    
    
    
    func enableOkButtonOrNot(isEnable:Bool){
        
        if isEnable {
            
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
    
    @IBAction func btnOkAction(_ sender: Any) {
        
          self.delegate?.whenActionChange(typeOfTextField: 100, contentOfTextField: "")
        
    }

}

extension ModifyThreeTableViewCell : IQDropDownTextFieldDelegate {
    func textField(_ textField: IQDropDownTextField, didSelectItem item: String?) {
        
        switch textField {
        case tfReligion:
            
//            delegate?.whenActionChange(typeOfTextField: 10, contentOfTextField: item!)
            
            if let index = religions.index(of: item!) {
                self.delegate?.whenActionChange(typeOfTextField: 11, contentOfTextField: String(index))
            }
            
        case tfDrink:
            if let index = drinks.index(of: item!) {
                self.delegate?.whenActionChange(typeOfTextField: 16, contentOfTextField: String(index))
            }
       
        case tfSmokeOrNot:
            if let index = smokes.index(of: item!) {
                self.delegate?.whenActionChange(typeOfTextField: 17, contentOfTextField: String(index))
            }
            
        default:
            break
        }
        
        
        
    }
}

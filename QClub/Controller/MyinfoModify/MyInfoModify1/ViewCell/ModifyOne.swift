//
//  ModifyOne.swift
//  QClub
//
//  Created by Dreamup on 10/25/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import IQDropDownTextField
class ModifyOne: UITableViewCell {
    
    @IBOutlet weak var tfNickName: TextfieldQClub!
    @IBOutlet weak var tfGender: TextfieldQClub!
    @IBOutlet var tfArea: IQDropDownTextField!
    @IBOutlet var tfBloodType: IQDropDownTextField!
    @IBOutlet var heightOutlet: TextfieldQClub!
    @IBOutlet var tfNormolBloodType: TextfieldQClub!
    @IBOutlet var tfNormalArea: TextfieldQClub!
    @IBOutlet var tfBody: IQDropDownTextField!
    
    var areas = ["서울","경기북부","경기남부","인천","대구","경북","부산","경남","대전","충북","충남","강원","광주","전주","전북","전남","제주", "일본", "중국", "동남아", "미국동부", "미국서부", "미국중부", "기타"]
    
    var typeOfBloods = ["A형" , "O형" , "B형" , "AB형"]
    
    var bodies = ["매우 마른", "조금 마른", "보통", "슬림 탄탄한", "글래머러스한", "잔근육질", "우람 근육질", "조금 통통한", "통통한"]
    
    var viewModel = Join1ViewModel()
    
    var delegate:protocolTextFieldChang?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configDropDownTextField()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heightOutlet.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func tfNickNameEndAction(_ sender: Any) {
        self.delegate?.whenActionChange(typeOfTextField: 1, contentOfTextField: tfNickName.text!)
    }
    
    
    @IBAction func tfNickNameAction(_ sender: Any) {
        
        
    }
    
    
    @IBAction func tfGenderEnd(_ sender: Any) {
        
         self.delegate?.whenActionChange(typeOfTextField: 2, contentOfTextField: tfGender.text!)
    }
    @IBAction func tfGender(_ sender: Any) {
        
        
    }
    
    func configDropDownTextField() {
        tfArea.isOptionalDropDown = true
        tfArea.itemList = areas
        tfArea.delegate = self
        
        tfBloodType.isOptionalDropDown = true
        tfBloodType.itemList = typeOfBloods
        tfBloodType.delegate = self
        
        tfBody.isOptionalDropDown = true
        tfBody.itemList = bodies
        tfBody.delegate = self
        
    }
    
    
    @IBAction func tfAreaNormalChange(_ sender: Any) {
        
        self.delegate?.whenActionChange(typeOfTextField: 4, contentOfTextField: tfNormalArea.text!)
        
    }
    
    
    @IBAction func heightChange(_ sender: Any) {
        
        self.delegate?.whenActionChange(typeOfTextField: 6, contentOfTextField: heightOutlet.text!)
    }
    
    
}

extension ModifyOne : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == heightOutlet {
            let textFieldText: NSString = (textField.text ?? "") as NSString
            return textFieldText.replacingCharacters(in: range, with: string).count < 4
        }
        return true
    }
}

extension ModifyOne : IQDropDownTextFieldDelegate {
    func textField(_ textField: IQDropDownTextField, didSelectItem item: String?) {
        
        switch textField {
        case tfArea:
            if item == "기타" {
                tfArea.textColor = UIColor.white
                tfNormalArea.superview?.bringSubview(toFront: tfNormalArea)
            } else {
                tfArea.textColor = UIColor.black
                tfNormalArea.text = ""
                tfNormalArea.superview?.sendSubview(toBack: tfNormalArea)
                
                if let index = areas.index(of: item!) {
                    self.delegate?.whenActionChange(typeOfTextField: 3, contentOfTextField: String(index))
                }
         
            }
            
        case tfBloodType:
            
            if item == "기타" {
                tfBloodType.textColor = UIColor.white
                tfNormolBloodType.superview?.bringSubview(toFront: tfNormolBloodType)
            } else {
                tfBloodType.textColor = UIColor.black
                tfNormolBloodType.text = ""
                tfNormolBloodType.superview?.sendSubview(toBack: tfNormolBloodType)
                
               if let index = typeOfBloods.index(of: item!){
                        self.delegate?.whenActionChange(typeOfTextField: 5, contentOfTextField: String(index))
                }
                
            
                
            }
   
        case tfBody:
            if let index = bodies.index(of: item!) {
                self.delegate?.whenActionChange(typeOfTextField: 7, contentOfTextField: String(index))
            }
            

        default:
            break
        }
        
        
        
    }
}






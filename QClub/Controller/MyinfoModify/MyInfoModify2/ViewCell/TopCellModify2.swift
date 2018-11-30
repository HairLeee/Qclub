//
//  TopCell.swift
//  QClub
//
//  Created by Dreamup on 10/10/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import IQDropDownTextField


class TopCellModify2: UITableViewCell {
    
    var delegate:protocolTextFieldChang?
    
    @IBOutlet weak var tfIncomOfYear: TextfieldQClub!
    
    @IBOutlet weak var tfHasCarsOrNot: IQDropDownTextField!
    
    @IBOutlet weak var tfNameOfTheCars: IQDropDownTextField!
    
    var grounds = ["소유", "미 소유"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tfHasCarsOrNot.isOptionalDropDown = true
        tfHasCarsOrNot.delegate =  self
        tfHasCarsOrNot.itemList = grounds
        
        tfNameOfTheCars.isOptionalDropDown = true
        tfNameOfTheCars.delegate =  self
        tfNameOfTheCars.itemList = grounds
        
    }
    
    func getData(){
        
        print("getData From Modify 2 ~~")
    }
    
    func bidingData(pMember:Member){
//        tfIncomOfYear.text = String(pMember.annualIncome)
//
//       tfHasCarsOrNot.text = String(pMember.carFlag)
//
//         tfNameOfTheCars.text = String(pMember.propertyFlag)
      
    }
    
    
    
    @IBAction func tfIncomYearChange(_ sender: Any) {
        
        delegate?.whenActionChange(typeOfTextField: 1, contentOfTextField: tfIncomOfYear.text!)
        
    }
    
    
    @IBAction func tfHasCarsOrNotChange(_ sender: Any) {
        
//        delegate?.whenActionChange(typeOfTextField: 2, contentOfTextField: tfHasCarsOrNot.text!)
    }
    
    
    @IBAction func tfNameOfTheCarsChange(_ sender: Any) {
        
//        delegate?.whenActionChange(typeOfTextField: 3, contentOfTextField: tfNameOfTheCars.text!)
        
    }
    
    
    
    
    
    
    @IBAction func tfInComeYearDidEnd(_ sender: Any) {
        
        
    }
    
    
    
}

extension TopCellModify2 : IQDropDownTextFieldDelegate {
    func textField(_ textField: IQDropDownTextField, didSelectItem item: String?) {
        var pItem = "Y"
        if item == "소유" {
           pItem = "Y"
        } else {
            pItem = "N"
        }
        
        
        switch textField {
        case tfHasCarsOrNot:
            
           
            
            delegate?.whenActionChange(typeOfTextField: 2, contentOfTextField: pItem)
        case tfNameOfTheCars:
            
             delegate?.whenActionChange(typeOfTextField: 3, contentOfTextField: pItem)
        default:
            break
        }
        
        
        
    }
}

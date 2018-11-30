//
//  BottomCellModify3.swift
//  QClub
//
//  Created by Dreamup on 10/11/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

protocol OnButtonClickListener {
    func OnButtonClickListener()
}






class BottomCellModify3: UITableViewCell {
    
    @IBOutlet weak var tv1: UITextView!
    
    var onButtomClickListener:OnButtonClickListener?
    
    @IBOutlet weak var tfWords: UITextView!
    
    @IBOutlet weak var tfAppearance: UITextView!
    
    
    @IBOutlet weak var tfHoliday: UITextView!
    
    @IBOutlet weak var tfLookFor: UITextView!
    
    @IBOutlet var btnOkOutlet: UIButton!
    var delegate:protocolTextFieldChang?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tfWords.delegate = self
        tfAppearance.delegate = self
        tfHoliday.delegate = self
        tfLookFor.delegate = self
            btnOkOutlet.isEnabled = false
        
        
        
    }
    func  bidingData ()  {
        
        
        
    }
    
    
    
    
    
    @IBAction func btnOkAction(_ sender: Any) {
        
           onButtomClickListener?.OnButtonClickListener()
        
        
    }
    
    
    func isTfEmptyOrNot(_ textView:UITextView) -> Bool {
        
        if textView.text.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0 {
            
            return false
        }
        
        return true
    }
    
    
    func checkValidate() {
        if isTfEmptyOrNot(tfWords) &&  isTfEmptyOrNot(tfAppearance) &&  isTfEmptyOrNot(tfHoliday) &&  isTfEmptyOrNot(tfLookFor) {
      
            btnOkOutlet.layer.cornerRadius = 22.5
            btnOkOutlet.layer.borderColor = UIColor.orange.cgColor
            btnOkOutlet.setTitleColor(UIColor.orange, for: .normal)
            btnOkOutlet.isEnabled = true
            
            
        } else {
            btnOkOutlet.layer.cornerRadius = 22.5
            btnOkOutlet.layer.borderColor = UIColor.gray.cgColor
            btnOkOutlet.setTitleColor(UIColor.gray, for: .normal)
            btnOkOutlet.isEnabled = true
            
        }
   
        
    }
    
    
}

extension BottomCellModify3:UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        switch textView {
        case tfWords:
            delegate?.whenActionChange(typeOfTextField: 1, contentOfTextField: tfWords.text)
            checkValidate()
        case tfAppearance:
            delegate?.whenActionChange(typeOfTextField: 2, contentOfTextField: tfAppearance.text)
            checkValidate()
        case tfHoliday:
            delegate?.whenActionChange(typeOfTextField: 3, contentOfTextField: tfHoliday.text)
            checkValidate()
        case tfLookFor:
            delegate?.whenActionChange(typeOfTextField: 4, contentOfTextField: tfLookFor.text)
            checkValidate()
            
        default:
            break
        }
    }
    
}

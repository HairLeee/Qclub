//
//  UserPolicePopup.swift
//  QClub
//
//  Created by SMR on 10/12/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import IQDropDownTextField

class UserPolicePopup: PopupView {
    
    @IBOutlet weak var tfReason: IQDropDownTextField!
    @IBOutlet weak var tfReasonETC: UITextField!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var btnOk: CompleteButton!
    
    var actionSend: ((_ reportDetail: String, _ reportEtc : String, _ selectedItem:Int, _ tfReasonETCChar:String) -> ())?
    
    class func instanceFromNib() -> UserPolicePopup {
        let joinView = UINib(nibName: "UserPolicePopup", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UserPolicePopup
        joinView.popupFrame = CGRect.init(x: 20, y: (SCREEN_HEIGHT - 450)/2 , width: SCREEN_WIDTH - 40, height: 450)
        joinView.isHandleKeyboard = true
        return joinView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tfReason.delegate = self
        textView.delegate = self
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        
        getSourceInfoList()
    }
    
    @IBAction func sendTUI(_ sender: Any) {
        hide()
        if let action = actionSend {
            let reason = (tfReason.selectedRow == 6 ? tfReasonETC.text : tfReason.selectedItem)
            action(reason!,textView.text,tfReason.selectedRow,tfReasonETC.text!)
        }
    }
    
    
    
    func getSourceInfoList() {
        
        AuthService.getMasterData(masterSeq: Constants.MasterCode.ReportReason, completion: { [weak self](response) in
            
            guard let _self = self else{return}
            
            if let data = response.data as? [MasterDataObject] {
                
                _self.tfReason.itemList = data.map{$0.detailName ?? ""}
                
            }
        }) { (error) in
            
        }
    }
    
    func validateCompleteInput() {
        if (tfReason.selectedItem == "기타" && tfReasonETC.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0) || tfReason.selectedItem == nil {
            self.btnOk.changeState(isActive: false)
            return
        }
        if textView.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0 {
            self.btnOk.changeState(isActive: false)
            return
        }
        self.btnOk.changeState(isActive: true)
    }
    
    @IBAction func tfReaspmETCChange(_ sender: Any) {
        
        validateCompleteInput()
        
    }
    
    
    @IBAction func tfReasonETCditChange(_ sender: Any) {
        validateCompleteInput()
    }
    
}

extension UserPolicePopup : IQDropDownTextFieldDelegate {
    func textField(_ textField: IQDropDownTextField, didSelectItem item: String?) {
        if item == "기타" {
            tfReason.textColor = UIColor.white
            tfReasonETC.placeholder = "기타"
            tfReasonETC.superview?.bringSubview(toFront: tfReasonETC)
        } else {
            tfReason.textColor = UIColor.black
            tfReasonETC.text = ""
              tfReasonETC.placeholder = ""
            tfReasonETC.superview?.sendSubview(toBack: tfReasonETC)
        }
        validateCompleteInput()
    }
}

extension UserPolicePopup : UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        validateCompleteInput()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count // for Swift use count(newText)
        return numberOfChars < 200
    }
}

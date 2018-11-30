//
//  SettingPinNewConfirmViewController.swift
//  QClub
//
//  Created by Dreamup on 11/6/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class SettingPinNewConfirmViewController: BaseViewController {
    
    @IBOutlet weak var navigationView: NavigationBarQClub!
    
    
    
    @IBOutlet weak var btnNumber1: UIButton!
    
    
    @IBOutlet weak var tf1: UITextField!
    
    @IBOutlet weak var tf2: UITextField!
    
    @IBOutlet weak var tf3: UITextField!
    
    
    @IBOutlet weak var tf4: UITextField!
    
    
    var positionOfTextFieldFocusing = 1;
    var newSettingPin = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        setupView()
        print("SettingPinNewConfirmViewController")
    }
    
    override func configNavigationBar() {
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
            //            self.dismiss(animated: true, completion: nil)
        }
        navigationView.config(title: "암호 변경", image:"setting_pin_header_icon")
    }
    
    
    func setupView(){
        
        tf1.delegate = self
        tf2.delegate = self
        tf3.delegate = self
        tf4.delegate = self
        
        positionOfTextFieldFocusing = 1
    }
    
    
    
    @IBAction func btnNumber1(_ sender: Any) {
        
        checkTextFieldToInput(numberSelected: 1)
        
    }
    
    
    @IBAction func btnNumber2(_ sender: Any) {
        
        checkTextFieldToInput(numberSelected: 2)
        
    }
    
    
    @IBAction func btnNumber3(_ sender: Any) {
        
        checkTextFieldToInput(numberSelected: 3)
        
    }
    
    
    @IBAction func btnNumber4(_ sender: Any) {
        
        checkTextFieldToInput(numberSelected: 4)
    }
    
    
    
    @IBAction func btnNumber5(_ sender: Any) {
        
        checkTextFieldToInput(numberSelected: 5)
        
        
    }
    
    
    @IBAction func btnNumber6(_ sender: Any) {
        
        checkTextFieldToInput(numberSelected: 6)
    }
    
    
    @IBAction func btnNumber7(_ sender: Any) {
        
        checkTextFieldToInput(numberSelected: 7)
        
    }
    
    
    @IBAction func btnNumber8(_ sender: Any) {
        checkTextFieldToInput(numberSelected: 8)
        
        
    }
    
    
    
    @IBAction func btnNumber9(_ sender: Any) {
        
        checkTextFieldToInput(numberSelected: 9)
    }
    
    
    @IBAction func btnRemove(_ sender: Any) {
        
        
        switch positionOfTextFieldFocusing {
        case 4:
            
            if tf4.text?.count == 1 {
                tf4.text = ""
            } else {
                positionOfTextFieldFocusing = 3
                tf3.text = ""
            }
        case 3:
            
            if tf3.text?.count == 1 {
                tf4.text = ""
            } else {
                positionOfTextFieldFocusing = 2
                tf2.text = ""
            }
        case 2:
            
            if tf2.text?.count == 1 {
                tf4.text = ""
            } else {
                positionOfTextFieldFocusing = 1
                tf1.text = ""
            }
        case 1:
            
            
            tf4.text = ""
            
            
            
        default:
            break
        }
        
        
        
    }
    
    
    func checkTextFieldToInput(numberSelected:Int){
        
        let numberOfKeyboard = String(numberSelected)
        
        switch positionOfTextFieldFocusing {
        case 1:
            tf1.text = numberOfKeyboard
            tf2.becomeFirstResponder()
            positionOfTextFieldFocusing = 2
            view.endEditing(true)
        case 2:
            tf2.text = numberOfKeyboard
            tf3.becomeFirstResponder()
            positionOfTextFieldFocusing = 3
            view.endEditing(true)
        case 3:
            tf3.text = numberOfKeyboard
            tf4.becomeFirstResponder()
            positionOfTextFieldFocusing = 4
            view.endEditing(true)
        case 4:
            tf4.text = numberOfKeyboard
            view.endEditing(true)
            self.showLoading()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.checkPw()
                self.stopLoading()
            })
            
        default:
            break
        }
        
        
    }
    
    var isPassword = false
    func checkPw(){
        
        
        let finalPw = tf1.text! + tf2.text! + tf3.text! + tf4.text!
        

        
        print("Password Input Check getSettingPw === \(finalPw)")
        
        
        
        if  finalPw != newSettingPin {
            
            tf1.text = ""
            tf2.text = ""
            tf3.text = ""
            tf4.text = ""
            tf1.becomeFirstResponder()
            positionOfTextFieldFocusing = 1
            view.endEditing(true)
            
            let dialog = AlertQClub.instanceFromNib(content: "Wrong Password !!!! ", image: "ava")
            dialog.show()
            
        } else {
            Context.setSettingPw(finalPw)
            var VCS = self.navigationController?.viewControllers
//            VCS?.remove(at: (VCS?.count)! - 2)
//            navigationController?.viewControllers = VCS!
//            navigationController?.popViewController(animated: true)
            navigationController?.popToViewController(VCS![2], animated: true)
        }
        
        
    }
    
    
    
    
    
}



extension SettingPinNewConfirmViewController: UITextFieldDelegate {
    
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        case tf1:
            if textField.text?.count == 0 {
                self.tf1.text = string
                self.tf2.becomeFirstResponder()
                positionOfTextFieldFocusing = 2
                return false
            }
        case tf2:
            if textField.text?.count == 0 {
                self.tf2.text = string
                self.tf3.becomeFirstResponder()
                positionOfTextFieldFocusing = 3
                return false
            }
        case tf3:
            if textField.text?.count == 0 {
                self.tf3.text = string
                self.tf4.becomeFirstResponder()
                positionOfTextFieldFocusing = 4
                return false
            }
        case tf4:
            if textField.text?.count == 0 {
                
                print("Finish \(String(describing: textField.text?.count))")
                
                self.tf4.text = string
                //                self.tf4.isUserInteractionEnabled = false
                checkPw()
                
                return false
            }
            
            
        default:
            break
        }
        
        return true
        
        
    }
    
    
    
    
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        
        
        print("~~~~> \(textField.text?.count)")
        
        
        
        
        switch textField {
        case tf1:
            
            if textField.text?.count == 1 {
                
                return true
            }
            
        default:
            break
        }
        
        return true
    }
    
    
}

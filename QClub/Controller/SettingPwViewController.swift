//
//  SettingPwViewController.swift
//  QClub
//
//  Created by Dreamup on 10/2/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class SettingPwViewController: UIViewController {
    
    
    @IBOutlet weak var navigationView: NavigationBarQClub!
    
    
    @IBOutlet var tfEmail: TextfieldQClub!
    
    @IBOutlet var tfOldPw: TextfieldQClub!
    
    @IBOutlet var tfNewPw: TextfieldQClub!
    
    @IBOutlet var tfNewPwAgain: TextfieldQClub!
    
    
    @IBOutlet var lbWarning: UILabel!
    
    @IBOutlet var btnOkOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        getData()
        setupUI()
        
    }
    
    func setupUI(){
        btnOkOutlet.isEnabled = false
        tfOldPw.delegate = self
        tfOldPw.delegate = self
        tfNewPwAgain.delegate = self
        
        
    }
    
    func getData(){
        self.showLoading()
        MenuService.getEmailFromChangingPw(completion: { (response) in
            if let email = response.data as? String {
                self.tfEmail.text = email
            }
            
            self.stopLoading()

        }) { (error) in
            
            self.stopLoading()
        }
        
    }
    
    @IBAction func btnChangePw(_ sender: Any) {
        
        if tfNewPw.text != tfNewPwAgain.text {
            lbWarning.text = "비밀번호가 변경되었습니다."
            return
        }
        
        self.showLoading()
        MenuService.changePw(oldPw: tfOldPw.text!, newPW: tfNewPw.text!, completion: { (response) in
            self.stopLoading()
            if let code = response.code {
                
                if code == 0 {
                
                    
                    let dialog = HoldingPopup.instanceFromNib(content: "비밀번호가 변경되었습니다.", image: "ic_done.png")
                    dialog.show()
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                        dialog.hide()
                        self.lbWarning.text = "비밀번호가 변경되었습니다."
                        self.navigationController?.popViewController(animated: true)
                        
                    }
                    
                    
                } else {
                    self.lbWarning.text = "Wrong Cureent Pw !"
                }
                
            }
            
            
            
        }) { (error) in
            
            self.stopLoading()
            
        }
        
    }
    func configNavigationBar() {
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
            //            self.dismiss(animated: true, completion: nil)
        }
        navigationView.config(title: "기본정보 관리", image: "setting_pw_header_icon")
    }
    
    func checkValidate() -> Bool{
        
        if tfOldPw.text == "" || tfNewPw.text == "" || tfNewPwAgain.text == "" {
            return false
        }
        
        return true
        
    }
    
}

extension SettingPwViewController:UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        
        if !checkValidate() {
            
            btnOkOutlet.layer.cornerRadius = 22.5
            btnOkOutlet.layer.borderColor = UIColor.init(hexString: "#EBEBEB")?.cgColor
            btnOkOutlet.layer.borderWidth = 1
            btnOkOutlet.setTitleColor(UIColor.init(hexString: "#EBEBEB"), for: .normal)
            btnOkOutlet.isEnabled = false
            
            
        } else {
            
            btnOkOutlet.layer.cornerRadius = 22.5
            btnOkOutlet.layer.borderColor = UIColor.init(hexString: "#e68a12")?.cgColor
            btnOkOutlet.layer.borderWidth = 1
            btnOkOutlet.setTitleColor(UIColor.init(hexString: "#e68a12"), for: .normal)
            btnOkOutlet.isEnabled = true
            
        }
        
        
        
    }
    
}


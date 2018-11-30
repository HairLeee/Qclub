//
//  Join2ViewController.swift
//  QClub
//
//  Created by SMR on 10/2/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import IQDropDownTextField

/*
 Join2, Page 9 in StoryBoard
 */

class Join2ViewController: BaseViewController {

    @IBOutlet weak var okBTN: CompleteButton!
    @IBOutlet weak var navigationView: NavigationBarQClub!
    @IBOutlet weak var TFlocal: IQDropDownTextField!
    @IBOutlet weak var TFbloodType: IQDropDownTextField!
    @IBOutlet weak var TFbodyType: IQDropDownTextField!
    @IBOutlet weak var tfLocalInput: UITextField!
    @IBOutlet weak var imageNickNameCheck: UIImageView!
    @IBOutlet weak var tfHeight: TextfieldQClub!
    @IBOutlet weak var tfNickName: TextfieldQClub!
    @IBOutlet weak var lbDuplicationNickname: UILabel!
    
    var viewModel = Join2ViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configDropdownTextField()
        viewModel.getLocationInfoList { (data) in
            self.TFlocal.itemList = data
        }
        viewModel.getBodyInfoList { (data) in
            self.TFbodyType.itemList = data
        }
        viewModel.getBloodInfoList { (data) in
            self.TFbloodType.itemList = data
        }
        tfHeight.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func configNavigationBar() {
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        navigationView.config(title: "회원가입", image: "ic_navigation_join")
    }


    func configDropdownTextField() {
        TFlocal.isOptionalDropDown = true
        TFlocal.delegate = self
        
        TFbloodType.isOptionalDropDown = true
        TFbloodType.delegate = self
        
        TFbodyType.isOptionalDropDown = true
        TFbodyType.delegate = self
        
        tfHeight.addTarget(self, action: #selector(validateCompleteInput), for: .editingChanged)
        tfNickName.addTarget(self, action: #selector(checkDuplicateNickName), for: .editingChanged)
    }

    @IBAction func okTUI(_ sender: Any) {
        let join3  = viewModel.join3VC()
        makeDataForUserObject()
        join3.viewModel.userJoin = viewModel.userJoin
        self.navigationController?.pushViewController(join3, animated: true)
    }
    
    
    @IBAction func tfLocaInputDidEndAction(_ sender: Any) {
        
        validateCompleteInput()
    }
    
    
    @objc func validateCompleteInput() {
        if imageNickNameCheck.isHidden {
            self.okBTN.changeState(isActive: false)
            return
        }
        if (TFlocal.selectedItem == "기타" && tfLocalInput.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0) || TFlocal.selectedItem == nil {
            self.okBTN.changeState(isActive: false)
            return
        }
        if TFbloodType.selectedItem == nil {
            self.okBTN.changeState(isActive: false)
            return
        }
        if tfHeight.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0 {
            self.okBTN.changeState(isActive: false)
            return
        }
        if TFbodyType.selectedItem == nil {
            self.okBTN.changeState(isActive: false)
            return
        }
        self.okBTN.changeState(isActive: true)
    }
    
    @objc func checkDuplicateNickName() {
        if self.tfNickName.text!.count == 0 {
            self.imageNickNameCheck.isHidden = true
            self.lbDuplicationNickname.isHidden = true
            self.validateCompleteInput()
            return
        }
        
        AuthService.checkDuplicateNickName(nickname: self.tfNickName.text!, completion: { (response) in
            if self.tfNickName.text!.count == 0 {
                self.imageNickNameCheck.isHidden = true
                self.lbDuplicationNickname.isHidden = true
            } else {
                if response.code == 0 {
                    self.imageNickNameCheck.isHidden = false
                    self.lbDuplicationNickname.isHidden = true
                } else {
                    self.imageNickNameCheck.isHidden = true
                    self.lbDuplicationNickname.isHidden = false
                }
            }
            self.validateCompleteInput()
        }) { (error) in
            self.validateCompleteInput()
        }
    }
    
    func makeDataForUserObject() {
        viewModel.userJoin?.nickName = tfNickName.text
        viewModel.userJoin?.local = viewModel.locationInfoList[TFlocal.selectedRow].detailSeq
        viewModel.userJoin?.localEtc = tfLocalInput.text
        viewModel.userJoin?.bloodType = viewModel.bloodInfoList[TFbloodType.selectedRow].detailSeq
        viewModel.userJoin?.bodyType = viewModel.bodyInfoList[TFbodyType.selectedRow].detailSeq
        viewModel.userJoin?.height = Int(tfHeight.text!)
    }
}

extension Join2ViewController: IQDropDownTextFieldDelegate {
    func textField(_ textField: IQDropDownTextField, didSelectItem item: String?) {
        if textField == TFlocal {
            if (item?.contains("기타"))! {
                TFlocal.textColor = UIColor.white
                tfLocalInput.superview?.bringSubview(toFront: tfLocalInput)
            } else {
                TFlocal.textColor = UIColor.black
                tfLocalInput.text = ""
                tfLocalInput.superview?.sendSubview(toBack: tfLocalInput)
            }
        }
        validateCompleteInput()
    }
}
extension Join2ViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == tfHeight {
            let textFieldText: NSString = (textField.text ?? "") as NSString
            return textFieldText.replacingCharacters(in: range, with: string).count < 4
        }
        return true
    }
}


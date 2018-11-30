//
//  Join1ViewController.swift
//  QClub
//
//  Created by SMR on 9/29/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import IQDropDownTextField

/*
 Join1, Page 7 in StoryBoard
 */

class Join1ViewController: BaseViewController,JoinVerificationControllerDelegate{


    @IBOutlet weak var viewPrivacy: UIView!
    @IBOutlet weak var navigationView: NavigationBarQClub!
    @IBOutlet weak var TFGender: IQDropDownTextField!
    @IBOutlet weak var TFLastId: IQDropDownTextField!
    @IBOutlet weak var TFbirthDay: UITextField!
    @IBOutlet weak var TFbirthMonth: UITextField!
    @IBOutlet weak var TFbirthYear: UITextField!
    @IBOutlet weak var TFsourceInfo: IQDropDownTextField!
    @IBOutlet weak var TFRecomendId: IQDropDownTextField!
    @IBOutlet weak var viewInScrollview: UIView!
    @IBOutlet weak var tfId: TextfieldQClub!
    @IBOutlet weak var imgCheckId: UIImageView!
    @IBOutlet weak var tfPhone: TextfieldQClub!
    @IBOutlet weak var imgCheckPhone: UIImageView!
    @IBOutlet weak var tfPassword: TextfieldQClub!
    @IBOutlet weak var tfRetypePassword: TextfieldQClub!
    @IBOutlet weak var tfName: TextfieldQClub!
    @IBOutlet weak var tfLastIDInput: UITextField!
    @IBOutlet weak var tfLastIDRecommendInput: UITextField!
    @IBOutlet weak var tfIdRecommend: TextfieldQClub!
    @IBOutlet weak var tfSourceInfoInput: UITextField!
    @IBOutlet weak var okBTn: CompleteButton!
    @IBOutlet weak var selectDateBtn: UIButton!
    @IBOutlet weak var lbWrongPassword: UILabel!
    
    var viewModel = Join1ViewModel()
    var viewPicker : UIView?
    var datePicker: UIDatePicker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
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
    
    func setupUI() {
        configDropDownTextField()
        viewInScrollview.addSubview(viewModel.checkBox(viewPrivacy: viewPrivacy)!)
        tfId.delegate = self
        tfLastIDInput.delegate = self
        tfPhone.delegate = self
        tfName.delegate = self
        tfPassword.delegate = self
        tfRetypePassword.delegate = self
        tfIdRecommend.delegate = self
        
        tfSourceInfoInput.addTarget(self, action: #selector(validateComplete), for: .editingChanged)
        tfPassword.addTarget(self, action: #selector(validateComplete), for: .editingChanged)
        tfPassword.addTarget(self, action: #selector(validatePasswordConfirm), for: .editingChanged)
        tfRetypePassword.addTarget(self, action: #selector(validateComplete), for: .editingChanged)
        tfRetypePassword.addTarget(self, action: #selector(validatePasswordConfirm), for: .editingChanged)
        
        viewModel.getSourceInfoList { (data) in
            self.TFsourceInfo.itemList = data
        }
        
        viewModel.checkBox(viewPrivacy: viewPrivacy)?.valueChanged = { (value) in
            self.validateComplete()
        }
    }
    
    @objc func validatePasswordConfirm() {
        if tfPassword.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) == tfRetypePassword.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) {
            lbWrongPassword.isHidden = true
        } else {
            lbWrongPassword.isHidden = false
        }
    }
    
    func configDropDownTextField() {
        TFGender.isOptionalDropDown = true
        TFGender.itemList = viewModel.genderList()
        TFGender.delegate = self
        
        TFLastId.isOptionalDropDown = true
        TFLastId.itemList = viewModel.emailList()
        TFLastId.delegate = self
        
        TFsourceInfo.isOptionalDropDown = true
        TFsourceInfo.delegate = self
        
        TFRecomendId.isOptionalDropDown = true
        TFRecomendId.itemList = viewModel.emailList()
        TFRecomendId.delegate = self
    }
    
    @IBAction func showSelectDate(_ sender: Any) {
        if let viewPK = self.viewPicker {
            self.view.addSubview(viewPK)
            UIView.animate(withDuration: 0.3) {
                self.datePicker?.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT - 200, width: SCREEN_WIDTH, height: 200)
            }
        } else {
            viewPicker = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
            viewPicker?.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(hideDatePicker)))
            datePicker = UIDatePicker.init(frame: CGRect.init(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: 200))
            datePicker?.backgroundColor = UIColor.init(hexString: "#C9D6DB")
            datePicker?.datePickerMode = .date
            datePicker?.locale = Locale.init(identifier: "ko_KR")
            datePicker?.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
            
            //creat date with 20 years before
            let date = NSDateComponents.init()
            date.year = Calendar.current.component(.year, from: Date()) - 20
            date.month = Calendar.current.component(.month, from: Date())
            date.day = Calendar.current.component(.day, from: Date())
            date.calendar = Calendar.current
            datePicker?.setDate(date.date!, animated: false)
            viewPicker?.addSubview(datePicker!)
            self.view.addSubview(viewPicker!)
            UIView.animate(withDuration: 0.3) {
                self.datePicker?.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT - 200, width: SCREEN_WIDTH, height: 200)
            }
        }
    }
    
    @objc func dateChanged(_ sender: UIDatePicker) {
        let componenets = Calendar.current.dateComponents([.year, .month, .day], from: sender.date)
        if let day = componenets.day, let month = componenets.month, let year = componenets.year {
            TFbirthDay.text = "\(day)"
            viewModel.setBirthday(data: "\(day)")
            
            TFbirthMonth.text = "\(month)"
            viewModel.setBirthmonth(data: "\(month)")
        
            TFbirthYear.text = "\(year)"
            viewModel.setBirthyear(data: "\(year)")
            validateComplete()
        }
    }
    
    @objc func hideDatePicker() {
        UIView.animate(withDuration: 0.3) {
            self.datePicker?.frame = CGRect.init(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: 200)
        }
        self.viewPicker?.removeFromSuperview()
    }
    
    @IBAction func JoinTUI(_ sender: Any) {
        let sb = UIStoryboard(name: "Join", bundle: nil)
        let veriticationVC = sb.instantiateViewController(withIdentifier: "JoinVerificationViewController") as! JoinVerificationViewController
        veriticationVC.delegate = self
        self.navigationController?.pushViewController(veriticationVC, animated: true)
//        didVeritySuccess()
    }
    func didVeritySuccess() {
         self.navigationController?.pushViewController(viewModel.join2VC(tfId: tfId, TFLastId: TFLastId, tfLastIDInput: tfLastIDInput, tfPassword: tfPassword, tfName: tfName, TFGender: TFGender, tfPhone: tfPhone, TFsourceInfo: TFsourceInfo, tfSourceInfoInput: tfSourceInfoInput, tfIdRecommend: tfIdRecommend, TFRecomendId: TFRecomendId, tfLastIDRecommendInput: tfLastIDRecommendInput), animated: true)
    }
    
    
    @IBAction func showAgrementPopup(_ sender: Any) {
        viewModel.showAgrementPopup()
    }
    @IBAction func showPrivacyPopup(_ sender: Any) {
        viewModel.showPrivacyPopup()
    }
    
    
    func findRecommenderById() {
        AuthService.findRecommenderId(id: tfIdRecommend.text! + ((TFRecomendId.selectedItem ?? "") == "직접입력" ? tfLastIDRecommendInput.text : (TFRecomendId.selectedItem ?? ""))!, completion: { (response) in
            
        }) { (error) in
            
        }
    }
    
    @objc func validateComplete() {
        if imgCheckId.isHidden { okBTn.changeState(isActive: false)
            return }
        if imgCheckPhone.isHidden { okBTn.changeState(isActive: false)
            return }
        if !((viewModel.checkBox(viewPrivacy: viewPrivacy)?.isChecked)!) { okBTn.changeState(isActive: false)
            return }
        if (tfPassword.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count)! < 6 { okBTn.changeState(isActive: false)
            return }
        if (tfRetypePassword.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count)! < 6 { okBTn.changeState(isActive: false)
            return }
        if tfRetypePassword.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count != tfPassword.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count { okBTn.changeState(isActive: false)
            return }
        if tfPassword.text! != tfRetypePassword.text! { okBTn.changeState(isActive: false)
            return }
        if tfName.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0 { okBTn.changeState(isActive: false)
            return }
        if (TFsourceInfo.selectedItem == "기타" && tfSourceInfoInput.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0) || TFsourceInfo.selectedItem == nil {
            self.okBTn.changeState(isActive: false)
            return
        }
        
        //check month
        if viewModel.user.birthMonth == nil || viewModel.user.birthMonth?.count == 0{
            return
        }
        
        //check day
        if viewModel.user.birthDay == nil || viewModel.user.birthDay?.count == 0{
            return
        }
        
        //check year
        if viewModel.user.birthYear == nil || viewModel.user.birthYear?.count == 0{
            return
        }
        
        
        okBTn.changeState(isActive: true)
    }
}

extension Join1ViewController : IQDropDownTextFieldDelegate {
    func textField(_ textField: IQDropDownTextField, didSelectItem item: String?) {
        if textField == TFLastId {
            if item == "직접입력" {
                TFLastId.textColor = UIColor.white
                tfLastIDInput.superview?.bringSubview(toFront: tfLastIDInput)
            } else {
                TFLastId.textColor = UIColor.black
                tfLastIDInput.text = "" 
                tfLastIDInput.superview?.sendSubview(toBack: tfLastIDInput)
            }
            viewModel.checkDuplicateId(id: tfId.text!, emailKind: (TFLastId.selectedItem ?? "") == "직접입력" ? tfLastIDInput.text! : (TFLastId.selectedItem ?? ""), tfId: self.tfId, complete: { (isHidden) in
                self.imgCheckId.isHidden = isHidden
            })
        } else if textField == TFRecomendId {
            if item == "직접입력" {
                TFRecomendId.textColor = UIColor.white
                tfLastIDRecommendInput.superview?.bringSubview(toFront: tfLastIDRecommendInput)
            } else {
                TFRecomendId.textColor = UIColor.black
                tfLastIDRecommendInput.text = ""
                tfLastIDRecommendInput.superview?.sendSubview(toBack: tfLastIDRecommendInput)
            }
        } else if textField == TFsourceInfo {
            if item == "기타" {
                TFsourceInfo.textColor = UIColor.white
                tfSourceInfoInput.superview?.bringSubview(toFront: tfSourceInfoInput)
            } else {
                TFsourceInfo.textColor = UIColor.black
                tfSourceInfoInput.text = ""
                tfSourceInfoInput.superview?.sendSubview(toBack: tfSourceInfoInput)
            }
        }
        validateComplete()
    }
}

extension Join1ViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldText: NSString = (textField.text ?? "") as NSString
        
        switch textField {
        case tfId:
            viewModel.checkDuplicateId(id: textFieldText.replacingCharacters(in: range, with: string), emailKind: (TFLastId.selectedItem ?? "") == "직접입력" ? tfLastIDInput.text! : (TFLastId.selectedItem ?? ""), tfId: self.tfId, complete: { (isHidden) in
                self.imgCheckId.isHidden = isHidden
            })
        case tfLastIDInput:
            viewModel.checkDuplicateId(id: tfId.text!, emailKind: textFieldText.replacingCharacters(in: range, with: string), tfId: self.tfId, complete: { (isHidden) in
                self.imgCheckId.isHidden = isHidden
            })
            
        case tfPhone:
            viewModel.checkDuplicateMobile(phone: textFieldText.replacingCharacters(in: range, with: string), tfPhone: self.tfPhone, complete: { (isHidden) in
                self.imgCheckPhone.isHidden = isHidden
            })
            
        default:
            break
        }
        
        validateComplete()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        validateComplete()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case tfId:
            tfPassword.becomeFirstResponder()
//        case tfPassword:
//            tfRetypePassword.becomeFirstResponder()
//        case tfRetypePassword:
//            tfName.becomeFirstResponder()
//        case tfName:
//            TFGender.becomeFirstResponder()
        default:
            break
        }
        return false
    }
}

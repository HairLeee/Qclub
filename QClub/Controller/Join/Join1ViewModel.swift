//
//  Join1ViewModel.swift
//  QClub
//
//  Created by SMR on 11/2/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import IQDropDownTextField

class Join1ViewModel: NSObject {
    var user = UserJoin()
    var privacyCheckBox: Checkbox?
    var sourceList = [MasterDataObject]()
    
    func getUser() -> UserJoin {
        return user
    }
    
    func setBirthday(data: String) {
        user.birthDay = data
    }
    
    func setBirthmonth(data: String) {
        user.birthMonth = data
    }
    
    func setBirthyear(data: String) {
        user.birthYear = data
    }
    
    
    func genderList() -> [String] {
        return ["남","여"]
    }
    
    func emailList() -> [String] {
        return ["naver.com","gmail.com","hanmail.net","nate.com","직접입력"]
    }
    
    func checkBox(viewPrivacy : UIView) -> Checkbox? {
        if let _ = self.privacyCheckBox {
            
        } else {
            privacyCheckBox = Checkbox(frame: CGRect(x: viewPrivacy.frame.origin.x - 20, y: viewPrivacy.frame.origin.y + 2.5 , width: 15, height: 15))
            privacyCheckBox?.borderStyle = .square
            privacyCheckBox?.checkmarkStyle = .tick
            privacyCheckBox?.borderWidth = 1
            privacyCheckBox?.borderColor = UIColor.init(hexString: "#e86a12")
            privacyCheckBox?.checkmarkColor = UIColor.init(hexString: "#e86a12")
            privacyCheckBox?.checkmarkSize = 0.7
            privacyCheckBox?.valueChanged = { (value) in
                
            }
        }
        return privacyCheckBox
    }
    
    func getSourceInfoList(complete: @escaping(_ data: [String]) -> ()) {
        AuthService.getMasterData(masterSeq: Constants.MasterCode.Inflow, completion: { (response) in
            if let data = response.data as? [MasterDataObject] {
                self.sourceList = data
                complete(data.map{$0.detailName ?? ""})
            }
        }) { (error) in
            
        }
    }
    
    func join2VC(tfId: UITextField, TFLastId: IQDropDownTextField, tfLastIDInput: UITextField, tfPassword: UITextField, tfName: UITextField, TFGender: IQDropDownTextField, tfPhone: UITextField, TFsourceInfo: IQDropDownTextField, tfSourceInfoInput: UITextField, tfIdRecommend: UITextField, TFRecomendId: IQDropDownTextField, tfLastIDRecommendInput: UITextField) -> Join2ViewController {
        let join2 = UIStoryboard.init(name: "Join", bundle: nil).instantiateViewController(withIdentifier: "Join2ViewController") as! Join2ViewController
        makeUserJoinObject(tfId: tfId, TFLastId: TFLastId, tfLastIDInput: tfLastIDInput, tfPassword: tfPassword, tfName: tfName, TFGender: TFGender, tfPhone: tfPhone, TFsourceInfo: TFsourceInfo, tfSourceInfoInput: tfSourceInfoInput, tfIdRecommend: tfIdRecommend, TFRecomendId: TFRecomendId, tfLastIDRecommendInput: tfLastIDRecommendInput)
        join2.viewModel.userJoin = self.user
        
        return join2
    }
    
    func makeUserJoinObject(tfId: UITextField, TFLastId: IQDropDownTextField, tfLastIDInput: UITextField, tfPassword: UITextField, tfName: UITextField, TFGender: IQDropDownTextField, tfPhone: UITextField, TFsourceInfo: IQDropDownTextField, tfSourceInfoInput: UITextField, tfIdRecommend: UITextField, TFRecomendId: IQDropDownTextField, tfLastIDRecommendInput: UITextField) {
        user.id = tfId.text! + "@" + (TFLastId.selectedItem! == "직접입력" ? tfLastIDInput.text : TFLastId.selectedItem)!
        user.password = tfPassword.text
        user.name = tfName.text
        user.gender = TFGender.selectedItem == "남" ? "M" : "F"
        user.mobile = tfPhone.text
        user.sourceInfo = self.sourceList[TFsourceInfo.selectedRow].detailSeq
        user.sourceInfoEtc = tfSourceInfoInput.text
        user.recommendId = tfIdRecommend.text! + ((TFRecomendId.selectedItem ?? "") == "직접입력" ? tfLastIDRecommendInput.text! : TFRecomendId.selectedItem ?? "")
    }
    
    func showAgrementPopup() {
        let agrementPopup = JoinAgrementPopup.instanceFromNib()
        agrementPopup.animationType = .upDown
        agrementPopup.show()
    }
    
    func showPrivacyPopup() {
        let privacyPopup = JoinPrivacyPopup.instanceFromNib()
        privacyPopup.animationType = .upDown
        privacyPopup.show()
    }
    
    func checkDuplicateId(id: String, emailKind: String,tfId : UITextField, complete: @escaping(_ isHidden: Bool) -> ()) {
        // id empty, email kind did not select
        if id.count == 0 || emailKind.count == 0 {
            complete(true)
            return
        }
        
        AuthService.checkDuplicateId(id: id + "@" + emailKind, completion: { (response) in
            if tfId.text?.count == 0 {
                complete(true)
            } else {
                if response.code == 0 {
                    complete(false)
                } else {
                     complete(true)
                }
            }
        }) { (error) in
            
        }
    }
    
    func checkDuplicateMobile(phone: String, tfPhone : UITextField, complete: @escaping(_ isHidden: Bool) -> ()) {
        if phone.count == 0 {
            complete(true)
            return
        }
        AuthService.checkDuplicatePhone(phone: phone, completion: { (response) in
            if tfPhone.text?.count == 0 {
                complete(true)
            } else {
                if response.code == 0 {
                    complete(false)
                } else {
                    complete(true)
                }
            }
        }) { (error) in
            
        }
    }
}

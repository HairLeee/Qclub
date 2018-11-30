//
//  FindPassWordViewController.swift
//  QClub
//
//  Created by SMR on 9/28/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

/*
 Find_pw, Page 19 in StoryBoard
 */

class FindPassWordViewController: BaseViewController {

    @IBOutlet weak var tfPhone: TextfieldQClub!
    @IBOutlet weak var tfName: TextfieldQClub!
    @IBOutlet weak var tfId: TextfieldQClub!
    @IBOutlet weak var okBTN: CompleteButton!
    @IBOutlet weak var navigationBar: NavigationBarQClub!
    @IBOutlet weak var lbResult: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        tfName.delegate = self
        tfPhone.delegate = self
        tfId.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func configNavigationBar() {
        navigationBar.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        navigationBar.config(title: "비밀번호 찾기", image: "ic_navigation_password")
    }

    
    @IBAction func findPasswordTUI(_ sender: Any) {
        self.lbResult.text = ""
        self.showLoading()
        AuthService.findPassword(tfId.text!, name: tfName.text!, mobile: tfPhone.text!, completion: { (serverResponse) in
            self.stopLoading()
            if serverResponse.code == 720 {
                self.view.makeToast("일치하는 계정이 없습니다", duration: 2.0, position: .center)
            } else {
                self.view.makeToast("이메일로 임시 비밀번호가 전송되었습니다", duration: 2.0, position: .center)
            }
        }) { (error) in
            self.stopLoading()
        }
    }
    

}

extension FindPassWordViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldText: NSString = (textField.text ?? "") as NSString
        var nameString = "", phoneString = "", idString = ""
        if textField == tfName {
            nameString = textFieldText.replacingCharacters(in: range, with: string)
            phoneString = tfPhone.text!
            idString = tfId.text!
        } else if textField == tfPhone {
            phoneString = textFieldText.replacingCharacters(in: range, with: string)
            nameString = tfName.text!
            idString = tfId.text!
        } else if textField == tfId {
            idString = textFieldText.replacingCharacters(in: range, with: string)
            nameString = tfName.text!
            phoneString = tfPhone.text!
        }
        okBTN.changeState(isActive: nameString.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 && phoneString.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 && idString.trimmingCharacters(in: .whitespacesAndNewlines).count > 0)
        return true
    }
}

//
//  FindIDViewController.swift
//  QClub
//
//  Created by SMR on 9/28/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import Toast_Swift

/*
 Find_id, Page 18 in StoryBoard
 */

class FindIDViewController: BaseViewController {

    @IBOutlet weak var okBTN: CompleteButton!
    @IBOutlet weak var lbResult: UILabel!
    @IBOutlet weak var TFname: TextfieldQClub!
    @IBOutlet weak var TFphone: TextfieldQClub!
    @IBOutlet weak var navigationView: NavigationBarQClub!
    override func viewDidLoad() {
        super.viewDidLoad()
        TFname.delegate = self
        TFphone.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func configNavigationBar() {
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        navigationView.config(title: "아이디 찾기", image: "ic_navigation_find")
    }

    @IBAction func findID(_ sender: Any) {
        self.lbResult.text = ""
        self.showLoading()
        AuthService.findId(TFname.text!, mobile: TFphone.text!, completion: { (serverResponse) in
            self.stopLoading()
            if serverResponse.code == 720 {
                self.view.makeToast("일치하는 계정이 없습니다", duration: 2.0, position: .center)
            } else {
                if let id = serverResponse.data as? String {
                    self.lbResult.text = id
                }
            }
        }) { (error) in
            self.stopLoading()
        }
    }
    
}

extension FindIDViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldText: NSString = (textField.text ?? "") as NSString
        var nameString, phoneString : String
        if textField == TFname {
            nameString = textFieldText.replacingCharacters(in: range, with: string)
            phoneString = TFphone.text!
        } else {
            phoneString = textFieldText.replacingCharacters(in: range, with: string)
            nameString = TFname.text!
        }
        okBTN.changeState(isActive: nameString.trimmingCharacters(in: .whitespacesAndNewlines).count > 0 && phoneString.trimmingCharacters(in: .whitespacesAndNewlines).count > 0)
        return true
    }
}

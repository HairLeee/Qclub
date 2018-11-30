//
//  LoginViewController.swift
//  QClub
//
//  Created by SMR on 9/28/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

/*
 Login, Page 6 in StoryBoard
*/
class LoginViewController: UIViewController {

    @IBOutlet weak var TFUsername: UITextField!
    @IBOutlet weak var TFPassword: UITextField!
    var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        TFUsername.delegate = self
        TFPassword.delegate = self
        TFPassword.keyboardDistanceFromTextField = 70;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func loginTUI(_ sender: Any) {
        self.showLoading()
        AuthService.login(id: TFUsername.text!, password: TFPassword.text!, completion: { (response) in
            self.stopLoading()
            if response.code == 0 {
                Utils.mDelegate().openMainView()
                Utils.connectSendbird()
            } else {
                self.view.makeToast("아이디와 비밀번호를 다시 입력해주세요.", duration: 2, position: .center)
            }
        }) { (error) in
            self.stopLoading()
        }
    }
    
    @IBAction func findIdTUI(_ sender: Any) {
        self.navigationController?.pushViewController(viewModel.findIdVC(), animated: true)
    }
    
    @IBAction func findPasswordTUI(_ sender: Any) {
        self.navigationController?.pushViewController(viewModel.findPasswordVC(), animated: true)
    }
    
    @IBAction func joinTUI(_ sender: Any) {
        self.navigationController?.pushViewController(viewModel.joinVC(), animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == TFUsername {
            TFPassword.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}

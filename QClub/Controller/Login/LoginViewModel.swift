//
//  LoginViewModel.swift
//  QClub
//
//  Created by SMR on 11/2/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class LoginViewModel: NSObject {
    // Return findID ViewController
    func findIdVC() -> UIViewController {
        return UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "FindIDViewController")
    }
    
    // Retrun findPassword ViewControoler
    func findPasswordVC() -> UIViewController {
        return UIStoryboard.init(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "FindPassWordViewController")
        
    }
    
    // Return join VỉewController
    func joinVC() -> UIViewController {
        return UIStoryboard.init(name: "Join", bundle: nil).instantiateViewController(withIdentifier: "Join1ViewController")
    }
    
}

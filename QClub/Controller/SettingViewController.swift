//
//  SettingViewController.swift
//  QClub
//
//  Created by Dreamup on 10/2/17.
//  Copyright © 2017 Dream. All rights reserved.
//
//Page 148 in the Storyboard
import UIKit
import SendBirdSDK

class SettingViewController: BaseViewController {
    
    
    
    @IBOutlet weak var navigationView: NavigationBarQClub!
    
    
    
    
    @IBOutlet weak var btnPw: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        print("SettingViewController")
    }
    
    
    
   override func configNavigationBar() {
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
            //            self.dismiss(animated: true, completion: nil)
        }
        navigationView.config(title: "설정", image: "faq_contact_header_icon")
    }
    
    
    
    @IBAction func btnLogoutAction(_ sender: Any) {
        Context.deleteUserLogin()
        Context.deleteSettingPw()
        
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        
        Utils.mDelegate().openLoginView()

        if let data = SBDMain.getPendingPushToken() {
            SBDMain.unregisterPushToken(data) { (status, error) in
            }
        }
        
    }
    
    
    @IBAction func btnCancelMemberAction(_ sender: Any) {
        
        let dialog = SettingDialog.instanceFromNib()
        
        dialog.show()
        
        
    }
    
}

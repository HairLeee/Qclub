//
//  SettingPinViewController.swift
//  QClub
//
//  Created by Dreamup on 10/3/17.
//  Copyright © 2017 Dream. All rights reserved.
//
//Page 150 in the Storyboard
import UIKit

class SettingPinViewController: UIViewController {
    
    @IBOutlet weak var navigationView: NavigationBarQClub!
    
    
    
    @IBOutlet var btnPinOk: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        print("hailpt SettingPinViewController")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupUI()
    }
    
    func setupUI(){
        
        if Context.getSettingPw() == "" {
            btnPinOutlet.setOn(false, animated: true)
            btnPinOk.layer.borderColor = UIColor.gray.cgColor
            btnPinOk.setTitleColor(UIColor.gray, for: .normal)
            btnPinOk.isEnabled = false
        } else {
            btnPinOk.layer.borderColor = UIColor.orange.cgColor
            btnPinOk.setTitleColor(UIColor.orange, for: .normal)
            btnPinOutlet.setOn(true, animated: true)
            btnPinOk.isEnabled = true
        }
        
    }
    
    
    func configNavigationBar() {
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        navigationView.config(title: "암호 잠금 설정", image:"setting_pin_header_icon")
    }
    
    @IBAction func btnPinAction(_ sender: Any) {
        
        if Context.getSettingPw() != "" {
            Context.setSettingPw("")
            setupUI()
            return
        }
      
        // Make a new one
        let settingPinCurrent = UIStoryboard.init(name: "Setting", bundle: nil).instantiateViewController(withIdentifier: "SettingPinNewViewController")
        
        navigationController?.pushViewController(settingPinCurrent, animated: true)
        
        
    }
    
    
    @IBAction func btnChangePassCode(_ sender: Any) {
        
        
        // Change Pw
        
        let settingPinCurrent = UIStoryboard.init(name: "Setting", bundle: nil).instantiateViewController(withIdentifier: "SettingPinCurrentViewController")
        
        navigationController?.pushViewController(settingPinCurrent, animated: true)
        
        
    }
    
    
    @IBOutlet var btnPinOutlet: UISwitch!
    
    
    
    
}

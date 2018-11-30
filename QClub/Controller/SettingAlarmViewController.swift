//
//  SettingAlarmViewController.swift
//  QClub
//
//  Created by Dreamup on 10/3/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class SettingAlarmViewController: UIViewController {
    
    @IBOutlet weak var navigationView: NavigationBarQClub!
    
    
    
    @IBOutlet var togAllOutlet: UISwitch!
    @IBOutlet var togCardOutlet: UISwitch!
    
    @IBOutlet var togChattingOutlet: UISwitch!
    
    @IBOutlet var togServices: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
    }
    
    func configNavigationBar() {
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
            //            self.dismiss(animated: true, completion: nil)
        }
        navigationView.config(title: "푸시 알람 설정", image:"setting_pw_header_icon")
    }
    
    
    @IBAction func togAllAction(_ sender: Any) {
        
        if togAllOutlet.isOn {
            togCardOutlet.isOn = true
            togChattingOutlet.isOn = true
            togServices.isOn = true
            
            togCardOutlet.isEnabled = true
            togChattingOutlet.isEnabled = true
            togServices.isEnabled = true
            
        } else {
            togCardOutlet.isOn = false
            togChattingOutlet.isOn = false
            togServices.isOn = false
            
            togCardOutlet.isEnabled = false
            togChattingOutlet.isEnabled = false
            togServices.isEnabled = false
            
        }
        
        
    }
    
    
    @IBAction func togCardAction(_ sender: Any) {
        
        
        
    }
    
    
    
    @IBAction func togChatting(_ sender: Any) {
        
    }
    
}



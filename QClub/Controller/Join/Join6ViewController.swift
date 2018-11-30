//
//  Join6ViewController.swift
//  QClub
//
//  Created by SMR on 10/3/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

/*
 Join6, Page 14 in StoryBoard
 */
class Join6ViewController: BaseViewController {
    
    @IBOutlet weak var navigationView: NavigationBarQClub!
    
    override func configNavigationBar() {
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        navigationView.config(title: "신청완료", image: "ic_navigation_join6")
        navigationView.hideBackButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }

    @IBAction func exitApp(_ sender: Any) {
        exit(0)
    }

}

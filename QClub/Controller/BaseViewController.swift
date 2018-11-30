//
//  BaseViewController.swift
//  QClub
//
//  Created by SMR on 10/2/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self as? UIGestureRecognizerDelegate
        //self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        DispatchQueue.main.async(execute: {
            if let window = UIApplication.shared.keyWindow {
                window.windowLevel = UIWindowLevelNormal
            }
        })
        
        print(self.description )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configNavigationBar() {

    }

}

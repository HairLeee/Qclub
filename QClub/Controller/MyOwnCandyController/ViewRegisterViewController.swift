//
//  ViewRegisterViewController.swift
//  QClub
//
//  Created by SMR on 11/3/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

/*
 candy_register Page 61 in StoryBoard
 */

class ViewRegisterViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var registerOkBtn: UIButton!
    var registerOkAction : (() -> ())?
    var registerCancelAction : (() -> ())?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRegisterUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupRegisterUI() {
        textView.placeholder = "나는 어떤 캔디가 되고 싶나요?\n최대 100자 까지 입력가능"
        textView.delegate = self
        textView.text = ""
        registerOkBtn.isUserInteractionEnabled = false
        
        CandyService.getStatus(completion: { (response) in
            if let data = response.data as? CandyStatusModel {
                self.textView.text = data.introduce
            }
        }) { (error) in
            
        }
    }
    
    @IBAction func okRegister(_ sender: Any) {
        candyRegisterAction()
    }
    
    @IBAction func cancelRegister(_ sender: Any) {
        registerCancelAction?()
    }
    
    func candyRegisterAction(){
        self.showLoading()
        CandyService.candyStatusWait(introduce: textView.text, completion: { (response) in
            self.registerOkAction?()
            self.stopLoading()
        }) { (error) in
            self.stopLoading()
        }
    }
    
}

extension ViewRegisterViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView == self.textView {
            registerOkBtn.isUserInteractionEnabled = textView.text.count > 0
        }
    }
}

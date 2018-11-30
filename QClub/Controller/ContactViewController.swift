//
//  ContactViewController.swift
//  QClub
//
//  Created by Dreamup on 10/2/17.
//  Copyright © 2017 Dream. All rights reserved.
//
//Page 145 in the Storyboard
import UIKit
import DLRadioButton

class ContactViewController: UIViewController {
    
    
    
    @IBOutlet var option: DLRadioButton!
    @IBOutlet var tvDescription: UITextView!
    
    @IBOutlet var btnOkOutlet: UIButton!
    var mInPrDetail = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        option.isSelected = true
        tvDescription.delegate = self
         btnOkOutlet.isEnabled = false
    }
    
    @IBAction func btnOkAction(_ sender: Any) {
        
        
        mInPrDetail = (option.selected()?.tag)!
        
        print("mInPrDetail == \(mInPrDetail)")
        
        self.showLoading()
        MenuService.postContact(inPrDetail: mInPrDetail, description: tvDescription.text, completion: { (response) in
            self.stopLoading()
            
            let dialog = HoldingPopup.instanceFromNib(content: "문의가 전송되었습니다. \n빠른 시일내에 답변드리도록 하겠습니다.", image: "ic_profile_letter.png")
            dialog.show()
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                dialog.hide()
                self.navigationController?.popViewController(animated: true)
                
            }
            
            
        }) { (error) in
            self.stopLoading()
        }
        
    }
    
}

extension ContactViewController:UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        
        if tvDescription.text == "" {
            btnOkOutlet.layer.cornerRadius = 22.5
            btnOkOutlet.layer.borderColor = UIColor.gray.cgColor
            btnOkOutlet.layer.borderWidth = 1
            btnOkOutlet.isEnabled = false
            btnOkOutlet.setTitleColor(UIColor.gray, for: .normal)
            
        } else {
            
            btnOkOutlet.layer.cornerRadius = 22.5
            btnOkOutlet.layer.borderColor = UIColor.orange.cgColor
            btnOkOutlet.layer.borderWidth = 1
            btnOkOutlet.isEnabled = true
            btnOkOutlet.setTitleColor(UIColor.orange, for: .normal)
        }
        
        
    }
    
    
    
}

//
//  TextfieldQClub.swift
//  QClub
//
//  Created by SMR on 9/29/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class TextfieldQClub: UITextField, UITextFieldDelegate {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.background = UIImage.init(named: "img_background_textfield")
        self.delegate = self
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.background = UIImage.init(named: "img_background_textfield_active")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.background = UIImage.init(named: "img_background_textfield")
    }

}

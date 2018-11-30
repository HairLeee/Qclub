//
//  BoxView.swift
//  QClub
//
//  Created by TuanNM on 10/25/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import IQDropDownTextField
class BoxView: UIView {

    @IBOutlet weak var textField: IQDropDownTextField!
    @IBOutlet weak var lineHeightConstraint: NSLayoutConstraint!
    
    var callBackAttachImage:(()->Void)?
    var callBackDeleteImage:(()->Void)?
    
    @IBInspectable var placeHolder: String? {
        get {
            return textField.placeholder
        }
        set(value) {
            textField.placeholder = value
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    // MARK: - Private Helper Methods
    
    // Performs the initial setup.
    fileprivate func setupView() {
        let view = viewFromNibForClass()
        view.frame = bounds
        view.autoresizingMask = [
            UIViewAutoresizing.flexibleWidth,
            UIViewAutoresizing.flexibleHeight
        ]
        addSubview(view)
        
        lineHeightConstraint.constant = 0.65
        textField.dropDownMode = .textPicker
        //textField.isOptionalDropDown = false
    }
    
    // Loads a XIB file into a view and returns this view.
    fileprivate func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func setItems(items:[String]){
        textField.itemList = items
    }
    
}


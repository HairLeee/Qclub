//
//  AttachImageView.swift
//  QClub
//
//  Created by TuanNM on 10/24/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class AttachImageView: UIView {

    var callBackAttachImage:(()->Void)?
    var callBackDeleteImage:(()->Void)?
    
    @IBOutlet weak var attachImv: UIImageView!
    @IBOutlet weak var deleteImv: UIImageView!
    
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
        
        let trashGes = UITapGestureRecognizer(target: self, action: #selector(self.didTapDeleteImage))
        deleteImv.isUserInteractionEnabled = true
        deleteImv.addGestureRecognizer(trashGes)
        
        let attachGes = UITapGestureRecognizer(target: self, action: #selector(self.didTapAttachImage))
        attachImv.isUserInteractionEnabled = true
        attachImv.addGestureRecognizer(attachGes)
        
    }
    
    @objc func didTapDeleteImage(){
        attachImv.image = UIImage(named: "ic_attach.png")
        deleteImv.isHidden = true
        callBackDeleteImage?()
    }
    
    @objc func didTapAttachImage() {
        callBackAttachImage?()
    }
    
    // Loads a XIB file into a view and returns this view.
    fileprivate func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func setImage(image:UIImage){
        attachImv.image = image
        deleteImv.isHidden = false
    }
}

//
//  HeartView.swift
//  QClub
//
//  Created by TuanNM on 10/13/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class HeartView: UIViewController {

    var callBackSelect:(()->Void)?
    
    @IBOutlet weak var heartView: UIView!
    @IBOutlet weak var numerHeartLb: UILabel!
    @IBOutlet weak var blueView: UIView!
    
    @IBOutlet weak var headerLb: UILabel!
    @IBOutlet weak var contentLb: UILabel!
    @IBOutlet weak var priceLb: UILabel!
    @IBOutlet weak var buttonContentLb: UILabel!
   
    @IBOutlet weak var popupBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var popupHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var freeImv: UIImageView!
    
    var myHeart = "0"
    var popupTitle = ""
    var popupMessage = ""
    var buttonContent = ""
    var price = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.frame = UIScreen.main.bounds
        
        let font = UIFont(name: "NanumSquareOTF", size: 14)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = 10
        paragraphStyle.alignment = .center
        let attributes = [NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle]
        let attributedText = NSAttributedString(string: popupMessage, attributes: attributes)
        contentLb.attributedText = attributedText
        
        headerLb.text = popupTitle
        priceLb.text = price
        numerHeartLb.text = myHeart
        buttonContentLb.text = buttonContent
        
        heartView.layer.cornerRadius = 15
        heartView.clipsToBounds = true
        heartView.layer.borderColor = UIColor.init(hexString: ORANGE_COLOR)?.cgColor
        heartView.layer.borderWidth = 1
        
        let tapBlueGes = UITapGestureRecognizer(target: self, action: #selector(self.closeAction))
        blueView.isUserInteractionEnabled = true
        blueView.addGestureRecognizer(tapBlueGes)
        
        let tapHeartGes = UITapGestureRecognizer(target: self, action: #selector(self.selectAction))
        heartView.isUserInteractionEnabled = true
        heartView.addGestureRecognizer(tapHeartGes)
        
        popupBottomConstraint.constant = -popupHeightConstraint.constant
        
        freeImv.isHidden = price != "0"
    }

    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.4, animations: {
            self.popupBottomConstraint.constant = 0
            self.view.layoutIfNeeded()
        })
    }
    
    @objc func closeAction() {
        UIView.animate(withDuration: 0.3, animations: {
            self.popupBottomConstraint.constant = -self.popupHeightConstraint.constant
            self.blueView.alpha = 0
            self.view.layoutIfNeeded()
        }, completion:{
            success in
            self.removeFromParentViewController()
            self.view.removeFromSuperview()
        })
        
    }
    
    @objc func selectAction() {
        callBackSelect?()
        self.removeFromParentViewController()
        self.view.removeFromSuperview()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

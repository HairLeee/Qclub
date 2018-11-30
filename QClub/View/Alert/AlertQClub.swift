//
//  AlertQClub.swift
//  QClub
//
//  Created by Dreamup on 10/2/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class AlertQClub: PopupView {

    @IBOutlet weak var imageMain: UIImageView!
    @IBOutlet weak var lbContent: UILabel!
    
    var action1: (() -> ())?
    var action2: (() -> ())?
    
    class func instanceFromNib(content: String, image : String) -> AlertQClub {
        let joinView = UINib(nibName: "AlertQClub", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! AlertQClub
        joinView.lbContent.text = content
        joinView.imageMain.image = UIImage.init(named: image)
        joinView.popupFrame = CGRect.init(x: 20, y: (SCREEN_HEIGHT - 280)/2 , width: SCREEN_WIDTH - 40, height: 280)
        joinView.layer.cornerRadius = 5
        joinView.clipsToBounds = true
        return joinView
        
    }
    
    
    @IBAction func actionNO(_ sender: Any) {
        self.hide()
        if let action = action1 {
            action()
        }
    }
    
    @IBAction func actionYes(_ sender: Any) {
        self.hide()
        if let action = action2 {
            action()
        }
    }
    
}

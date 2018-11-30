//
//  HoldingPopup.swift
//  QClub
//
//  Created by Dreamup on 10/2/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class HoldingPopup: PopupView {
    
    @IBOutlet var imvAva: UIImageView!
    
    
    @IBOutlet var lbTitle: UILabel!
    
    class func instanceFromNib(content: String, image : String) -> HoldingPopup {
        let joinView = UINib(nibName: "HoldingPopup", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! HoldingPopup
        
        joinView.lbTitle.text = content
        joinView.imvAva.image = UIImage.init(named: image)
        joinView.popupFrame = CGRect.init(x: 20, y: (SCREEN_HEIGHT - 250)/2 , width: SCREEN_WIDTH - 40, height: 250)
        joinView.layer.cornerRadius = 5
        joinView.clipsToBounds = true
        return joinView
    }

}

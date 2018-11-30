//
//  JoinPrivacyPopup.swift
//  QClub
//
//  Created by SMR on 9/30/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class JoinPrivacyPopup: PopupView {
    

    @IBOutlet weak var webView: UIWebView!
    
    
    class func instanceFromNib() -> JoinPrivacyPopup {
        let joinView = UINib(nibName: "JoinPrivacyPopup", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! JoinPrivacyPopup
        joinView.popupFrame = CGRect.init(x: 20, y: 20 , width: SCREEN_WIDTH - 40, height: SCREEN_HEIGHT - 40)
        
        let htmlFile = Bundle.main.path(forResource: "privacy", ofType: "html")
        joinView.webView.loadRequest(URLRequest.init(url: URL.init(fileURLWithPath: htmlFile!)))
        
        return joinView
    }

    @IBAction func closeTUI(_ sender: Any) {
        self.hide()
    }
}

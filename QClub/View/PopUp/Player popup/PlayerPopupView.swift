//
//  PlayerPopupView.swift
//  QClub
//
//  Created by TuanNM on 10/13/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit


enum MeetingPopUp{
    case SHORT
    case FULL
}
class PlayerPopupView: UIViewController {

    var callBackSelect:(()->Void)?
    var popupType:MeetingPopUp = .SHORT
    
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var viewRelationShip: UIView!
    @IBOutlet weak var viewSpecial: UIView!
    @IBOutlet weak var infoTf: UITextView!
    @IBOutlet weak var viewShort: UIView!
    
    @IBOutlet weak var avatarBackground: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        
        viewRelationShip.layer.cornerRadius = 15
        viewRelationShip.clipsToBounds = true
        viewRelationShip.layer.borderWidth  = 1
        viewRelationShip.layer.borderColor = UIColor.init(hexString: ORANGE_COLOR)?.cgColor
        
        viewSpecial.layer.cornerRadius = 15
        viewSpecial.clipsToBounds = true
        
        infoTf.layer.borderWidth = 1
        infoTf.layer.borderColor = UIColor.init(hexString: LIGHT_GRAY_COLOR)?.cgColor
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if popupType == .SHORT{
            scrollview.contentSize = CGSize.init(width: scrollview.frame.size.width, height: viewShort.frame.origin.y + viewShort.frame.size.height)
        }else{
            buttonViewContainerHeight.constant = 0
            //            self.view.removeConstraint(specialViewContainerHeight)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var buttonViewContainerHeight: NSLayoutConstraint!
    
    @IBAction func closeAction(_ sender: Any) {
        self.removeFromParentViewController()
        self.view.removeFromSuperview()
    }
    
    @IBAction func selectAction(_ sender: Any) {
        self.removeFromParentViewController()
        self.view.removeFromSuperview()
        callBackSelect?()
    }
    
}

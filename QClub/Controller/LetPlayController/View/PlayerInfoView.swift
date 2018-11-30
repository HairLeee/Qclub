//
//  PlayerInfoView.swift
//  QClub
//
//  Created by TuanNM on 10/12/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

@IBDesignable class PlayerInfoView: UIView {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var userNameLb: UILabel!
    var user : UserMeetingRoom?
    
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
        addSubview(view)

        translatesAutoresizingMaskIntoConstraints = false
        let widthConstraint = NSLayoutConstraint(item: avatar, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: view.frame.width)
        addConstraint(widthConstraint)
    }
    
    // Loads a XIB file into a view and returns this view.
    fileprivate func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func setData(user : UserMeetingRoom, avatarString : String? = nil){
        self.user = user
        userNameLb.text = user.nickName
        
         if let avatarLocal = avatarString {
            avatar.image = UIImage.init(named: avatarLocal)
         }else if let avatarURL = user.profile_picture{
            avatar.kf.setImage(with: URL.init(string: avatarURL))
        }
        
        if user.userSeq == Context.getUserLogin()?.userSeq {
            avatar.layer.cornerRadius = self.frame.width/2
            avatar.clipsToBounds = true
            avatar.layer.borderColor = UIColor.init(hexString: ORANGE_COLOR)?.cgColor
            avatar.layer.borderWidth = 1
        } else {
            avatar.layer.cornerRadius = self.frame.width/2
            avatar.clipsToBounds = true
            avatar.layer.borderWidth = 0
        }

    }
    
    func isHasImage() -> Bool{
        if let _ = self.user {
            return true
        }
        return false
    }
    
    
}

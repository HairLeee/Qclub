//
//  PlayerView.swift
//  QClub
//
//  Created by TuanNM on 10/11/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

@IBDesignable class PlayerView: UIView {

    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var effectImv: UIImageView!
    @IBOutlet weak var stampLeft: UIImageView!
    @IBOutlet weak var stampRight: UIImageView!
    @IBOutlet weak var playerNameLb: UILabel!
    @IBOutlet weak var apeal: UILabel!
    var user : UserMeetingRoom?
    var avatarTouch : ((_ user : PlayerView) -> ())?
    
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
        
        avatar.layer.borderWidth = 1
        avatar.layer.borderColor = UIColor.init(hexString: ORANGE_COLOR)?.cgColor
        
        stampLeft.layer.cornerRadius = stampLeft.frame.width/2
        stampLeft.clipsToBounds = true
        
        stampRight.layer.cornerRadius = stampRight.frame.width/2
        stampRight.clipsToBounds = true
    }
    
    func isSetupData () -> Bool {
        if let _ = self.user {
            return true
        }
        return false
    }
    
    @IBAction func avatarTouch(_ sender: Any) {
        avatarTouch?(self)
    }

    func setData(user : UserMeetingRoom,isLeft:Bool, avatarString: String? = nil){
        self.user = user
        
        if let avatarLocal = avatarString {
            avatar.image = UIImage.init(named: avatarLocal)
        }else if let profilePicture = user.profile_picture{
            avatar.kf.setImage(with: URL.init(string: profilePicture))
        }

        playerNameLb.text = user.nickName ?? ""
        
        if user.userSeq == Context.getUserLogin()?.userSeq {
            apeal.isHidden = true
        } else {
            apeal.text = user.appeal ?? ""
        }

        var qlevel:String = ""
        if let levelStr = user.qlevel?.lowercased(){
            qlevel = levelStr
        }
        let stampMember:[String] = ["stamp_q1.png","stamp_q2.png","stamp_q3.png","stamp_qs.png"]
        

        stampLeft.isHidden = isLeft ? true : false
        stampRight.isHidden = isLeft ? false : true
        
        switch qlevel {
        case "q1":
            stampLeft.image = UIImage(named: stampMember[0])
            stampRight.image = UIImage(named: stampMember[0])
            break
        case "q2":
            stampLeft.image = UIImage(named: stampMember[1])
            stampRight.image = UIImage(named: stampMember[1])
            break
        case "q3":
            stampLeft.image = UIImage(named: stampMember[2])
            stampRight.image = UIImage(named: stampMember[2])
            break
        case "qs":
            stampLeft.image = UIImage(named: stampMember[3])
            stampRight.image = UIImage(named: stampMember[3])
            break
        default:
            stampLeft.isHidden = true
            stampRight.isHidden = true
            break
        }
        
    }
    
    func setupEffectImage() {
        effectImv.isHidden = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatar.layer.cornerRadius = self.frame.width*0.7/2
        avatar.clipsToBounds = true
    }
    
    // Loads a XIB file into a view and returns this view.
    fileprivate func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }

}

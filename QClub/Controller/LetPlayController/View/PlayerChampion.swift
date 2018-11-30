//
//  PlayerChampion.swift
//  QClub
//
//  Created by TuanNM on 10/17/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class PlayerChampion: UIView {
    
    @IBOutlet weak var avatarImv: UIImageView!
    @IBOutlet weak var winView: UIView!
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var addressLb: UILabel!
    @IBOutlet weak var ageLb: UILabel!
    @IBOutlet weak var jobLb: UILabel!
    @IBOutlet weak var heightLb: UILabel!
    @IBOutlet weak var bodyLb: UILabel!
    
    var handleTapOnView: (() -> ())?
    
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapOnView))
        view.isUserInteractionEnabled = true
        view.addGestureRecognizer(tapGesture)
        
        var fontSize:CGFloat = 13
        
        switch UIDevice().screenType {
        case .iPhone4,.iPhones_5_5s_5c_SE:
            fontSize = 11
            break
        default:
            break
        }
        
        let font = UIFont(name: "NanumSquareOTF", size: fontSize)
        nameLb.font = font
        addressLb.font = font
        ageLb.font = font
        jobLb.font = font
        bodyLb.font = font
        heightLb.font = font
        
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 3
        self.clipsToBounds = true
    }
    
    // Loads a XIB file into a view and returns this view.
    fileprivate func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func setData(user:BattleUser){
        
        winView.isHidden = true
        let avatarURL = "http://" + user.profilePicture
        avatarImv.kf.setImage(with: URL(string: avatarURL))
        nameLb.text = user.nickName
        addressLb.text = user.location
        ageLb.text = "\(user.age)세"
        jobLb.text = user.job
        heightLb.text = "\(user.height)cm"
        bodyLb.text = user.body

        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 1
        })
    }
    
    func setWinner(){
        
        winView.isHidden = false
        self.layer.borderColor = UIColor.init(hexString: "ee3553")?.cgColor
        
        UIView.animate(withDuration: 0.2, animations: {
            self.winView.alpha = 0
            self.layer.borderColor = UIColor.clear.cgColor
        }) { (success) in
            UIView.animate(withDuration: 0.2, animations: {
                self.winView.alpha = 1
                self.layer.borderColor = UIColor.init(hexString: "ee3553")?.cgColor
            }) { (success) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.winView.alpha = 0
                    self.layer.borderColor = UIColor.clear.cgColor
                }) { (success) in
                    UIView.animate(withDuration: 0.2, animations: {
                        self.winView.alpha = 0
                        self.layer.borderColor = UIColor.init(hexString: "ee3553")?.cgColor
                    }) { (success) in
                        UIView.animate(withDuration: 0.2, animations: {
                            self.winView.alpha = 0
                            self.layer.borderColor = UIColor.clear.cgColor
                        }) { (success) in
                            self.layer.borderColor = UIColor.init(hexString: "ee3553")?.cgColor
                            self.winView.alpha = 0
                            UIView.animate(withDuration: 0.2, animations: {
                                self.winView.alpha = 0
                                self.layer.borderColor = UIColor.lightGray.cgColor
                            })
                        }
                    }
                }
            }
        }
    }
    
    func setLoser(){
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0
        })
    }
    
    
    @objc func didTapOnView(){
        setWinner()
        handleTapOnView?()
    }
    
}

//
//  PlayerMeeting.swift
//  QClub
//
//  Created by SMR on 11/10/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class PlayerMeeting: UIView {

    var view : UIView!
    @IBOutlet weak var imgArrowL11: UIImageView!
    @IBOutlet weak var imgArrowL12: UIImageView!
    @IBOutlet weak var imgArrowL13: UIImageView!
    
    @IBOutlet weak var imgArrowL21: UIImageView!
    @IBOutlet weak var imgArrowL22: UIImageView!
    @IBOutlet weak var imgArrowL23: UIImageView!
    
    @IBOutlet weak var imgArrowL31: UIImageView!
    @IBOutlet weak var imgArrowL32: UIImageView!
    @IBOutlet weak var imgArrowL33: UIImageView!
    
    @IBOutlet weak var imgArrowR11: UIImageView!
    @IBOutlet weak var imgArrowR12: UIImageView!
    @IBOutlet weak var imgArrowR13: UIImageView!
    
    @IBOutlet weak var imgArrowR21: UIImageView!
    @IBOutlet weak var imgArrowR22: UIImageView!
    @IBOutlet weak var imgArrowR23: UIImageView!
    
    @IBOutlet weak var imgArrowR31: UIImageView!
    @IBOutlet weak var imgArrowR32: UIImageView!
    @IBOutlet weak var imgArrowR33: UIImageView!
    
    
    var destinationFrameL11 : CGRect?
    var destinationFrameL12 : CGRect?
    var destinationFrameL13 : CGRect?
    var destinationFrameL21 : CGRect?
    var destinationFrameL22 : CGRect?
    var destinationFrameL23 : CGRect?
    var destinationFrameL31 : CGRect?
    var destinationFrameL32 : CGRect?
    var destinationFrameL33 : CGRect?
    
    var destinationFrameR11 : CGRect?
    var destinationFrameR12 : CGRect?
    var destinationFrameR13 : CGRect?
    var destinationFrameR21 : CGRect?
    var destinationFrameR22 : CGRect?
    var destinationFrameR23 : CGRect?
    var destinationFrameR31 : CGRect?
    var destinationFrameR32 : CGRect?
    var destinationFrameR33 : CGRect?
    
    @IBOutlet weak var playerL1: PlayerView!
    @IBOutlet weak var playerL2: PlayerView!
    @IBOutlet weak var playerL3: PlayerView!
    @IBOutlet weak var playerR1: PlayerView!
    @IBOutlet weak var playerR2: PlayerView!
    @IBOutlet weak var playerR3: PlayerView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        
        playerL1.tag = 1
        playerL2.tag = 2
        playerL3.tag = 3
        
        playerR1.tag = 4
        playerR2.tag = 5
        playerR3.tag = 6
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetUp()
    }
    
    func xibSetUp() {
        view = loadViewFromNib()
        view.frame = self.bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() ->UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "PlayerMeeting", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
    func configStart() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            self.firstSetupL11()
            self.firstSetupL12()
            self.firstSetupL13()
            self.firstSetupL21()
            self.firstSetupL22()
            self.firstSetupL23()
            self.firstSetupL31()
            self.firstSetupL32()
            self.firstSetupL33()
            self.firstSetupR11()
            self.firstSetupR12()
            self.firstSetupR13()
            self.firstSetupR21()
            self.firstSetupR22()
            self.firstSetupR23()
            self.firstSetupR31()
            self.firstSetupR32()
            self.firstSetupR33()
            
            self.imgArrowL11.isHidden = false
            self.imgArrowL12.isHidden = false
            self.imgArrowL13.isHidden = false
            
            self.imgArrowL21.isHidden = false
            self.imgArrowL22.isHidden = false
            self.imgArrowL23.isHidden = false
            
            self.imgArrowL31.isHidden = false
            self.imgArrowL32.isHidden = false
            self.imgArrowL33.isHidden = false
            
            self.imgArrowR11.isHidden = false
            self.imgArrowR12.isHidden = false
            self.imgArrowR13.isHidden = false
            
            self.imgArrowR21.isHidden = false
            self.imgArrowR22.isHidden = false
            self.imgArrowR23.isHidden = false
            
            self.imgArrowR31.isHidden = false
            self.imgArrowR32.isHidden = false
            self.imgArrowR33.isHidden = false
        }
        
//        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
//
//
//        }
    }
    
    func configForMainMetting() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            self.imgArrowL13.isHidden = false
            self.imgArrowL22.isHidden = false
            self.imgArrowL32.isHidden = false
            
            self.imgArrowR13.isHidden = false
            self.imgArrowR22.isHidden = false
            self.imgArrowR32.isHidden = false
            
           self.firstSetupL13()
           self.firstSetupL22()
           self.firstSetupL32()
           self.firstSetupR13()
           self.firstSetupR22()
           self.firstSetupR32()
            
            self.playerL1.avatar.image = UIImage.init(named: "p1")
            self.playerL1.playerNameLb.text = "ME"
            self.playerL2.avatar.image = UIImage.init(named: "p2")
            self.playerL2.playerNameLb.text = "써니"
            self.playerL3.avatar.image = UIImage.init(named: "p3")
            self.playerL3.playerNameLb.text = "하나"
            self.playerR1.avatar.image = UIImage.init(named: "p4")
            self.playerR1.playerNameLb.text = "혀기"
            self.playerR2.avatar.image = UIImage.init(named: "p5")
            self.playerR2.playerNameLb.text = "환이"
            self.playerR3.avatar.image = UIImage.init(named: "p6")
            self.playerR3.playerNameLb.text = "석"

            
        }

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            UIView.animate(withDuration: 0.3, animations: {
                self.imgArrowL13.frame = self.destinationFrameL13!
                self.imgArrowL22.frame = self.destinationFrameL22!
                self.imgArrowL32.frame = self.destinationFrameL32!
                
                self.imgArrowR13.frame = self.destinationFrameR13!
                self.imgArrowR22.frame = self.destinationFrameR22!
                self.imgArrowR32.frame = self.destinationFrameR32!
            })
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.3) {
            self.playerL2.setupEffectImage()
            self.playerR2.setupEffectImage()
        }
    }

    
    func connectL11() {
        UIView.animate(withDuration: 0.3, animations: {
            self.imgArrowL11.frame = self.destinationFrameL11!
        })
    }
    
    func disconnectL11() {
        if self.imgArrowL11.frame == self.destinationFrameL11 {
            firstSetupL11()
        }
    }
    
    func connectL12() {
        UIView.animate(withDuration: 0.3, animations: {
            self.imgArrowL12.frame = self.destinationFrameL12!
        })
    }
    
    func disconnectL12() {
        if self.imgArrowL12.frame == self.destinationFrameL12 {
            firstSetupL12()
        }
    }
    
    func connectL13() {
        UIView.animate(withDuration: 0.3, animations: {
            self.imgArrowL13.frame = self.destinationFrameL13!
        })
    }
    
    func disconnectL13() {
        if self.imgArrowL13.frame == self.destinationFrameL13 {
            firstSetupL13()
        }
    }
    func connectL21() {
        UIView.animate(withDuration: 0.3, animations: {
            self.imgArrowL21.frame = self.destinationFrameL21!
        })
    }
    func disconnectL21() {
        if self.imgArrowL21.frame == self.destinationFrameL21 {
            firstSetupL21()
        }
    }
    func connectL22() {
        UIView.animate(withDuration: 0.3, animations: {
            self.imgArrowL22.frame = self.destinationFrameL22!
        })
    }
    func disconnectL22() {
        if self.imgArrowL22.frame == self.destinationFrameL22 {
            firstSetupL22()
        }
    }
    func connectL23() {
        UIView.animate(withDuration: 0.3, animations: {
            self.imgArrowL23.frame = self.destinationFrameL23!
        })
    }
    func disconnectL23() {
        if self.imgArrowL23.frame == self.destinationFrameL23 {
            firstSetupL23()
        }
    }
    func connectL31() {
        UIView.animate(withDuration: 0.3, animations: {
            self.imgArrowL31.frame = self.destinationFrameL31!
        })
    }
    func disconnectL31() {
        if self.imgArrowL31.frame == self.destinationFrameL31 {
            firstSetupL31()
        }
    }
    func connectL32() {
        UIView.animate(withDuration: 0.3, animations: {
            self.imgArrowL32.frame = self.destinationFrameL32!
        })
    }
    func disconnectL32() {
        if self.imgArrowL32.frame == self.destinationFrameL32 {
            firstSetupL32()
        }
    }
    func connectL33() {
        UIView.animate(withDuration: 0.3, animations: {
            self.imgArrowL33.frame = self.destinationFrameL33!
        })
    }
    func disconnectL33() {
        if self.imgArrowL33.frame == self.destinationFrameL33 {
            firstSetupL33()
        }
    }
    
    func connectR11() {
        UIView.animate(withDuration: 0.3, animations: {
            self.imgArrowR11.frame = self.destinationFrameR11!
        })
    }
    func disconnectR11() {
        if self.imgArrowR11.frame == self.destinationFrameR11 {
            firstSetupR11()
        }
    }
    func connectR12() {
        UIView.animate(withDuration: 0.3, animations: {
            self.imgArrowR12.frame = self.destinationFrameR12!
        })
    }
    func disconnectR12() {
        if self.imgArrowR12.frame == self.destinationFrameR12 {
            firstSetupR12()
        }
    }
    func connectR13() {
        UIView.animate(withDuration: 0.3, animations: {
            self.imgArrowR13.frame = self.destinationFrameR13!
        })
    }
    func disconnectR13() {
        if self.imgArrowR13.frame == self.destinationFrameR13 {
            firstSetupR13()
        }
    }
    func connectR21() {
        UIView.animate(withDuration: 0.3, animations: {
            self.imgArrowR21.frame = self.destinationFrameR21!
        })
    }
    func disconnectR21() {
        if self.imgArrowR21.frame == self.destinationFrameR21 {
            firstSetupR21()
        }
    }
    func connectR22() {
        UIView.animate(withDuration: 0.3, animations: {
            self.imgArrowR22.frame = self.destinationFrameR22!
        })
    }
    func disconnectR22() {
        if self.imgArrowR22.frame == self.destinationFrameR22 {
            firstSetupR22()
        }
    }
    func connectR23() {
        UIView.animate(withDuration: 0.3, animations: {
            self.imgArrowR23.frame = self.destinationFrameR23!
        })
    }
    func disconnectR23() {
        if self.imgArrowR23.frame == self.destinationFrameR23 {
            firstSetupR23()
        }
    }
    func connectR31() {
        UIView.animate(withDuration: 0.3, animations: {
            self.imgArrowR31.frame = self.destinationFrameR31!
        })
    }
    func disconnectR31() {
        if self.imgArrowR31.frame == self.destinationFrameR31 {
            firstSetupR31()
        }
    }
    func connectR32() {
        UIView.animate(withDuration: 0.3, animations: {
            self.imgArrowR32.frame = self.destinationFrameR32!
        })
    }
    func disconnectR32() {
        if self.imgArrowR32.frame == self.destinationFrameR32 {
            firstSetupR32()
        }
    }
    func connectR33() {
        UIView.animate(withDuration: 0.3, animations: {
            self.imgArrowR33.frame = self.destinationFrameR33!
        })
    }
    func disconnectR33() {
        if self.imgArrowR33.frame == self.destinationFrameR33 {
            firstSetupR33()
        }
    }
    
    
    
    
    func firstSetupL11() {
        var frameL11 = self.imgArrowL11.frame
        self.destinationFrameL11 = frameL11
        frameL11.origin.x -= frameL11.width
        self.imgArrowL11.frame = frameL11
    }
    
    func firstSetupL12() {
        var frameL12 = self.imgArrowL12.frame
        self.destinationFrameL12 = frameL12
        frameL12.origin.x -= frameL12.width
        frameL12.origin.y -= frameL12.height
        self.imgArrowL12.frame = frameL12
    }
    
    func firstSetupL13() {
        var frameL13 = self.imgArrowL13.frame
        self.destinationFrameL13 = frameL13
        frameL13.origin.x -= frameL13.width
        frameL13.origin.y -= frameL13.height
        self.imgArrowL13.frame = frameL13
    }
    
    func firstSetupL21() {
        var frameL21 = self.imgArrowL21.frame
        self.destinationFrameL21 = frameL21
        frameL21.origin.x -= frameL21.width
        frameL21.origin.y += frameL21.height
        self.imgArrowL21.frame = frameL21
    }
    
    func firstSetupL22() {
        var frameL22 = self.imgArrowL22.frame
        self.destinationFrameL22 = frameL22
        frameL22.origin.x -= frameL22.width
        self.imgArrowL22.frame = frameL22
    }
    
    func firstSetupL23() {
        var frameL23 = self.imgArrowL23.frame
        self.destinationFrameL23 = frameL23
        frameL23.origin.x -= frameL23.width
        frameL23.origin.y += frameL23.height
        self.imgArrowL23.frame = frameL23
    }
    
    func firstSetupL31() {
        var frameL31 = self.imgArrowL31.frame
        self.destinationFrameL31 = frameL31
        frameL31.origin.x -= frameL31.width
        frameL31.origin.y += frameL31.height
        self.imgArrowL31.frame = frameL31
    }
    
    func firstSetupL32() {
        var frameL32 = self.imgArrowL32.frame
        self.destinationFrameL32 = frameL32
        frameL32.origin.x -= frameL32.width
        frameL32.origin.y += frameL32.height
        self.imgArrowL32.frame = frameL32
    }
    
    func firstSetupL33() {
        var frameL33 = self.imgArrowL33.frame
        self.destinationFrameL33 = frameL33
        frameL33.origin.x -= frameL33.width
        self.imgArrowL33.frame = frameL33
    }
    
    func firstSetupR11() {
        var frameR11 = self.imgArrowR11.frame
        self.destinationFrameR11 = frameR11
        frameR11.origin.x += frameR11.width
        self.imgArrowR11.frame = frameR11
    }
    
    func firstSetupR12() {
        var frameR12 = self.imgArrowR12.frame
        self.destinationFrameR12 = frameR12
        frameR12.origin.x += frameR12.width
        frameR12.origin.y += frameR12.height
        self.imgArrowR12.frame = frameR12
    }
    
    func firstSetupR13() {
        var frameR13 = self.imgArrowR13.frame
        self.destinationFrameR13 = frameR13
        frameR13.origin.x += frameR13.width
        frameR13.origin.y += frameR13.height
        self.imgArrowR13.frame = frameR13
    }
    
    func firstSetupR21() {
        var frameR21 = self.imgArrowR21.frame
        self.destinationFrameR21 = frameR21
        frameR21.origin.x += frameR21.width
        frameR21.origin.y += frameR21.height
        self.imgArrowR21.frame = frameR21
    }
    
    func firstSetupR22() {
        var frameR22 = self.imgArrowR22.frame
        self.destinationFrameR22 = frameR22
        frameR22.origin.x += frameR22.width
        self.imgArrowR22.frame = frameR22
    }
    
    func firstSetupR23() {
        var frameR23 = self.imgArrowR23.frame
        self.destinationFrameR23 = frameR23
        frameR23.origin.x += frameR23.width
        frameR23.origin.y -= frameR23.height
        self.imgArrowR23.frame = frameR23
    }
    
    func firstSetupR31() {
        var frameR31 = self.imgArrowR31.frame
        self.destinationFrameR31 = frameR31
        frameR31.origin.x += frameR31.width
        frameR31.origin.y += frameR31.height
        self.imgArrowR31.frame = frameR31
    }
    
    func firstSetupR32() {
        var frameR32 = self.imgArrowR32.frame
        self.destinationFrameR32 = frameR32
        frameR32.origin.x += frameR32.width
        frameR32.origin.y += frameR32.height
        self.imgArrowR32.frame = frameR32
    }
    
    func firstSetupR33() {
        var frameR33 = self.imgArrowR33.frame
        self.destinationFrameR33 = frameR33
        frameR33.origin.x += frameR33.width
        self.imgArrowR33.frame = frameR33
    }
}

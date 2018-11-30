//
//  NavigationBarQClub.swift
//  QClub
//
//  Created by SMR on 9/28/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class NavigationBarQClub: UIView {

    var view : UIView!
    @IBOutlet weak var backBTN: UIButton!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var imageTop: UIImageView!
    @IBOutlet weak var rightBtn: UIButton!
    
    var backAction: (() -> ())?
    var rightAction: (() -> ())?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetUp()
    }
    
    @IBAction func backTUI(_ sender: Any) {
        self.backAction?()
    }
    
    @IBAction func rightBtnTUI(_ sender: Any) {
        self.rightAction?()
    }
    
    func config(title: String, image: String, rightBtnImage: String? = nil)
    {
        lbTitle.text = title
        imageTop.image = UIImage.init(named: image)
        
        if let rightImage = rightBtnImage {
            rightBtn.setImage(UIImage.init(named: rightImage), for: .normal)
            rightBtn.isHidden = false
        }
    }
    
    func hideBackButton() {
        backBTN.isHidden = true
    }
    
    func xibSetUp() {
        view = loadViewFromNib()
        view.frame = self.bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        addSubview(view)
    }
    
    func loadViewFromNib() ->UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "NavigationBarQClub", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }

}

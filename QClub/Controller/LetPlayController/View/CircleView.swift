//
//  CircleView.swift
//  QClub
//
//  Created by TuanNM on 10/18/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class CircleView: UIView {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet weak var contentLb: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = self.frame.width / 2
        containerView.clipsToBounds = true
    }
    
    func setData(round:Int,isCurrent:Bool){
        //16-8-4-2-1
        let roundName = round == 1 ? "결승전" : "\(round)강"
        contentLb.text = roundName
        
        if isCurrent{
            containerView.backgroundColor = UIColor.orange
            contentLb.textColor = UIColor.white
        }else{
            containerView.backgroundColor = UIColor.white
            contentLb.textColor = UIColor.lightGray
        }
        
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
    }
    
    // Loads a XIB file into a view and returns this view.
    fileprivate func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }

}

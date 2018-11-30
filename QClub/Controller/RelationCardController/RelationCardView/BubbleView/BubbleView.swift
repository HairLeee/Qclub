//
//  BubbleView.swift
//  QClub
//
//  Created by Dream on 9/15/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class BubbleView: UIView {

    
    @IBOutlet weak var bubbleContentLb: UILabel!
    
    private var tipX:CGFloat = 40
    var autoDissmiss = false
    var timeAutoDissmiss : Int?
    
    var dissMiss: (() -> ())?
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        guard let orangeColor = UIColor(hexString: ORANGE_COLOR) else{return}
        guard let lightGray = UIColor(hexString: LIGHT_GRAY_COLOR) else{return}
        
        let bubbleSpace = CGRect(x: 5, y: self.bounds.origin.y + 20, width: self.bounds.width - 10, height: self.bounds.height - 30)
        let bubblePath = UIBezierPath(roundedRect: bubbleSpace, cornerRadius: 5.0)
        bubblePath.lineWidth = 1.5
        
        orangeColor.setStroke()
        lightGray.setFill()
        bubblePath.stroke()
        bubblePath.fill()
        
        let trianglePath = UIBezierPath()
        trianglePath.lineWidth = 1.5
        let startPoint = CGPoint(x: tipX - 5, y: self.bounds.origin.y + 20)
        let tipPoint = CGPoint(x: tipX, y: 10)
        let endPoint = CGPoint(x: tipX + 5, y: self.bounds.origin.y + 20)
        
        trianglePath.move(to: startPoint)
        trianglePath.addLine(to: tipPoint)
        trianglePath.addLine(to: endPoint)
        orangeColor.setStroke()
        lightGray.setFill()
        trianglePath.stroke()
        trianglePath.fill()
    }
    
    override func layoutSubviews() {
        bubbleContentLb.sizeToFit()
        var frame = self.frame
        frame.size.height = bubbleContentLb.frame.size.height + 50 > 90 ? bubbleContentLb.frame.size.height + 50 : 90
        self.frame = frame
        if self.autoDissmiss {
            autoSetDissmiss()
        }
    }
    
    static func loadFromXib()->BubbleView{
        let bubbleView = Bundle.main.loadNibNamed("BubbleView", owner: self, options: nil)?[0] as! BubbleView
        bubbleView.isUserInteractionEnabled = true
        return bubbleView
    }
    func setTipX(tipX:CGFloat) {
        self.tipX = tipX
    }

    func autoSetDissmiss() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(timeAutoDissmiss ?? 3)) {
            self.removeFromSuperview()
            self.dissMiss?()
        }
    }

    @IBAction func dissMissTUI(_ sender: Any) {
        self.removeFromSuperview()
    }
}

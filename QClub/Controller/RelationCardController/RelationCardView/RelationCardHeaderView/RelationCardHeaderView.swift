//
//  RelationCardHeaderView.swift
//  QClub
//
//  Created by Dream on 9/14/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class RelationCardHeaderView: UICollectionReusableView {
    
    
    @IBOutlet weak var timeLb: UILabel!
    @IBOutlet weak var monthLb: UILabel!
    @IBOutlet weak var dayLb: UILabel!
    
    func setData(){
        self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH - 10, height: 50)
        monthLb.text = "\(Calendar.current.component(.month, from: Date()))"
        dayLb.text = "\(Calendar.current.component(.day, from: Date()))"
        
        //let timeStr = "내일 11:59pm까지 선택이 가능합니다."
        //let attributeStr = NSMutableAttributedString(string: timeStr)
        //let rangge = (timeStr as NSString).range(of: "11:59pm까지")
        //attributeStr.addAttribute(NSForegroundColorAttributeName, value: UIColor(hexString: ORANGE_COLOR)!, range: rangge)
        //timeLb.attributedText = attributeStr
        timeLb.text = ""
    }

}

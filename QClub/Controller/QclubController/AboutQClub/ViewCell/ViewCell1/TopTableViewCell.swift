//
//  TopTableViewCell.swift
//  QClub
//
//  Created by Dreamup on 11/6/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class TopTableViewCell: UITableViewCell {

    @IBOutlet var lb2: UILabel!
    @IBOutlet var lb3: UILabel!
    @IBOutlet var lb4: UILabel!
    @IBOutlet var lb6: UILabel!
    @IBOutlet var lb7: UILabel!

    @IBOutlet var viewTopContent: UIView!
    var text2WillBeChangedColor = "신뢰도"
    var text3WillBeChangedColor = "기본 정보에 대한 서류 확인"
    var text4WillBeChangedColor = "서류를 제출하여 확인 후 회원 승급"
    var text6WillBeChangedColor = "오픈하지 않으셔도 됩니다.프로필에 필요사항 오픈여부는 자유입니다."
    var text7WillBeChangedColor = "프로필에는 OOO학교, OOO회사로 기재하셔도 되며,연봉등을 오픈하지 않으셔도 됩니다."
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    func setupUI(){
        viewTopContent.layer.cornerRadius = 10
        viewTopContent.layer.borderColor = UIColor.orange.cgColor
        viewTopContent.layer.borderWidth = 1
        viewTopContent.layer.backgroundColor = UIColor.init(hexString: "#fdf1e5")?.cgColor
    
        lb2.changeTextColorForLabel(text2WillBeChangedColor)
        lb3.changeTextColorForLabel(text3WillBeChangedColor)
        lb4.changeTextColorForLabel(text4WillBeChangedColor)
        lb6.changeTextColorForLabel(text6WillBeChangedColor)
        lb7.changeTextColorForLabel(text7WillBeChangedColor)
        
    }
    
}

extension UILabel {
    
    func changeTextColorForLabel(_ textWillBeChangedColor:String){
        let timeStr = self.text!
        let attributeStr = NSMutableAttributedString(string: timeStr)
        let rangge = (timeStr as NSString).range(of: textWillBeChangedColor)
        attributeStr.addAttribute(NSForegroundColorAttributeName, value: UIColor(hexString: ORANGE_COLOR)!, range: rangge)
        self.attributedText = attributeStr
        
    }
}

//
//  HeaderTableViewCell.swift
//  QClub
//
//  Created by Dreamup on 11/7/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    
    
    @IBOutlet var viewTop: UIView!
    
    @IBOutlet var lbLevel: UILabel!
    
    @IBOutlet var lbText2: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    func setupUI(){
        viewTop.layer.cornerRadius = 10
        viewTop.layer.borderColor = UIColor.init(hexString: "#ffca92")?.cgColor
        viewTop.layer.borderWidth = 2
        
        setText()
        
    }
    
    func setText(){
        let timeStr = "제출하는 서류에 개인정보식별번호가 있는 경우, 예를 들어, 주민등록번호는 앞자리 6자리를 제외하고는 검은 펜으로보이지 않게 조치 후 업로드 해주시기 바랍니다."
        let attributeStr = NSMutableAttributedString(string: timeStr)
        let rangge = (timeStr as NSString).range(of: "주민등록번호는 앞자리 6자리를 제외하고는 검은 펜으로보이지 않게 조치 후 업로드 해주시기 바랍니다.")
        attributeStr.addAttribute(NSForegroundColorAttributeName, value: UIColor(hexString: ORANGE_COLOR)!, range: rangge)
        lbText2.attributedText = attributeStr
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

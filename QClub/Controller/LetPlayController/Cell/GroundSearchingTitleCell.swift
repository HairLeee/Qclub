//
//  GroundSearchingTitleCell.swift
//  QClub
//
//  Created by SMR on 12/20/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class GroundSearchingTitleCell: UICollectionViewCell {
    
    @IBOutlet weak var lbTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let attributedText = Utils.getAtributedStringWithLinespace(text: "두 분의 Q1이상 등급 회원 중 1명을 선택해주세요.\n검색 후 24시간 내에만 검색된 회원의 \n상세프로필을 확인할 수 있습니다.", lineSpace: 5, alignment: .left)
        
        attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(hexString: "#616060") ?? .black, range: NSRange(location:0,length:17))
        attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(hexString: "#E86A12") ?? .black, range: NSRange(location:18,length:2))
        attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(hexString: "#616060") ?? .black, range: NSRange(location:21,length:13))
        attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(hexString: "#E86A12") ?? .black, range: NSRange(location:35,length:7))
        attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(hexString: "#616060") ?? .black, range: NSRange(location:43,length:attributedText.length - 1 - 43))
        lbTitle.attributedText = attributedText
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    
}

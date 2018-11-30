//
//  GroundMettingCell.swift
//  QClub
//
//  Created by TuanNM on 10/10/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class GroundMettingCell: UITableViewCell {
   
    
    @IBOutlet weak var stackLBheight: NSLayoutConstraint!
    @IBOutlet weak var lbDetail: UILabel!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var lb1: UILabel!
    @IBOutlet weak var lb2: UILabel!
    @IBOutlet weak var lb3: UILabel!
    @IBOutlet weak var lb4: UILabel!
    @IBOutlet weak var lb5: UILabel!
    @IBOutlet weak var imgHunter: UIImageView!
    
    var enterAction: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        let attributedText = Utils.getAtributedStringWithLinespace(text: "매일 낮 12시, 화살이 날아다닙니다.\n오늘의 인연카드와 함께, 모든 회원들에게 3 : 3 미팅룸이 오픈됩니다.\n18시까지 호감가는 1명 선택하시고 자신을 매력있게 어필하세요.\n18시 정각에 선택 결과를 오픈합니다.\n서로에게 호감화살을 쏜 회원들만 상대 회원의 상세 프로필을 확인할 수 있습니다.\n호감화살이 빗나간 분들은 상세프로필을 확인할 수는 없지만,\n인연이 되고픈 회원에게 '스페셜 인연카드'를 보내서,\n인연을 이어 가실 수 있습니다.", lineSpace: 5, alignment: .center)
        
        attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(hexString: "#616060") ?? .black, range: NSRange(location:0,length:35))
        attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(hexString: "#1d1d1d") ?? .black, range: NSRange(location:36,length:21))
        attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(hexString: "#616060") ?? .black, range: NSRange(location:58,length:153))
        attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(hexString: "#1d1d1d") ?? .black, range: NSRange(location:212,length:9))
        attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.init(hexString: "#616060") ?? .black, range: NSRange(location:222,length:attributedText.length - 1 - 222))
        
        lbDetail.attributedText = attributedText
            
        setupUI()
    }
    
    func setData(){

    }
    
    func setupUI() {
        stackLBheight.constant = (SCREEN_WIDTH - 20 - 5*4 )/5
        
        lb1.layer.cornerRadius = stackLBheight.constant/2
        lb1.clipsToBounds = true
        lb1.layer.borderColor = UIColor.init(hexString: "#f49836")?.cgColor
        lb1.layer.borderWidth = 1.0
        
        lb2.layer.cornerRadius = stackLBheight.constant/2
        lb2.clipsToBounds = true
        lb2.layer.borderColor = UIColor.init(hexString: "#f49836")?.cgColor
        lb2.layer.borderWidth = 1.0
        
        lb3.layer.cornerRadius = stackLBheight.constant/2
        lb3.clipsToBounds = true
        lb3.layer.borderColor = UIColor.init(hexString: "#f49836")?.cgColor
        lb3.layer.borderWidth = 1.0
        
        lb4.layer.cornerRadius = stackLBheight.constant/2
        lb4.clipsToBounds = true
        lb4.layer.borderColor = UIColor.init(hexString: "#f49836")?.cgColor
        lb4.layer.borderWidth = 1.0
        
        lb5.layer.cornerRadius = stackLBheight.constant/2
        lb5.clipsToBounds = true
        lb5.layer.borderColor = UIColor.init(hexString: "#f49836")?.cgColor
        lb5.layer.borderWidth = 1.0
        
        imgHunter.layer.borderWidth = 5.0
        imgHunter.layer.borderColor = UIColor.gray.cgColor
        imgHunter.layer.borderColor = UIColor.init(hexString: "#ebebeb")?.cgColor
    }
    
    @IBAction func acceptAction(_ sender: Any) {
        self.enterAction?()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

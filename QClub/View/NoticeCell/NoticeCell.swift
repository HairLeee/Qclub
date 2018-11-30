//
//  NoticeCell.swift
//  QClub
//
//  Created by Dreamup on 10/5/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

protocol noticeCellDelegate {
    func cellExpand(index:Int, isExpand: Bool)
}




class NoticeCell: UITableViewCell {

 
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbDetail: UILabel!
    @IBOutlet weak var imvUp: UIImageView!
    @IBOutlet weak var detailPaddingTop: NSLayoutConstraint!

    
    @IBOutlet weak var wvDetail: UIWebView!
    @IBOutlet weak var detailPaddingBottom: NSLayoutConstraint!
    
    
    var noticeCell: noticeCellDelegate?
    var isExpand = false
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func  bidingData(isExpand: Bool, noticeList:[Notice], index:Int)  {
        self.isExpand = isExpand
        
        lbTitle.text = noticeList[index].title
        if isExpand {
            detailPaddingTop.constant = 60
            detailPaddingBottom.constant = 60
//            lbDetail.text = noticeList[index].descriptionFqa
            imvUp.image = UIImage(named: "notice_expand_up")
            wvDetail.loadHTMLString(noticeList[index].descriptionFqa, baseURL: nil)
        } else {
            detailPaddingTop.constant = 0
            detailPaddingBottom.constant = 0
            lbDetail.text = ""
            imvUp.image = UIImage(named: "notice_expand_down")
            
        }
    }
    
    @IBAction func doExpand(_ sender: Any) {
        isExpand = !isExpand
        noticeCell?.cellExpand(index: self.tag, isExpand: isExpand)
    }
    
}

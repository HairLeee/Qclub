//
//  FaqCell.swift
//  QClub
//
//  Created by Dreamup on 10/2/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

protocol FaqCellDelegate {
    func cellExplain(index: Int, isExplain: Bool)
}

class FaqCell: UITableViewCell {
    
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var imvUp: UIImageView!
    @IBOutlet weak var lbDetailPaddingTop: NSLayoutConstraint!
    @IBOutlet weak var lbDetailPaddingBottom: NSLayoutConstraint!
    @IBOutlet weak var lbDetail: UILabel!
    var isExplain = false
    var delegate: FaqCellDelegate?
    
    
    @IBOutlet var wvFqa: UIWebView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        wvFqa.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func bindingData(data:[Fqa], index:Int, isExplain: Bool) {
        self.isExplain = isExplain
        if isExplain {
            wvFqa.isHidden = false
            
            wvFqa.loadHTMLString(data[index].descriptionFqa, baseURL: nil)
            
            lbDetailPaddingTop.constant = 60
            lbDetailPaddingBottom.constant = 60
            wvFqa.needsUpdateConstraints()
            lbTitle.text = data[index].title
            imvUp.image = UIImage(named: "notice_expand_up")
        } else {
             wvFqa.isHidden = true
            lbDetailPaddingTop.constant = 0
            lbDetailPaddingBottom.constant = 0
            lbDetail.text = ""
            lbTitle.text = data[index].title
            imvUp.image = UIImage(named: "notice_expand_down")
            
            addSub(view: lbDetail)
        }
        
    }
    
    func addSub(view: UIView){
        
        
        
    }
    
    @IBAction func explainTUI(_ sender: Any) {
        isExplain = !isExplain
        delegate?.cellExplain(index: self.tag, isExplain: isExplain)
    }
}

extension FaqCell:UIWebViewDelegate {
    
    
    
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
     
        switch webView {
        case wvFqa:
        print("FaqCell webViewDidFinishLoad \(wvFqa.frame.height)")
     
        default:
            break
        }
        
        
        
    }
}



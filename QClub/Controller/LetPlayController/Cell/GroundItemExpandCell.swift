//
//  GroundItemExpandCell.swift
//  QClub
//
//  Created by TuanNM on 10/27/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class GroundItemExpandCell: UITableViewCell {

    @IBOutlet weak var numberLike: UILabel!
    @IBOutlet weak var expandImv: UIImageView!
    @IBOutlet weak var iconLike: UIImageView!
    @IBOutlet weak var btnExplain: UIButton!
    
    var expandAction: (() -> ())?
    var likeAction: ((_ isLike : Bool, _ itemSeq: Int) -> ())?
    var itemDetail : ItemDetailObject?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(itemDetail : ItemDetailObject?) {
        if let detail = itemDetail {
            self.itemDetail = detail
            numberLike.text = "좋아요 \(detail.likeCnt)"
            iconLike.image = detail.myLikeCnt > 0 ? UIImage.init(named: "ic_like") : UIImage.init(named: "ic_unlike")
            
            btnExplain.isHidden = !(detail.userSeq == Context.getUserLogin()?.userSeq)
            expandImv.isHidden = !(detail.userSeq == Context.getUserLogin()?.userSeq)

        }
        
    }

    @IBAction func showUserAction(_ sender: Any) {
        UIView.animate(withDuration: 0.2, animations: {
            self.expandAction?()
            self.expandImv.transform = self.expandImv.transform.rotated(by: .pi)
        })
    }
    
    @IBAction func likeAction(_ sender: Any) {
        if let detail = self.itemDetail {
            likeAction?(detail.myLikeCnt > 0, detail.itItemSeq)
        }
    }
}

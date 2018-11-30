//
//  StorePromotionTableViewCell.swift
//  QClub
//
//  Created by Dreamup on 11/6/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class StorePromotionTableViewCell: UITableViewCell {

    
    @IBOutlet var lbPrice: UILabel!
    @IBOutlet var lbRealPrice: UILabel!
    @IBOutlet var lbPercent: UILabel!
    @IBOutlet var lbComment: UILabel!
    @IBOutlet weak var icStoreDown: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bidingData(pStore:Store, index: Int){
        
        lbPrice.text =  pStore.heartCnt
        lbRealPrice.text = "\(pStore.price.toStringWithComma())원"

        icStoreDown.isHidden = (index == 0)
        lbPercent.isHidden = (index == 0)
        lbComment.text = (index == 1 ? "(단가할인율)" : "")
        
        switch index {
        case 1:
            lbPercent.text = "6.3%"
        case 2:
            lbPercent.text = "12.5%"
        case 3:
            lbPercent.text = "18.8%"
        case 4:
            lbPercent.text = "25.0%"
        case 5:
            lbPercent.text = "31.3%"
        case 6:
            lbPercent.text = "37.5%"
        case 7:
            lbPercent.text = "43.8%"
        default:
            break
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

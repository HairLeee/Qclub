//
//  StoreCell.swift
//  QClub
//
//  Created by Dreamup on 9/29/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class StoreCell: UITableViewCell {
    
    
    @IBOutlet weak var fggf: UILabel!
    
    @IBOutlet weak var lbPrice1: UILabel!
    
    @IBOutlet weak var lbPrice2: UILabel!
    
    @IBOutlet weak var lbPrice3: UILabel!
    
    @IBOutlet weak var lbPercent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func bindingData(storeData:Store) {
        lbPrice1.text = storeData.heartCnt
        lbPrice2.text = "\((storeData.price*2).toStringWithComma())원"
        lbPrice3.text = "\(storeData.price.toStringWithComma())원"
        lbPercent.text = "50%"
    }
    
}

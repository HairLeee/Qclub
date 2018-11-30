//
//  HeartCell.swift
//  QClub
//
//  Created by Dreamup on 9/29/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class HeartCell: UITableViewCell {

    
    
    @IBOutlet weak var lbDate: UILabel!
    
    @IBOutlet weak var lbContent: UILabel!
    
    @IBOutlet weak var lbHistoryType: UILabel!
    
    
    @IBOutlet weak var lbHeartCount: UILabel!
    
    @IBOutlet weak var lbHeartCurrentCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindingData(pHeart:Heart) {
        
        lbDate.text = pHeart.insertDate
        lbContent.text = pHeart.heartDetail
        lbHeartCount.text = String(pHeart.heartCount)
        lbHistoryType.text = pHeart.historyType
        lbHeartCurrentCount.text = String(pHeart.heartCurrentCount)
        
        
        
        
    }

}

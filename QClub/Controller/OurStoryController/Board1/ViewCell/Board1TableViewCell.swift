//
//  Board1TableViewCell.swift
//  QClub
//
//  Created by Dreamup on 10/23/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class Board1TableViewCell: UITableViewCell {
    
    
    @IBOutlet var lbTitle: UILabel!
    
    @IBOutlet var lbNickName: UILabel!
    
    @IBOutlet var imvGender: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    func bidingData(pBoard:Board){
        
        
        lbTitle.text = pBoard.title
        lbNickName.text = pBoard.nickname
        
     
        
    }
}

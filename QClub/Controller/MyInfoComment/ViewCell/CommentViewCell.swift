//
//  CommentViewCell.swift
//  QClub
//
//  Created by Dreamup on 10/12/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class CommentViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var lbComment: UILabel!
    
    @IBOutlet var lbDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func bidingData(data:MyInfoComment, isOpened:Bool){
        lbComment.text = data.advice
        lbDate.text = data.paidDate

    }
    
    
}

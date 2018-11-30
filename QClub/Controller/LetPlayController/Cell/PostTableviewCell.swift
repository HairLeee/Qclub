//
//  PostTableviewCell.swift
//  QClub
//
//  Created by SMR on 11/17/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class PostTableviewCell: UITableViewCell {

    @IBOutlet weak var postBTN: CompleteButton!
    var post : (() -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    @IBAction func postAction(_ sender: Any) {
        post?()
    }
}

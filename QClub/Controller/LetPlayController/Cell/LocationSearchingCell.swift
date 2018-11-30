//
//  LocationSearchingCell.swift
//  QClub
//
//  Created by TuanNM on 11/10/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class LocationSearchingCell: UITableViewCell {

    @IBOutlet weak var lineHeight: NSLayoutConstraint!
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var contentTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lineHeight.constant = 0.5
    }

    func setTitle(title:String,content:String)  {
        headerTitle.text = title
        contentTitle.text = content
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

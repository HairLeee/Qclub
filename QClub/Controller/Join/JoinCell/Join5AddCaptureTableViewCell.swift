//
//  Join5AddCaptureTableViewCell.swift
//  QClub
//
//  Created by SMR on 10/3/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

protocol Join5AddCaptureTableViewCellDelegate {
    func addCaptureCell()
}

class Join5AddCaptureTableViewCell: UITableViewCell {
    
    var delegate: Join5AddCaptureTableViewCellDelegate?
    @IBOutlet weak var viewTotal: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewTotal.layer.borderColor = UIColor.gray.cgColor
        viewTotal.layer.borderWidth = 0.5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func addCaptureCell(_ sender: Any) {
        delegate?.addCaptureCell()
    }
}

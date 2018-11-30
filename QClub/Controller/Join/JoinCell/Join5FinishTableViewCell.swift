//
//  Join5FinishTableViewCell.swift
//  QClub
//
//  Created by SMR on 10/3/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

protocol Join5FinishTableViewCellDelegate {
    func completeInput()
}

class Join5FinishTableViewCell: UITableViewCell {

    var delegate: Join5FinishTableViewCellDelegate?
    
    @IBOutlet weak var okBTN: CompleteButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindingData(isActive: Bool) {
        self.okBTN.changeState(isActive: isActive)
    }

    @IBAction func finishTUI(_ sender: Any) {
        delegate?.completeInput()
    }
}

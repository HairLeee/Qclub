//
//  MainHistoryHeaderCollectionReusableView.swift
//  QClub
//
//  Created by SMR on 10/13/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class MainHistoryHeaderCollectionReusableView: UICollectionReusableView {

    @IBOutlet weak var lbTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setTitle(text: String) {
        lbTitle.text = text
    }
    
}

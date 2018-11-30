//
//  GroundFoodLoadMoreCell.swift
//  QClub
//
//  Created by SMR on 12/18/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class GroundFoodLoadMoreCell: UICollectionViewCell {

    @IBOutlet var imvBg: UIImageView!
    @IBOutlet weak var btnLoadMore: CompleteButton!
    var loadMoreAction : (() -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func loadMore(_ sender: Any) {
        loadMoreAction?()
    }
    
    func activeLoadMoreButton(isActive : Bool) {
        btnLoadMore.changeState(isActive: isActive)
        btnLoadMore.isHidden = !isActive
        imvBg.isHidden = isActive
    }
    
    func setTitle(title: String) {
        btnLoadMore.setTitle(title, for: .normal)
    }

}

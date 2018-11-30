//
//  FavoriteMemberNoDataCell.swift
//  QClub
//
//  Created by SMR on 10/17/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class FavoriteMemberNoDataCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var imageMain: UIImageView!
    @IBOutlet weak var lbContent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        lbContent.numberOfLines = 0
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(type: Int) {
        lbTitle.text = type == 0 ? "내가 호감 있는 인연" : "내게 호감 있는 인연"
        if type == 0 {
            imageMain.image = UIImage.init(named: "ic_favorite_no_data1")
            lbContent.attributedText = Utils.getAtributedStringWithLinespace(text: "현재 회원님이 호감있는 인연이 없습니다.\n곧, 좋은 인연이 나타날 거예요~", lineSpace: 10)
        } else {
            imageMain.image = UIImage.init(named: "ic_favorite_no_data2")
            lbContent.attributedText = Utils.getAtributedStringWithLinespace(text: "현재 호감있는 인연이 없습니다.\n곧, 멋진 인연이 나타날 거예요~", lineSpace: 10)
        }
    }

}

//
//  GroundItemWriteCell.swift
//  QClub
//
//  Created by TuanNM on 10/26/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

protocol GroundItemWriteCellDelegate:class {
    func willAddPhotoCell(index:Int)
}

class GroundItemWriteCell: UITableViewCell {

    weak var delegate:GroundItemWriteCellDelegate?
    var index = 0
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var photoImv: UIImageView!
    @IBOutlet weak var introduceTv: IQTextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.borderWidth = 0.5
        containerView.layer.borderColor = UIColor.init(hexString: LINE_GRAY_COLOR)?.cgColor
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapPhotoView))
        photoImv.isUserInteractionEnabled = true
        photoImv.addGestureRecognizer(tapGesture)
    }

    @objc func tapPhotoView() {
        self.delegate?.willAddPhotoCell(index: index)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupData(picture : ItItemPictures) {
        photoImv.kf.setImage(with: URL.init(string: picture.itItemPicture))
        introduceTv.text = picture.description
        
        
    }

}

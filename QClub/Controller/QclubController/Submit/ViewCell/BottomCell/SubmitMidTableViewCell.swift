//
//  SubmitMidTableViewCell.swift
//  QClub
//
//  Created by Dreamup on 11/7/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class SubmitMidTableViewCell: UITableViewCell {
    
    
    var chooseOrTakeImage:ChooseOrTakeImage?
    var onItemClick:OnClickListener?
    @IBOutlet var viewWarning: UIView!
    
    @IBOutlet var viewWarningText: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewWarningText.isHidden = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func btnNeedToUploadMore(_ sender: Any) {
        chooseOrTakeImage?.NeedToUpLoadMoreImage()
    }
    
    func updateLayoutAferGettingDataFinished(pStatus:String){
        
        print("updateLayoutAferGettingDataFinished \(pStatus)")

        switch pStatus {
        case "심사중":
            // Waiting for the admin
            btnUpLoad.isHidden = true
            viewWarningText.isHidden = false
        case "refused":
            // Admin refused
            btnUpLoad.isHidden = false
            viewWarningText.isHidden = true
        default:
            break
        }
 
        
    }
    
    
    @IBOutlet var btnUpLoad: UIButton!
    
    @IBAction func btnUpLoad(_ sender: Any) {
        onItemClick?.clickOkAction()
//            btnUpLoad.isHidden = true
//         viewWarningText.isHidden = false
        
    }
}

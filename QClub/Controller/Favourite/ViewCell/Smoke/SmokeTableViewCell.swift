//
//  SmokeTableViewCell.swift
//  QClub
//
//  Created by Dreamup on 10/17/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class SmokeTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var viewContentExpandOutlet: UIView!
    
    @IBOutlet weak var checkBox1: Checkbox!
    
    @IBOutlet weak var checkBox2: Checkbox!
    
    @IBOutlet weak var checkBox3: Checkbox!
    
    var groupChexBox = GroupCheckBox()
    
    
    @IBOutlet var lbResult: UILabel!
    @IBOutlet weak var viewContentHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var marginTopOfViewContent: UIView!
    
    @IBOutlet weak var marginBottomOfViewContent: NSLayoutConstraint!
    
    
    @IBOutlet weak var marginBottomOfView: NSLayoutConstraint!
    
    var explainAction : ((_ cell : SmokeTableViewCell?, _ isEpand: Bool) -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        addCheckbox(privacyCheckBox: checkBox1, tag:0)
        addCheckbox(privacyCheckBox: checkBox2,tag:1)
        addCheckbox(privacyCheckBox: checkBox3,tag:2)
        
        groupChexBox.checkboxs.append(checkBox1)
        groupChexBox.checkboxs.append(checkBox2)
        groupChexBox.checkboxs.append(checkBox3)
        
        
    }
    
    var mData = FavouriteValues()
    func bidingData(isExplain: Bool, data: FavouriteValues, _ title:String) {
        isEpand = isExplain
        
        mData = data

        lbResult.text = mData.smokingDetailChar

        switch mData.smokingDetailChar {
        case "0":
            groupChexBox.selectCheckBox(index: 0)
            lbResult.text = "무관"
        case "2":
            groupChexBox.selectCheckBox(index: 1)
            lbResult.text = "비흡연"
        case "1":
            groupChexBox.selectCheckBox(index: 2)
            lbResult.text = "연상"
            
        default:
            break
        }
        
        
        if !isEpand {
            viewContentHeightConstant.constant = 0
            viewContentExpandOutlet.isHidden = true
        } else {
            viewContentHeightConstant.constant = 60
            viewContentExpandOutlet.isHidden = false
        }
        
        isEpand = !isEpand
    }
    
    func addCheckbox(privacyCheckBox:Checkbox, tag:Int) {
        
        privacyCheckBox.tag = tag
        privacyCheckBox.borderStyle = .square
        privacyCheckBox.checkmarkStyle = .square
        privacyCheckBox.borderWidth = 1
        privacyCheckBox.borderColor = UIColor.init(hexString: "#e86a12")
        privacyCheckBox.checkmarkColor = UIColor.init(hexString: "#e86a12")
        privacyCheckBox.checkmarkSize = 13
        privacyCheckBox.valueChanged = {[weak self] (value) in
            guard let _self = self else { return  }
            _self.groupChexBox.selectCheckBox(index: privacyCheckBox.tag)
            
            switch privacyCheckBox.tag {
            case 0:
                _self.lbResult.text = "무관"
                _self.mData.smokingDetailChar = "무관"
                
            case 1:
                _self.lbResult.text = "비흡연"
                _self.mData.smokingDetailChar = "2"
            case 2:
                _self.lbResult.text = "연상"
                _self.mData.smokingDetailChar = "1"
            default:
                break
            }
            
            _self.onItemClick?.PushFavouriteDataToMain(data: _self.mData.smokingDetailChar, typeOfFavorData: 7)
            
        }
        
    }
    
    var isEpand:Bool = false
    var onItemClick:OnItemClick?
    @IBAction func btnExpandAction(_ sender: Any) {
        
        onItemClick?.OnItemClickListener(indexOfRow: self.tag, isHidden: isEpand)

    }
    
}

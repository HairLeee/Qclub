//
//  ReligionTableViewCell.swift
//  QClub
//
//  Created by Dreamup on 10/17/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class ReligionTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var viewContentExpandOutlet: UIView!
    
    @IBOutlet weak var checkBox1: Checkbox!
    
    @IBOutlet weak var checkBox2: Checkbox!
    
    @IBOutlet var lbResult: UILabel!
    
    var groupChexBox = GroupCheckBox()
    
    @IBOutlet weak var viewContentHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var marginTopOfViewContent: UIView!
    
    @IBOutlet weak var marginBottomOfViewContent: NSLayoutConstraint!
    
    
    @IBOutlet weak var marginBottomOfView: NSLayoutConstraint!
    
    var explainAction : ((_ cell : FavouriteTableViewCell?, _ isEpand: Bool) -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        addCheckbox(privacyCheckBox: checkBox1, tag:0)
        addCheckbox(privacyCheckBox: checkBox2,tag:1)
        
        groupChexBox.checkboxs.append(checkBox1)
        groupChexBox.checkboxs.append(checkBox2)
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var mData = FavouriteValues()
    func bidingData(isExplain: Bool, data: FavouriteValues,_ title:String) {
        isEpand = isExplain
        mData = data
        
        if mData.relegionMatch == "Y" {
            groupChexBox.selectCheckBox(index: 1)
            lbResult.text = "동일 종교만"
        
        } else {
            lbResult.text = "무관"
            groupChexBox.selectCheckBox(index: 0)
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
                _self.mData.relegionMatch = "무관"
            case 1:
                _self.lbResult.text = "동일 종교만"
                _self.mData.relegionMatch = "동일 종교만"
                
                
            default:
                break
            }
            
            var result = ""
            if _self.lbResult.text == "연하" {
                result = "Y"
            }
            
            _self.onItemClick?.PushFavouriteDataToMain(data: result, typeOfFavorData: 5)
            
        }
        
    }
    
    var isEpand:Bool = false
    var onItemClick:OnItemClick?
    @IBAction func btnExpandAction(_ sender: Any) {
        
        onItemClick?.OnItemClickListener(indexOfRow: self.tag, isHidden: isEpand)
        
        //        if let action = explainAction {
        //            action(self,isEpand)
        //        }
        
    }
    
}

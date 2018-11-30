//
//  FavouriteTableViewCell.swift
//  QClub
//
//  Created by Dreamup on 10/13/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit


class FavouriteTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var viewContentExpandOutlet: UIView!
    
    @IBOutlet weak var checkBox1: Checkbox!
    
    @IBOutlet weak var checkBox2: Checkbox!
    
    @IBOutlet weak var checkBox3: Checkbox!
    
    @IBOutlet weak var checkBox4: Checkbox!
    
    
    @IBOutlet weak var viewContentHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var marginTopOfViewContent: UIView!
    
    @IBOutlet weak var marginBottomOfViewContent: NSLayoutConstraint!
    
    @IBOutlet var lbResult: UILabel!
    var mResult = ""
    @IBOutlet weak var marginBottomOfView: NSLayoutConstraint!
    
    var groupChexBox = GroupCheckBox()
    
    var explainAction : ((_ cell : FavouriteTableViewCell?, _ isEpand: Bool) -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        addCheckbox(privacyCheckBox: checkBox1, tag:0)
        addCheckbox(privacyCheckBox: checkBox2,tag:1)
        addCheckbox(privacyCheckBox: checkBox3,tag:2)
        addCheckbox(privacyCheckBox: checkBox4,tag:3)
        
        groupChexBox.checkboxs.append(checkBox1)
        groupChexBox.checkboxs.append(checkBox2)
        groupChexBox.checkboxs.append(checkBox3)
        groupChexBox.checkboxs.append(checkBox4)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var mTitle = AgeRangeTitle()
    func bidingData(isExplain: Bool, data: [String], _ title:AgeRangeTitle) {
        isEpand = isExplain
        mTitle = title

        switch title.content {
        case "무관":
            groupChexBox.selectCheckBox(index: 0)
        case "연하":
          groupChexBox.selectCheckBox(index: 1)
        case "연상":
             groupChexBox.selectCheckBox(index: 2)
        case "동갑":
             groupChexBox.selectCheckBox(index: 3)
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
        
        lbResult.text = title.content
      
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
                _self.mTitle.content = "무관"
                
            case 1:
                _self.lbResult.text = "연하"
                _self.mTitle.content = "연하"
            case 2:
                _self.lbResult.text = "연상"
                  _self.mTitle.content = "연상"
            case 3:
                _self.lbResult.text = "동갑"
                  _self.mTitle.content = "동갑"
            default:
                break
            }
            _self.onItemClick?.PushFavouriteDataToMain(data: _self.lbResult.text!, typeOfFavorData: 0)
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

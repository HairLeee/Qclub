//
//  CommentViewCellWithoutCm.swift
//  QClub
//
//  Created by Dreamup on 10/12/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit


protocol CommentPrl {
    func doOKAction(index:Int)
}


class CommentViewCellWithoutCm: UITableViewCell {

    
    @IBOutlet weak var lbComment: UILabel!
    var doOKAction:CommentPrl?
    var mData:Comment?
    var mIndex:Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bidingData(data:MyInfoComment, isOpened:Bool){
//        lbComment.text = data.comment
        
    
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnCommentDetail(_ sender: Any) {
        
        let alertQ = AlertQClub.instanceFromNib(content: "조언을 확인하려면 하트1개가 필요합니다.\n확인하시겠습니까?", image: "ic_done")
        alertQ.show()  
        alertQ.action2 = {
            
             self.doOKAction?.doOKAction(index: self.tag)
        }
        
    }
    
}

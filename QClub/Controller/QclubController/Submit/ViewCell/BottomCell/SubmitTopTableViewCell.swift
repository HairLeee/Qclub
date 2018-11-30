//
//  SubmitTopTableViewCell.swift
//  QClub
//
//  Created by Dreamup on 11/7/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

protocol ChooseOrTakeImage {
    func ChooseOrTakeImage(pIndexOfImage:Int)
      func RemoveImage(pRemoveImageFromIndex:Int)
    func Certificate()
    func NeedToUpLoadMoreImage()
}

class SubmitTopTableViewCell: UITableViewCell {
    
    
    
    var chooseOrTakeImage:ChooseOrTakeImage?
    
    
    
    @IBOutlet var lbTItle: UILabel!
    @IBOutlet var lbDescribe: UILabel!
    
    @IBOutlet var imvTitle: UIImageView!
    
    
    @IBOutlet var imvChoose1: UIImageView!
    
    @IBOutlet var imvChoose2: UIImageView!
    
    
    @IBOutlet var imvChoose3: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateImageAfterChooseOrTakeImage(pImage: UIImage){

        imvChoose2.image = pImage

    }
    
    
    func bidingData(memberInfomation:(String,String,Bool,UIImage)){
        
        switch self.tag {
            
        case 0:
            
            imvTitle.isHidden = false
            lbTItle.attributedText = testChangeColor(value:memberInfomation.0)
            lbDescribe.textColor = UIColor.white
            lbTItle.textColor = UIColor.black
            imvChoose2.image = memberInfomation.3
            
            
        case 1:
            
            imvTitle.isHidden = false
            lbTItle.text = memberInfomation.0
            lbTItle.textColor = UIColor.black
            lbDescribe.textColor = UIColor.orange
            lbDescribe.text = memberInfomation.1
            imvChoose2.image = memberInfomation.3
            
        case 2:
            
            imvTitle.isHidden = false
            lbTItle.text = memberInfomation.0
            lbTItle.textColor = UIColor.black
            lbDescribe.textColor = UIColor.white
            imvChoose2.image = memberInfomation.3
            
            
            
        default:
            
            imvTitle.isHidden = true
            lbTItle.textColor = UIColor.white
            lbDescribe.textColor = UIColor.white
            imvChoose2.image = memberInfomation.3
            
        }
        
        
        
    }
    
    func testChangeColor(value:String) -> NSMutableAttributedString {
  
        let myString:NSString = value as NSString
        var myMutableString = NSMutableAttributedString()
        myMutableString = NSMutableAttributedString(string: myString as String, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!])
        myMutableString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue, range: NSRange(location:0,length:4))
        
        
        return myMutableString
    }
    
    
    @IBAction func btnUploadImage2(_ sender: Any) {
        
        chooseOrTakeImage?.ChooseOrTakeImage(pIndexOfImage:self.tag)
    }
    
    
    
    
    
}

//
//  Join5CaptureCellTableViewCell.swift
//  QClub
//
//  Created by SMR on 10/3/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import UITextView_Placeholder

protocol Join5CaptureCellTableViewCellDelegate {
    func getImage(sender: UIButton)
    func updateText(text: String, sender: UIButton)
}

class Join5CaptureCellTableViewCell: UITableViewCell {

    @IBOutlet weak var caputeBTN: UIButton!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var viewTotal: UIView!
    var isHaveImage = false
    
    var delegate: Join5CaptureCellTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textView.delegate = self
        viewTotal.layer.borderColor = UIColor.gray.cgColor
        viewTotal.layer.borderWidth = 0.5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindingData(data : (UIImage?, String?)) {
        
        if let image = data.0 {
            caputeBTN.setImage(image, for: .normal)
            isHaveImage = true
            textView.isHidden = false
        } else {
            caputeBTN.setImage(UIImage.init(named: "ic_join_capture"), for: .normal)
            isHaveImage = false
            textView.isHidden = true
        }
        
        if let text = data.1 {
            textView.text = text
        } else {
            textView.text = ""
        }
    }

    @IBAction func captureTUI(_ sender: Any) {
        delegate?.getImage(sender: sender as! UIButton)
    }
}

extension Join5CaptureCellTableViewCell: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        delegate?.updateText(text: textView.text, sender: self.caputeBTN)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count // for Swift use count(newText)
        return numberOfChars < 101
    }
}

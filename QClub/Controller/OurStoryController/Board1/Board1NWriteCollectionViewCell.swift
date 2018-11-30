//
//  Board1NWriteCollectionViewCell.swift
//  QClub
//
//  Created by Dreamup on 11/8/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit




class Board1NWriteCollectionViewCell: UICollectionViewCell {
    
    
    
    var ChooseOrTakeImage:ChooseOrTakeImage?
    var mImage:UIImage?
    @IBAction func btnRemoveAction(_ sender: Any) {
        
        
        
    }
    

    @IBOutlet var imvAva: UIImageView!
    @IBOutlet var btnChooseImageOutlet: UIButton!
    @IBAction func btnChooseImage(_ sender: Any) {
        
        ChooseOrTakeImage?.ChooseOrTakeImage(pIndexOfImage: self.tag)
        
    }
    
    func updateImageAfterChooseOrTakeImage(pImage:UIImage){
        mImage = pImage
        imvAva.image = pImage
        imvAva.isHidden = false
        
        
    }
    
    func setupUI(){
        
        btnRemove.isHidden = true
        
    }
    
    @IBOutlet var btnRemove: UIButton!
    
    @IBAction func btnRemove(_ sender: Any) {
        
        ChooseOrTakeImage?.RemoveImage(pRemoveImageFromIndex: self.tag)
        
    }
    
    
    func removeImageFromCollectionViewItem() {
        
        btnRemove.isHidden = true
        imvAva.isHidden = true
        
    }
    
    func setupLayout(){
        
        if mImage != nil {
            btnRemove.isHidden = false
        } else {
            btnRemove.isHidden = true
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //        btnRemove.isHidden = true
    }
    
}

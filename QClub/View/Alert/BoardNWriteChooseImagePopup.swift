//
//  BoardNWriteChooseImagePopup.swift
//  QClub
//
//  Created by Dreamup on 12/22/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class BoardNWriteChooseImagePopup: PopupView {
    
    var selectFromAlbum: (() -> ())?
    var takeAPhoto: (() -> ())?
 
    
    class func instanceFromNib() -> BoardNWriteChooseImagePopup {
        let joinView = UINib(nibName: "BoardNWriteChooseImagePopup", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BoardNWriteChooseImagePopup
        joinView.popupFrame = CGRect.init(x: 20, y: (SCREEN_HEIGHT - 150)/2 , width: SCREEN_WIDTH - 40, height: 100)
        return joinView
    }
    
    @IBAction func selectFromAlbumTUI(_ sender: Any) {
        self.hide()
        if let selecAlbumAction = self.selectFromAlbum {
            selecAlbumAction()
        }
    }
    
    @IBAction func takeAPhotoTUI(_ sender: Any) {
        self.hide()
        if let takeAPhotoAction = self.takeAPhoto {
            takeAPhotoAction()
        }
    }
}

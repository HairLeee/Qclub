//
//  RelationCardHeaderSpecialView.swift
//  QClub
//
//  Created by Dream on 9/14/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class RelationCardHeaderSpecialView: UICollectionReusableView {

    var callBackShowInfo:((_ button:UIButton)->Void)?
    
    @IBAction func showInfoAction(_ sender: Any) {
        guard let button = sender as?  UIButton else{return}
        callBackShowInfo?(button)
        
    }
   
    func setData(){
        self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 75)
    }
    
}

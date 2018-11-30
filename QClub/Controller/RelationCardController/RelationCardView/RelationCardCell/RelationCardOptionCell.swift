//
//  RelationCardOptionCell.swift
//  QClub
//
//  Created by Dream on 9/18/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit


class RelationCardOptionCell: UICollectionViewCell {
   
    @IBOutlet weak var todayCandidatesBtn: UIButton!
    @IBOutlet weak var getQ1Btn: UIButton!
    @IBOutlet weak var getTopMemberShipBtn: UIButton!
    @IBOutlet weak var todayHistoryBtn: UIButton!
    
    var callBackGetTodayCandidates:(()->Void)?
    var callBackGetQ1:(()->Void)?
    var callBackGetTopMemberShip:(()->Void)?
    var callBackGetTodayHistory:(()->Void)?
    
    func setUI(){
        todayCandidatesBtn.layer.cornerRadius = 20
        todayCandidatesBtn.clipsToBounds = true
        
        getQ1Btn.layer.cornerRadius = 20
        getQ1Btn.clipsToBounds = true
        
        getTopMemberShipBtn.layer.cornerRadius = 20
        getTopMemberShipBtn.clipsToBounds = true
        
        todayHistoryBtn.layer.cornerRadius = 20
        todayHistoryBtn.clipsToBounds = true
    }
    
    
    @IBAction func getQ1Action(_ sender: Any) {
        callBackGetQ1?()
    }
    
    @IBAction func todayCandidatesAction(_ sender: Any) {
        callBackGetTodayCandidates?()
    }
    
    @IBAction func getTopMemberShipAction(_ sender: Any) {
        callBackGetTopMemberShip?()
    }
    
    @IBAction func todayHistoryAction(_ sender: Any) {
        callBackGetTodayHistory?()
    }
}

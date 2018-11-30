//
//  FriendlyScoreCell.swift
//  QClub
//
//  Created by SMR on 10/9/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class FriendlyScoreCell: ProfileBaseCell {

    @IBOutlet weak var collectionView: UICollectionView!
    var selectedCell = -1
    var member : Member?
    let data = ["1","2","3","4","5","6","7","8","9","10"]
    var selectedScoreAction: ((_ score: Int)->())?
    var postScoreAction: (()->())?
    var likAbility: LikabilityObject?
    @IBOutlet weak var okButton: CompleteButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsSelection = true
        self.okButton.changeState(isActive: false)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(member: Member, likAbility: LikabilityObject?) {
        self.member = member
        self.likAbility = likAbility
        if let likAbilityUnwrap = likAbility {
            self.selectedCell = (likAbilityUnwrap.score ?? 0) - 1
            
            if let _ = likAbilityUnwrap.evaluationDate {
                self.collectionView.allowsSelection = false
                self.okButton.changeState(isActive: false)
            }
            checkStateOkButton(likAbility: likAbility)
            self.collectionView.reloadData()
        }
    }
    
    func checkStateOkButton(likAbility: LikabilityObject?) {
        if let likAbilityUnwrap = self.likAbility {
            if let _ = likAbilityUnwrap.evaluationDate {
                self.okButton.changeState(isActive: false)
            } else {
                if likAbilityUnwrap.impression != nil && likAbilityUnwrap.impression?.count == 3 && selectedCell >= 0 {
                    self.okButton.changeState(isActive: true)
                } else {
                    self.okButton.changeState(isActive: false)
                }
            }
        } else {
            self.okButton.changeState(isActive: false)
            self.likAbility = likAbility
        }
    }
    
    func updateLikAbility(likAbility: LikabilityObject) {
        self.likAbility = likAbility
        if let _ = likAbility.evaluationDate {
            self.collectionView.allowsSelection = false
            self.okButton.changeState(isActive: false)
        }
    }

    @IBAction func postScore(_ sender: Any) {
        postScoreAction?()
    }
}
extension FriendlyScoreCell : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendlyScoreCollectionCell", for: indexPath) as! Join3CollectionViewCell
        cell.lbTitle.text =  data[indexPath.row]
        cell.configBackgroundForSelected(isSelected: indexPath.row == selectedCell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! Join3CollectionViewCell
        cell.configBackgroundForSelected(isSelected: true)
        selectedCell = indexPath.row
        selectedScoreAction?(indexPath.row + 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! Join3CollectionViewCell
        cell.configBackgroundForSelected(isSelected: false)
    }
    
}

extension FriendlyScoreCell : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
}

extension FriendlyScoreCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.collectionView.frame.size.width)/5 , height: self.collectionView.frame.size.width/10)
    }
}

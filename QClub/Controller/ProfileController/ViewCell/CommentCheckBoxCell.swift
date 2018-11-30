//
//  CommentCheckBoxCell.swift
//  QClub
//
//  Created by SMR on 10/9/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class CommentCheckBoxCell: ProfileBaseCell {
    var selectedCells = Set<Int>()
    var member : Member?
    var likability : LikabilityObject?
    var postLikAbilitySelected : ((_ selectedCells : Set<Int>)->())?
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var data = [MasterDataObject]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(member: Member, data: [MasterDataObject], likAbility: LikabilityObject?) {
        self.member = member
        self.data = data
        titleLabel.text = "\(member.nickname) 님의 사진과 프로필을 보고 떠오른 이미지는? (3개 선택가능)"
        if let likAbilityUnwrap = likAbility {
            if let impressions = likAbilityUnwrap.impression {
                for impression in impressions {
                    self.selectedCells.insert(impression.impressionDetail ?? 0)
                }
            }
            if let _ = likAbilityUnwrap.evaluationDate {
                self.collectionView.allowsSelection = false
            } else {
                self.collectionView.allowsSelection = true
            }
        }
        self.collectionView.reloadData()
    }
    
    
    func updateLikAbility(likAbility: LikabilityObject) {
        if let _ = likAbility.evaluationDate {
            self.collectionView.allowsSelection = false
        } else {
            self.collectionView.allowsSelection = true
        }
    }

}

extension CommentCheckBoxCell : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentCheckboxCollectionCell", for: indexPath) as! Join3CollectionViewCell
        cell.lbTitle.text = data[indexPath.row].detailName
        cell.configBackgroundForSelected(isSelected: selectedCells.contains(data[indexPath.row].detailSeq ?? 0))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedCells.count >= 3 {
            collectionView.deselectItem(at: indexPath, animated: false)
            return
        }
        let cell = collectionView.cellForItem(at: indexPath) as! Join3CollectionViewCell
        cell.configBackgroundForSelected(isSelected: true)
        selectedCells.insert(data[indexPath.row].detailSeq ?? 0)
        postLikAbilitySelected?(self.selectedCells)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! Join3CollectionViewCell
        cell.configBackgroundForSelected(isSelected: false)
        selectedCells.remove(data[indexPath.row].detailSeq ?? 0)
        postLikAbilitySelected?(self.selectedCells)
    }
    
}

extension CommentCheckBoxCell : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
}

extension CommentCheckBoxCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.collectionView.frame.size.width)/4 - 0.25 , height: self.collectionView.frame.size.width/6)
    }
}

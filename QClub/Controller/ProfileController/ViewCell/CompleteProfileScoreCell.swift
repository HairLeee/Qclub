//
//  CompleteProfileScoreCell.swift
//  QClub
//
//  Created by SMR on 10/9/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class CompleteProfileScoreCell: ProfileBaseCell {

    var selectedCell = -1
    let data = ["1","2","3","4","5","6","7","8","9","10"]
    var member: Member?
    var postCompletionScore : ((_ score : Int) -> ())?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setData(member: Member, completionObject: CompletionObject?) {
        self.member = member
        updateScore(completionObject: completionObject)
    }
    
    func updateScore(completionObject: CompletionObject?) {
        if let completionObjectUnwrap = completionObject {
            self.selectedCell = (completionObjectUnwrap.score ?? 0) - 1
            if self.selectedCell > -1 {
                self.collectionView.selectItem(at: IndexPath.init(row: self.selectedCell, section: 0), animated: false, scrollPosition: .centeredHorizontally)
            }
            self.collectionView.reloadData()
        }
    }


}

extension CompleteProfileScoreCell : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompleteProfileScoreCollectionCell", for: indexPath) as! Join3CollectionViewCell
        cell.lbTitle.text =  data[indexPath.row]
        cell.configBackgroundForSelected(isSelected: indexPath.row == selectedCell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! Join3CollectionViewCell
//        cell.configBackgroundForSelected(isSelected: true)
        selectedCell = indexPath.row
        postCompletionScore?(selectedCell + 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! Join3CollectionViewCell
        cell.configBackgroundForSelected(isSelected: false)
    }
    
}

extension CompleteProfileScoreCell : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
}

extension CompleteProfileScoreCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.collectionView.frame.size.width)/5 , height: self.collectionView.frame.size.width/10)
    }
}

//
//  MidCell.swift
//  QClub
//
//  Created by Dreamup on 10/10/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class MidCell: UITableViewCell {

    
    var isMan = false
    var selectedCells = Set<Int>()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let dataMan = ["듬직하다", "남자지만 섹시하다", "애교가 많아 보인다", "귀엽다",
                   "지적이다", "미소가 멋지다", "베이비페이스다", "도도해보인다",
                   "남자다워 보인다", "선해보인다", "스포티해보인다", "부자일 것 같다",
                   "여자가 많아 보인다", "의리파일 것 같다", "왕고집쟁이같다", "지고지순 한 여자만 바라볼 것 같다",
                   "깔끔쟁이 깨끗해보인다", "늦잠꾸러기일 것 같다","코를 심하게 골 것 같다", "여자사람친구가 많을 것 같다",
                   "선물을 좋아할 것 같다", "공부를 잘했을 것 같다","진지하고 신중해보인다","열정파일 것 같다",
                   "유머러스할 것 같다", "기분파일 것 같다", "책은 잠자기 위해서 보는 것 같다", "괴짜 같다",
                   "차가워보이지만 속마음은 따뜻할 것 같다", "선물을 잘 사줄 것 같다", "진실해보인다", "왠지 끌린다","듬직하다", "남자지만 섹시하다", "애교가 많아 보인다", "귀엽다", ]
    
    let dataWoman = ["섹시하다", "애교가 많아 보인다", "귀엽다", "지적이다",
                     "미소가 이쁘다", "베이비페이스다", "청순해보인다", "도도해보인다",
                     "여성스럽다", "선해보인다", "스포티해보인다", "부자일 것 같다",
                     "남자가 많아 보인다", "의리파일 것 같다", "왕고집쟁이 같다", "지고지순 한남자만 바라볼 것 같다",
                     "깔끔쟁이 깨끗해보인다", "늦잠꾸러기일 것 같다", "코를 심하게 골 것 같다", "남자사람친구가 많을 것 같다",
                     "선물을 좋아할 것 같다", "공부를 잘했을 것 같다", "진지하고 신중해보인다", "열정파일 것 같다",
                     "유머러스할 것 같다", "기분파일 것 같다", "책은 잠자기 위해서 보는 것 같다", "괴짜 같다. 차가워 보이지만",
                     "속마음은 따뜻할 것 같다", "선물을 잘 사줄 것 같다", "진실해보인다", "왠지 끌린다","듬직하다", "남자지만 섹시하다", "애교가 많아 보인다", "귀엽다",]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
    }
    
    
    func  bidingData ()  {
        
        print("MidCell ~~~~~")
        
    }
    

}

extension MidCell : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentCheckboxCollectionCell", for: indexPath) as! Join3CollectionViewCell
//        cell.lbTitle.text =  isMan ? dataMan[indexPath.row] : dataWoman[indexPath.row]
        cell.configBackgroundForSelected(isSelected: selectedCells.contains(indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedCells.count >= 3 {
            collectionView.deselectItem(at: indexPath, animated: false)
            return
        }
        let cell = collectionView.cellForItem(at: indexPath) as! Join3CollectionViewCell
        cell.configBackgroundForSelected(isSelected: true)
        selectedCells.insert(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! Join3CollectionViewCell
        cell.configBackgroundForSelected(isSelected: false)
        selectedCells.remove(indexPath.row)
    }
    
}

extension MidCell : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isMan ? dataMan.count : dataWoman.count
    }
}

extension MidCell : UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize.init(width: (self.collectionView.frame.size.width)/4 , height: self.collectionView.frame.size.width/6)
    }

}


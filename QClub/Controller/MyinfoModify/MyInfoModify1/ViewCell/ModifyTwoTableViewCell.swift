//
//  ModifyTwoTableViewCell.swift
//  QClub
//
//  Created by Dreamup on 10/25/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class ModifyTwoTableViewCell: UITableViewCell {
    
    
    var isMan = false
    var selectedCells = Set<Int>()
    var IndexChoosed = [Int]()
    @IBOutlet weak var collectionView: UICollectionView!
    var delegate:protocolCollectionViewChang?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        
        collectionView.register(UINib.init(nibName: "AreaCell", bundle: nil), forCellWithReuseIdentifier: "AreaCelll")
        
        getSourceInfoList()
        
        
        
        
    }
    
    
    func  bidingData ()  {
        
        print("MidCell ~~~~~")
        
    }
    
    var styles = [String]()
    func getSourceInfoList() {
        AuthService.getMasterData(masterSeq: Constants.MasterCode.Style, completion: { [weak self](response) in
            
            guard let _self = self else{return}
            
            if let data = response.data as? [MasterDataObject] {
                _self.styles =  data.map{$0.detailName ?? ""}
               
                
                
//                for i in 0 ..< 4 {
//                      _self.selectedCells.insert(i)
//                }
//
                 _self.collectionView.reloadData()
                
            }
        }) { (error) in
            
        }
    }
    
    
}

extension ModifyTwoTableViewCell : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AreaCelll", for: indexPath) as! AreaCelll
        cell.lbName.text =  styles[indexPath.row]
       

        
//        for i in 0 ..< 4 {
//            if i == indexPath.row {
//                collectionView.selectItem(at: indexPath, animated: false, scrollPosition: UICollectionViewScrollPosition.centeredHorizontally)
//
//                print("row ~~ \(indexPath.row)")
//            }
//
//        }
        
         cell.configBackgroundForSelected(isSelected: selectedCells.contains(indexPath.row))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedCells.count >= 5 {
            collectionView.deselectItem(at: indexPath, animated: false)
            return
        }
        let cell = collectionView.cellForItem(at: indexPath) as! AreaCelll
        cell.configBackgroundForSelected(isSelected: true)
        selectedCells.insert(indexPath.row)
    
        IndexChoosed.append(indexPath.row)
        delegate?.whenActionChange(styles: IndexChoosed)
        print("CLick \(indexPath.row)")
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! AreaCelll
        cell.configBackgroundForSelected(isSelected: false)
        selectedCells.remove(indexPath.row)
        
        if let index = IndexChoosed.index(of: indexPath.row) {
             IndexChoosed.remove(at: index)
            
            print("index === \(index)")
        }
        
       
          delegate?.whenActionChange(styles: IndexChoosed)
        print("UncLick  \(indexPath.row)")
    }
    
}

extension ModifyTwoTableViewCell : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return styles.count
    }
}

extension ModifyTwoTableViewCell : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.collectionView.frame.size.width)/4 , height: self.collectionView.frame.size.width/6)
    }
    
}

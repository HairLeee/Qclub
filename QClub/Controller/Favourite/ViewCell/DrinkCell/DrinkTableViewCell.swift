//
//  DrinkTableViewCell.swift
//  QClub
//
//  Created by Dreamup on 10/17/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class DrinkTableViewCell: UITableViewCell {
    
    
    var isMan = false
    var onItemClick:OnItemClick?
    
    
    
    @IBOutlet weak internal var viewConstant: NSLayoutConstraint!
    
    @IBOutlet weak internal var collectionViewTop: NSLayoutConstraint!
    
    @IBOutlet weak internal var collectionViewBottom: NSLayoutConstraint!
    
    
    @IBOutlet weak internal var collectionView: UICollectionView!
    
    
    @IBOutlet var cbObtion: Checkbox!
    
    
    struct cellIdentifier {
        static let cellId = "cellDrink"
        static let cellIdEmpty = "HeightEmptyCollectionViewCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
        getSourceInfoList()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupLayout(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        
        collectionView.register(UINib.init(nibName: "DrinkCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier.cellId)
        
        collectionView.register(UINib.init(nibName: "HeightEmptyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier.cellIdEmpty)
        
        Utils.addCheckbox(privacyCheckBox: cbObtion, tag: 1)
    }
    
    func getFinalTitle() -> String {
        var pTitle = ""
        if drinks.count > 0 {
            
            for i in 0 ..< mData.drinkingDetailChar.count {
                if pTitle == "" {
                    pTitle = drinks[Int(mData.drinkingDetailChar[0])!-1]
                } else {
                    pTitle = pTitle + "," + drinks[Int(mData.drinkingDetailChar[i])! - 1]
                    
                }
            }
            
            if pTitle == "" {
                pTitle = "무관"
            }
        }
        
        return pTitle
    }
    
    var drinks = [String]()
    
    func getSourceInfoList() {
        AuthService.getMasterData(masterSeq: Constants.MasterCode.Drink, completion: { [weak self](response) in
            
            guard let _self = self else{return}
            
            if let data = response.data as? [MasterDataObject] {
                _self.drinks =  data.map{$0.detailName ?? ""}
                _self.collectionView.reloadData()
                
            }
        }) { (error) in
            
        }
    }
    
    var isExpand = false
    var mData = FavouriteValues()
    func bidingData(isHidden:Bool, data: FavouriteValues,_ title:String)  {
        isExpand = isHidden
        mData = data
        for i in 0 ..< mData.drinkingDetailChar.count {
            if mData.drinkingDetailChar[i] == "무관" {
                mData.drinkingDetailChar.remove(at: i)
            }
        }
        print(" DrinkTableViewCell bidingData \(mData.drinkingDetailChar) ")
        let stringArray = mData.drinkingDetailChar.flatMap { String($0) }
        let style = stringArray.joined(separator: ",")
        lbResult.text = getFinalTitle()
        if style == "" {
            lbResult.text = "무관"
        }
        
        if !isExpand {
            viewConstant.constant = 0
            
            collectionViewTop.constant = 0
            collectionViewBottom.constant = 0
            
            collectionView.isHidden = true
            
        } else{
            viewConstant.constant = (self.collectionView.frame.size.width)/3+75
            
            collectionViewTop.constant = 20
            collectionViewBottom.constant = 20
            
            collectionView.isHidden = false
            
        }
        isExpand = !isExpand
        
        if mData.drinkingDetailChar.count > 0 {
            for i in 0 ..< mData.drinkingDetailChar.count {
                if let pIndex = Int(mData.drinkingDetailChar[i]) {
                    collectionView.selectItem(at: IndexPath.init(row: pIndex - 1, section: 0), animated: false, scrollPosition: UICollectionViewScrollPosition.init(rawValue: 0))
                }
            }
        }
        
        
    }
    
    @IBAction func btnExpandAction(_ sender: Any) {
        //        bidingData()
        onItemClick?.OnItemClickListener(indexOfRow: self.tag, isHidden:isExpand)
        
    }
    
    @IBOutlet var lbResult: UILabel!
    var isAllowToChoose = true
    func updateLayout(){
        let stringArray = mData.drinkingDetailChar.flatMap { String($0) }
        let style = stringArray.joined(separator: ",")
        lbResult.text = getFinalTitle()
        if style == "" {
            lbResult.text = "무관"
        }
        onItemClick?.PushFavouriteDataToMain(data: style, typeOfFavorData: 6)
    }
    
    @IBAction func cbObtion(_ sender: Any) {
        
        mData.drinkingDetailChar.removeAll()
        isAllowToChoose = !isAllowToChoose
        collectionView.reloadData()
        lbResult.text = "무관"
        onItemClick?.PushFavouriteDataToMain(data:"무관", typeOfFavorData: 6)
    }
    
    
}

extension DrinkTableViewCell : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drinks.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row < drinks.count {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier.cellId, for: indexPath) as! DrinkCollectionViewCell
            
            cell.lbName.text = drinks[indexPath.row]
            cell.configBackgroundForSelected(isSelected: mData.drinkingDetailChar.contains(drinks[indexPath.row]))
            
            
            
            
            if isAllowToChoose {
                cell.lbName.textColor = UIColor.init(hexString: "#616060")
                cell.lbName.text =  drinks[indexPath.row]
                
            } else {
                
                cell.lbName.textColor = UIColor.init(hexString: "#cccccc")
                cell.lbName.text =  drinks[indexPath.row]
                
            }
            
            if mData.drinkingDetailChar.count > 0 {
                for i in 0 ..< mData.drinkingDetailChar.count  {
                    if let index = Int(mData.drinkingDetailChar[i]) {
                        if index == indexPath.row + 1 {
                            cell.configBackgroundForSelected(isSelected: true)
                        }
                    }
                    
                }
            }
            
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier.cellIdEmpty, for: indexPath) as! HeightEmptyCollectionViewCell
            
            return cell
        }
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        if indexPath.row  != 5 {
        //        if mData.drinkingDetailChar.count >= 1 || !isAllowToChoose {
        //            collectionView.deselectItem(at: indexPath, animated: false)
        //            return
        //        }
        
        if !isAllowToChoose { return}
        if let cell = collectionView.cellForItem(at: indexPath) as? DrinkCollectionViewCell {
            cell.configBackgroundForSelected(isSelected: true)
            
            mData.drinkingDetailChar.append(String(indexPath.row + 1 ))
            updateLayout()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if !isAllowToChoose { return}
        if let cell = collectionView.cellForItem(at: indexPath) as? DrinkCollectionViewCell {
            
            cell.configBackgroundForSelected(isSelected: false)
            
            for i in (0 ... mData.drinkingDetailChar.count-1).reversed() {
                
                if mData.drinkingDetailChar[i] == String(indexPath.row + 1) {
                    
                    mData.drinkingDetailChar.remove(at: i)
                }
            }
            updateLayout()
            
        }
   
        
    }
}

extension DrinkTableViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.collectionView.frame.size.width)/3 , height: self.collectionView.frame.size.width/6)
    }
    
    
}

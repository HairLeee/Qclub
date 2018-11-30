//
//  HeightTableViewCell.swift
//  QClub
//
//  Created by Dreamup on 10/16/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class HeightTableViewCell: UITableViewCell {
    
    
    var isMan = false
    var onItemClick:OnItemClick?
    
    
    
    @IBOutlet weak internal var viewConstant: NSLayoutConstraint!
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak internal var collectionViewTop: NSLayoutConstraint!
    
    @IBOutlet weak internal var collectionViewBottom: NSLayoutConstraint!
    
    @IBOutlet weak internal var viewContentMain: UIView!
    
    @IBOutlet weak internal var collectionView: UICollectionView!
    
    
    @IBOutlet var lbCmHeight: UILabel!
    
    @IBOutlet var cbObtion: Checkbox!
    
    @IBOutlet var lbResult: UILabel!
    
    struct cellIdentifier {
        static let cellId = "HeightCollectionViewCell"
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
        
        collectionView.register(UINib.init(nibName: "HeightCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier.cellId)
        collectionView.register(UINib.init(nibName: "HeightEmptyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier.cellIdEmpty)
        
        Utils.addCheckbox(privacyCheckBox: cbObtion, tag: 1)
    }
    
    func getFinalTitle() -> String {
        var pTitle = ""
        if heights.count > 0 {
            
            for i in 0 ..< mData.heightDetailChar.count {
                if pTitle == "" {
                    pTitle = heights[Int(mData.heightDetailChar[0])!-1]
                } else {
                    pTitle = pTitle + "," + heights[Int(mData.heightDetailChar[i])! - 1]
                    
                }
            }
            
            if pTitle == "" {
                pTitle = "무관"
            }
        }
        
        return pTitle
    }
    
    var heights = [String]()
    func getSourceInfoList() {
        AuthService.getMasterData(masterSeq: Constants.MasterCode.Key, completion: { [weak self](response) in
            
            guard let _self = self else{return}
            
            if let data = response.data as? [MasterDataObject] {
                _self.heights =  data.map{$0.detailName ?? ""}
                _self.collectionView.reloadData()
                
            }
        }) { (error) in
            
        }
    }
    
    var isExpand = false
    var mData = FavouriteValues()
    func bidingData(isHidden:Bool, data: FavouriteValues,_ title:String)  {
        mData = data
        isExpand = isHidden
        for i in 0 ..< mData.heightDetailChar.count {
            if mData.heightDetailChar[i] == "무관" {
                mData.heightDetailChar.remove(at: i)
            }
        }
        let stringArray = mData.heightDetailChar.flatMap { String($0) }
        
        let style = stringArray.joined(separator: ",")
        lbResult.text =  getFinalTitle()
        if style == "" {
            lbResult.text = "무관"
        }
        
        if !isExpand {
            lbTitle.text = ""
            cbObtion.isHidden = true
            viewConstant.constant = 0
            collectionViewTop.constant = 0
            collectionViewBottom.constant = 0
            collectionView.isHidden = true
            
        } else{
            lbTitle.text = "무관"
            cbObtion.isHidden = false
            viewConstant.constant = (self.collectionView.frame.size.width)/2+75
            collectionViewTop.constant = 20
            collectionViewBottom.constant = 20
            collectionView.isHidden = false
            
        }
        isExpand = !isExpand
        
        
        if mData.heightDetailChar.count > 0 {
            for i in 0 ..< mData.heightDetailChar.count {
                if let pIndex = Int(mData.heightDetailChar[i]) {
                    collectionView.selectItem(at: IndexPath.init(row: pIndex - 1, section: 0), animated: false, scrollPosition: UICollectionViewScrollPosition.init(rawValue: 0))
                }
                
            }
        }
        
        
    }
    
    @IBAction func btnExpandAction(_ sender: Any) {
        //        bidingData()
        onItemClick?.OnItemClickListener(indexOfRow: self.tag, isHidden:isExpand)
        
    }
    
    var isAllowToChoose = true
    func updateLayout(){
        let stringArray = mData.heightDetailChar.flatMap { String($0) }
        let style = stringArray.joined(separator: ",")
        
        if style == "" {
            lbResult.text = "무관"
        }
        onItemClick?.PushFavouriteDataToMain(data: style, typeOfFavorData: 3)
        
        lbResult.text = getFinalTitle()
        //           lbCmHeight.text = " 단위 : \(mData.heightDetailChar.count) cm"
        
    }
    
    @IBAction func cbObtion(_ sender: Any) {
        
        mData.heightDetailChar.removeAll()
        isAllowToChoose = !isAllowToChoose
        collectionView.reloadData()
        lbResult.text = "무관"
        onItemClick?.PushFavouriteDataToMain(data: "0", typeOfFavorData: 3)
    }
    
    
}

extension HeightTableViewCell : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row < heights.count {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier.cellId, for: indexPath) as! HeightCollectionViewCell
            
            cell.lbName.text =  heights[indexPath.row]
            cell.configBackgroundForSelected(isSelected: mData.heightDetailChar.contains(heights[indexPath.row]))
            
            if isAllowToChoose {
                cell.lbName.textColor = UIColor.init(hexString: "#616060")
                cell.lbName.text =  heights[indexPath.row]
                
            } else {
                cell.lbName.textColor = UIColor.init(hexString: "#cccccc")
                cell.lbName.text =  heights[indexPath.row]
                
            }
            
            if mData.heightDetailChar.count > 0 {
                for i in 0 ..< mData.heightDetailChar.count  {
                    if let index = Int(mData.heightDetailChar[i]) {
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
        if !isAllowToChoose { return}
        if indexPath.row != 8 {
            if mData.heightDetailChar.count >= 1  || !isAllowToChoose {
                collectionView.deselectItem(at: indexPath, animated: false)
                return
            }
            
            if let cell = collectionView.cellForItem(at: indexPath) as? HeightCollectionViewCell {
                if mData.heightDetailChar.contains(heights[indexPath.row]) {
                    
                    cell.configBackgroundForSelected(isSelected: false)
                    for i in (0 ... mData.heightDetailChar.count-1).reversed() {
                        
                        if mData.heightDetailChar[i] == heights[indexPath.row] {
                            
                            mData.heightDetailChar.remove(at: i)
                            
                        }
                    }
                } else {
                    
                    cell.configBackgroundForSelected(isSelected: true)
                    mData.heightDetailChar.append(String(indexPath.row+1))
                }
                
                updateLayout()
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if !isAllowToChoose { return}
        if indexPath.row != 8 {
            
            if let cell = collectionView.cellForItem(at: indexPath) as? HeightCollectionViewCell {
                cell.configBackgroundForSelected(isSelected: false)
                
                for i in (0 ... mData.heightDetailChar.count-1).reversed() {
                    
                    if mData.heightDetailChar[i] == String(indexPath.row+1) {
                        
                        mData.heightDetailChar.remove(at: i)
                    }
                }
                updateLayout()
                
            }
            
        }
    }
}

extension HeightTableViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.collectionView.frame.size.width)/3 , height: self.collectionView.frame.size.width/6)
    }
    
    
}

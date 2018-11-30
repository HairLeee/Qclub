//
//  StyleTableViewCell.swift
//  QClub
//
//  Created by Dreamup on 10/13/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class StyleTableViewCell: UITableViewCell {
    
    
    
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var isMan = false
    var onItemClick:OnItemClick?
    
    
    @IBOutlet weak var collectionViewTop: NSLayoutConstraint!
    
    @IBOutlet weak var collectionViewBottom: NSLayoutConstraint!
    
    @IBOutlet var lbResult: UILabel!
    
    @IBOutlet weak var viewConstant: NSLayoutConstraint!
    
    @IBOutlet var cbObtion: Checkbox!
    var styles = [String]()
    
    struct cellIdentifier {
        static let cellId = "StyleCell"
    }
    
    
    func setupLayout(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        
        collectionView.register(UINib.init(nibName: "StyleCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier.cellId)
        
        Utils.addCheckbox(privacyCheckBox: cbObtion, tag: 1)
    }
    
    var isExpand = false
    
    var mTitle = ""
    var mData = FavouriteValues()
    func bidingData(isHidden:Bool, data: FavouriteValues,_ title:String)  {
        
        
        mData = data
        for i in 0 ..< mData.styleDetailChar.count {
            if mData.styleDetailChar[i] == "무관" {
                mData.styleDetailChar.remove(at: i)
            }
        }
        let stringArray = mData.styleDetailChar.flatMap { String($0) }
        mTitle = stringArray.joined(separator: ",")
        
        lbResult.text = getFinalTitle()
        if mTitle == "" {
            lbResult.text = "무관"
        }
        
        
        isExpand = isHidden
        if !isExpand {
            viewConstant.constant = 0
            
            collectionViewTop.constant = 0
            collectionViewBottom.constant = 0
            
            collectionView.isHidden = true
            
        } else{
            viewConstant.constant = (self.collectionView.frame.size.width*3/2)+75
            
            collectionViewTop.constant = 20
            collectionViewBottom.constant = 20
            
            collectionView.isHidden = false
            
        }
        isExpand = !isExpand
        
        if mData.styleDetailChar.count > 0 {
            for i in 0 ..< mData.styleDetailChar.count {
                if let pIndex = Int(mData.styleDetailChar[i]) {
                    collectionView.selectItem(at: IndexPath.init(row: pIndex - 1, section: 0), animated: false, scrollPosition: UICollectionViewScrollPosition.init(rawValue: 0))
                }
                
            }
        }
    }
    
    func getFinalTitle() -> String {
        var pTitle = ""
        if styles.count > 0 {
            
            for i in 0 ..< mData.styleDetailChar.count {
                if pTitle == "" {
                    pTitle = styles[Int(mData.styleDetailChar[0])!-1]
                } else {
                    pTitle = pTitle + "," + styles[Int(mData.styleDetailChar[i])! - 1]
                    
                }
            }
            
            if pTitle == "" {
                pTitle = "무관"
            }
        }
        
        return pTitle.replacingOccurrences(of: "\n", with: "")
    }
    
    
    func getSourceInfoList() {
        AuthService.getMasterData(masterSeq: Constants.MasterCode.Style, completion: { [weak self](response) in
            
            guard let _self = self else{return}
            
            if let data = response.data as? [MasterDataObject] {
                _self.styles =  data.map{$0.detailName ?? ""}
                _self.collectionView.reloadData()
                
            }
        }) { (error) in
            
        }
    }
    
    @IBAction func btnExpandAction(_ sender: Any) {
        updateLayout()
        onItemClick?.OnItemClickListener(indexOfRow: self.tag, isHidden:isExpand)
        
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
    
    
    var isAllowToChoose = true
    @IBAction func cbObtion(_ sender: Any) {
        
        mData.styleDetailChar.removeAll()
        isAllowToChoose = !isAllowToChoose
        collectionView.reloadData()
        lbResult.text = "무관"
        onItemClick?.PushFavouriteDataToMain(data:"무관", typeOfFavorData: 2)
        
    }
    
    
    func updateLayout(){
        
        let stringArray = mData.styleDetailChar.flatMap { String($0) }
        mTitle = stringArray.joined(separator: ",")
        
        if mTitle == "" {
            lbResult.text = "0"
        }
        
        lbResult.text = getFinalTitle()
        
        onItemClick?.PushFavouriteDataToMain(data: mTitle, typeOfFavorData: 2)
    }
    
}

extension  String{
    
    func removeHtmlFromString(inPutString: String) -> String{
        
        return inPutString.replacingOccurrences(of: "<[^>]+>br/", with: "", options: .regularExpression, range: nil)
    }
}

extension StyleTableViewCell : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return styles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier.cellId, for: indexPath) as! StyleCell

        cell.configBackgroundForSelected(isSelected: mData.styleDetailChar.contains(styles[indexPath.row]))
        
        if isAllowToChoose {
            cell.lbName.textColor = UIColor.init(hexString: "#616060")
            cell.lbName.text =  styles[indexPath.row].replacingOccurrences(of: "<br/>", with: "")
            
        } else {
            
            cell.lbName.textColor = UIColor.init(hexString: "#cccccc")
            cell.lbName.text = styles[indexPath.row].replacingOccurrences(of: "<br/>", with: "")
            
        }
        
        if mData.styleDetailChar.count > 0 {
            for i in 0 ..< mData.styleDetailChar.count  {
                if let index = Int(mData.styleDetailChar[i]) {
                    if index == indexPath.row + 1 {
                        cell.configBackgroundForSelected(isSelected: true)
                    }
                }
                
            }
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if mData.styleDetailChar.count >= 3 || !isAllowToChoose {
            collectionView.deselectItem(at: indexPath, animated: false)
            return
        }
        
        if !isAllowToChoose { return}
        
        
        let cell = collectionView.cellForItem(at: indexPath) as! StyleCell
        if mData.styleDetailChar.contains(styles[indexPath.row]) {
            
            cell.configBackgroundForSelected(isSelected: false)
            for i in (0 ... mData.styleDetailChar.count-1).reversed() {
                
                if mData.styleDetailChar[i] == styles[indexPath.row] {
                    
                    mData.styleDetailChar.remove(at: i)
                    
                }
            }
        } else {
            
            cell.configBackgroundForSelected(isSelected: true)
            mData.styleDetailChar.append(String(indexPath.row + 1))
        }
        
        updateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! StyleCell
        if !isAllowToChoose { return}
        cell.configBackgroundForSelected(isSelected: false)
        
        for i in (0 ... mData.styleDetailChar.count-1).reversed() {
            
            if mData.styleDetailChar[i] == String(indexPath.row  + 1) {
                
                mData.styleDetailChar.remove(at: i)
            }
        }
        updateLayout()
    }
    
    
}

extension StyleTableViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.collectionView.frame.size.width)/4 , height: self.collectionView.frame.size.width/6)
    }
    
    
}

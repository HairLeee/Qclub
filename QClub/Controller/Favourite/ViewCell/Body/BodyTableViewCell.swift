//
//  BodyTableViewCell.swift
//  QClub
//
//  Created by Dreamup on 10/16/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class BodyTableViewCell: UITableViewCell {
    
    
    var isMan = false
    var onItemClick:OnItemClick?

    
    
    @IBOutlet weak internal var viewConstant: NSLayoutConstraint!
    
    @IBOutlet weak internal var collectionViewTop: NSLayoutConstraint!
    
    @IBOutlet weak internal var collectionViewBottom: NSLayoutConstraint!
    
    @IBOutlet weak internal var viewContentMain: UIView!
    
    @IBOutlet weak internal var collectionView: UICollectionView!
    
    
    @IBOutlet var lbResult: UILabel!
    
    @IBOutlet var cbObtion: Checkbox!
    
    struct cellIdentifier {
        static let cellId = "cellBody"
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
        
        collectionView.register(UINib.init(nibName: "BodyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier.cellId)
        Utils.addCheckbox(privacyCheckBox: cbObtion, tag: 1)
        
    }
    
    func getFinalTitle() -> String {
        var pTitle = ""
        if bodies.count > 0 {
            
            for i in 0 ..< mData.bodyDetailChar.count {
                if pTitle == "" {
                    pTitle = bodies[Int(mData.bodyDetailChar[0])!-1]
                } else {
                    pTitle = pTitle + "," + bodies[Int(mData.bodyDetailChar[i])! - 1]
                    
                }
            }
            
            if pTitle == "" {
                pTitle = "무관"
            }
        }
        
        return pTitle
    }
    
    var bodies = [String]()

    func getSourceInfoList() {
        AuthService.getMasterData(masterSeq: Constants.MasterCode.Body, completion: { [weak self](response) in
            
            guard let _self = self else{return}
            
            if let data = response.data as? [MasterDataObject] {
                _self.bodies =  data.map{$0.detailName ?? ""}
                _self.collectionView.reloadData()
                
            }
        }) { (error) in
            
        }
    }
    
    var isExpand = false
    
    var mTitle = ""
    var mData = FavouriteValues()
    func bidingData(isHidden:Bool, data: FavouriteValues,_ title:String)  {
        mData = data
        isExpand = isHidden
        for i in 0 ..< mData.bodyDetailChar.count {
            if mData.bodyDetailChar[i] == "무관" {
                mData.bodyDetailChar.remove(at: i)
            }
        }
        
        let stringArray = mData.bodyDetailChar.flatMap { String($0) }
        mTitle = stringArray.joined(separator: ",")
        lbResult.text = getFinalTitle()
        if mTitle == "" {
            lbResult.text = "무관"
        }
      
        if !isExpand {
            viewConstant.constant = 0
            
            collectionViewTop.constant = 0
            collectionViewBottom.constant = 0
            
            collectionView.isHidden = true
            
        } else{
            viewConstant.constant = (self.collectionView.frame.size.width)/2+75
            
            collectionViewTop.constant = 20
            collectionViewBottom.constant = 20
            
            collectionView.isHidden = false
            
        }
        isExpand = !isExpand
        if mData.bodyDetailChar.count > 0 {
            for i in 0 ..< mData.bodyDetailChar.count {
                if let pIndex = Int(mData.bodyDetailChar[i]) {
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
        let stringArray = mData.bodyDetailChar.flatMap { String($0) }
        mTitle = stringArray.joined(separator: ",")
        lbResult.text = getFinalTitle()
        if mTitle == "" {
            lbResult.text = "무관"
        }
          onItemClick?.PushFavouriteDataToMain(data: mTitle, typeOfFavorData: 4)
    }
    
    @IBAction func cbObtion(_ sender: Any) {

        mData.bodyDetailChar.removeAll()
        isAllowToChoose = !isAllowToChoose
        collectionView.reloadData()
        lbResult.text = "무관"
         onItemClick?.PushFavouriteDataToMain(data: "무관", typeOfFavorData: 4)
    }
    
    
}

extension BodyTableViewCell : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bodies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        print("Item == \(indexPath.row)")
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier.cellId, for: indexPath) as! BodyCollectionViewCell
        
        cell.lbName.text = bodies[indexPath.row]
   
        cell.configBackgroundForSelected(isSelected: mData.bodyDetailChar.contains(bodies[indexPath.row]))
        if isAllowToChoose {
            cell.lbName.textColor = UIColor.init(hexString: "#616060")
            cell.lbName.text =  bodies[indexPath.row]
          
        } else {
       
            cell.lbName.textColor = UIColor.init(hexString: "#cccccc")
            cell.lbName.text =  bodies[indexPath.row]
            
        }
        
        if mData.bodyDetailChar.count > 0 {
            for i in 0 ..< mData.bodyDetailChar.count  {
                if let index = Int(mData.bodyDetailChar[i]) {
                    if index == indexPath.row + 1 {
                        cell.configBackgroundForSelected(isSelected: true)
                    }
                }
                
            }
        }
        
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          if !isAllowToChoose { return}
        if mData.bodyDetailChar.count >= 1 || !isAllowToChoose {
            collectionView.deselectItem(at: indexPath, animated: false)
            return
        }
        
        
        let cell = collectionView.cellForItem(at: indexPath) as! BodyCollectionViewCell
        cell.configBackgroundForSelected(isSelected: true)
    
        mData.bodyDetailChar.append(String(indexPath.row + 1))
        updateLayout()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
          if !isAllowToChoose { return}
        let cell = collectionView.cellForItem(at: indexPath) as! BodyCollectionViewCell
        cell.configBackgroundForSelected(isSelected: false)
     
        for i in (0 ... mData.bodyDetailChar.count-1).reversed() {
            
            if mData.bodyDetailChar[i] == String(indexPath.row + 1) {
                
                mData.bodyDetailChar.remove(at: i)
            }
        }
        updateLayout()
        
    }
}

extension BodyTableViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.collectionView.frame.size.width)/3 , height: self.collectionView.frame.size.width/6)
    }
}

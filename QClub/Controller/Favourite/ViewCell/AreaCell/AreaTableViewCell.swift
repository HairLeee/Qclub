//
//  AreaTableViewCell.swift
//  QClub
//
//  Created by Dreamup on 10/13/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit




class AreaTableViewCell: UITableViewCell {
    var isAllowToChoose = true
    var isMan = false
    var onItemClick:OnItemClick?
    //    var selectedCells = Set<Int>()

    
    @IBOutlet weak var privacyCheckBox: Checkbox!
    
    @IBOutlet weak var viewConstant: NSLayoutConstraint!
    
    
    @IBOutlet weak var collectionViewTop: NSLayoutConstraint!
    
    @IBOutlet weak var collectionViewBottom: NSLayoutConstraint!
    @IBOutlet weak var viewContentMain: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet var lbStyles: UILabel!
    var areas = [String]()
    var listIndexOfValueChoosed = [Int]()
    var hasFinishedLoadDataFromCell:hasFinishedLoadDataFromCell?
    struct cellIdentifier {
        static let cellId = "AreaCell"
        static let cellIdEmpty = "HeightEmptyCollectionViewCell"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
//       addCheckbox()
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
        
        collectionView.register(UINib.init(nibName: "AreaCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier.cellId)
            collectionView.register(UINib.init(nibName: "HeightEmptyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier.cellIdEmpty)
        Utils.addCheckbox(privacyCheckBox: privacyCheckBox, tag: 1)
        //        checkboxChangeOutlet.isChecked = true
        //        checkboxChangeOutlet.isChecked = false
        
    }
    
    func getSourceInfoList() {
        AuthService.getMasterData(masterSeq: Constants.MasterCode.Location, completion: { [weak self](response) in
            
            guard let _self = self else{return}
            
            if let data = response.data as? [MasterDataObject] {
                _self.areas =  data.map{$0.detailName ?? ""}
                _self.collectionView.reloadData()
                _self.hasFinishedLoadDataFromCell?.hasFinishedLoadDataFromCell()
                
            }
        }) { (error) in
            
        }
    }
    
    
    @IBOutlet var checkboxChangeOutlet: Checkbox!
    @IBAction func checkboxChangeAction(_ sender: Any) {
        mData.locationDetailChar.removeAll()
        //        selectedCells.removeAll()
        isAllowToChoose = !isAllowToChoose
        collectionView.reloadData()
        lbStyles.text = "무관"
          onItemClick?.PushFavouriteDataToMain(data: "무관", typeOfFavorData: 1)
    }
    
    var isExpand = false
    var isFirstTimeComeHere = true
    var mTitle = ""
    var mData = FavouriteValues()
    func bidingData(isHidden:Bool, data: FavouriteValues,_ title:String)  {
        mData = data
        
//        for i in 0 ..< mData.locationDetailChar.count {
//            if mData.locationDetailChar[i] == "무관" {
//                mData.locationDetailChar.remove(at: i)
//            }
//        }
        if mData.locationDetailChar.contains("무관") {
            mData.locationDetailChar.removeAll()
        }
        let stringArray = mData.locationDetailChar.flatMap { String($0) }
        mTitle = stringArray.joined(separator: ",")
        
        lbStyles.text = getFinalTitle()
        if mTitle == "" {
            lbStyles.text = "무관"
        }
    
        isExpand = isHidden
        if !isExpand {
            viewConstant.constant = 0
            
            collectionViewTop.constant = 0
            collectionViewBottom.constant = 0
            
            collectionView.isHidden = true
            viewContentMain.isHidden = true
        } else{
            
            viewConstant.constant = (self.collectionView.frame.size.width*7/6)+75
            
            collectionViewTop.constant = 20
            collectionViewBottom.constant = 20
            
            collectionView.isHidden = false
            viewContentMain.isHidden = false
            
            
            
        }
        isExpand = !isExpand
        
//        if mData.locationDetailChar.count > 0 {
//            for i in 0 ..< mData.locationDetailChar.count  {
//                for j in 0 ..< areas.count {
//                    if mData.locationDetailChar[i] == areas[j] {
//
//                        break
//                    }
//                }
//
//            }
//        }
        if mData.locationDetailChar.count > 0 {
            for i in 0 ..< mData.locationDetailChar.count {
                if let pIndex = Int(mData.locationDetailChar[i]) {
                    collectionView.selectItem(at: IndexPath.init(row: pIndex - 1, section: 0), animated: false, scrollPosition: UICollectionViewScrollPosition.init(rawValue: 0))
                }

            }
        }
     

        
    }
    
    
    
    @IBAction func btnExpandAction(_ sender: Any) {
        updateLayout()
        onItemClick?.OnItemClickListener(indexOfRow: self.tag, isHidden:isExpand)
        
    }
    
    func updateLayout(){
        
        let stringArray = mData.locationDetailChar.flatMap { String($0) }
        mTitle = stringArray.joined(separator: ",")
               lbStyles.text = getFinalTitle()
        print("stringArray \(stringArray.count) \(mTitle)")

        onItemClick?.PushFavouriteDataToMain(data: mTitle, typeOfFavorData: 1)

        
    }
    
    func getFinalTitle() -> String {
        var pTitle = ""
        if areas.count > 0 {
          
            for i in 0 ..< mData.locationDetailChar.count {
                if pTitle == "" {
                    pTitle = areas[Int(mData.locationDetailChar[0])!-1]
                } else {
                    pTitle = pTitle + "," + areas[Int(mData.locationDetailChar[i])! - 1]
                    
                }
            }
            
            if pTitle == "" {
                pTitle = "무관"
            }
        }
       
        
        return pTitle
    }
    
}

extension AreaTableViewCell : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return areas.count + 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier.cellId, for: indexPath)
        
        
        if indexPath.row < areas.count {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier.cellId, for: indexPath) as! AreaCelll
            if isAllowToChoose {
                cell.lbName.textColor = UIColor.init(hexString: "#616060")
                cell.lbName.text =  areas[indexPath.row]
                cell.configBackgroundForSelected(isSelected: mData.locationDetailChar.contains(areas[indexPath.row]))
            } else {
                cell.configBackgroundForSelected(isSelected: mData.locationDetailChar.contains(areas[indexPath.row]))
                cell.lbName.textColor = UIColor.init(hexString: "#cccccc")
                cell.lbName.text =  areas[indexPath.row]
            }
            
            if mData.locationDetailChar.count > 0 {
                for i in 0 ..< mData.locationDetailChar.count  {
                    if let index = Int(mData.locationDetailChar[i]) {
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
        if mData.locationDetailChar.count >= 3 || !isAllowToChoose {
            collectionView.deselectItem(at: indexPath, animated: false)
            return
        }
//        let cell = collectionView.cellForItem(at: indexPath) as! AreaCelll
        
        
        if let cell = collectionView.cellForItem(at: indexPath) as? AreaCelll {
            if mData.locationDetailChar.contains(areas[indexPath.row]) {
                
                cell.configBackgroundForSelected(isSelected: false)
                for i in (0 ... mData.locationDetailChar.count-1).reversed() {
                    
                    if mData.locationDetailChar[i] == areas[indexPath.row] {
                        
                        mData.locationDetailChar.remove(at: i)
                        
                    }
                }
            } else {
                
                cell.configBackgroundForSelected(isSelected: true)
                mData.locationDetailChar.append(String(indexPath.row+1))
            }
        }

        
        updateLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {

        
        
        if let cell = collectionView.cellForItem(at: indexPath) as? AreaCelll {
            
            cell.configBackgroundForSelected(isSelected: false) 
            
            for i in (0 ..< mData.locationDetailChar.count).reversed() {
                if let index = Int(mData.locationDetailChar[i]) {
                    
                    if index == indexPath.row + 1 {
                        
                        mData.locationDetailChar.remove(at: i)
                        
                    }
                    
                }
                
            }
            
            
            updateLayout()
        }
        
     
    }
}

extension AreaTableViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.collectionView.frame.size.width)/4 , height: self.collectionView.frame.size.width/6)
    }
    
    
}




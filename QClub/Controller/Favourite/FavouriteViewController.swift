//
//  FavouriteViewController.swift
//  QClub
//
//  Created by Dreamup on 10/13/17.
//  Copyright © 2017 Dream. All rights reserved.
//
//Page 141 in the Storyboard
import UIKit


protocol OnItemClick {
    func OnItemClickListener(indexOfRow: Int,isHidden:Bool)
    func PushFavouriteDataToMain(data:String, typeOfFavorData:Int)
}

protocol hasFinishedLoadDataFromCell {
    func hasFinishedLoadDataFromCell()
}

class AgeRangeTitle: NSObject {
    var content = ""
  
}

class FavouriteValues: NSObject {
    var locationDetailChar = [String]()
    var styleDetailChar = [String]()
    var heightDetailChar = [String]()
    var bodyDetailChar = [String]()
    var relegionMatch = ""
    var drinkingDetailChar = [String]()
    var smokingDetailChar = ""
}



class FavouriteViewController: BaseViewController, OnItemClick, OnClickListener, hasFinishedLoadDataFromCell {
    
    
    @IBOutlet weak var navigationView: NavigationBarQClub!
    @IBOutlet weak var tbView: UITableView!
    
    var name:String = ""
    
    struct cellIdentifier {
        static let cellAge = "cellAge"
        static let cellArea = "cellArea"
        static let cellStyle = "cellStyle"
        static let cellHeight = "cellHeight"
        static let cellBody = "cellBody"
        static let cellReligion = "cellReligion"
        static let cellDrink = "cellDrink"
        static let cellSmoke = "cellSmoke"
           static let cellBottom = "cellBotom"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
      
    }
    
    func hasFinishedLoadDataFromCell() {
        getData()
    }
    
    func setupView(){
        tbView.dataSource = self
        tbView.delegate = self
        
        
        print("Data from former controller \(name)")
        
        tbView.register(UINib.init(nibName: "FavouriteTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier.cellAge)
        tbView.register(UINib.init(nibName: "AreaTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier.cellArea)
        tbView.register(UINib.init(nibName: "StyleTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier.cellStyle)
        tbView.register(UINib.init(nibName: "HeightTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier.cellHeight)
        tbView.register(UINib.init(nibName: "BodyTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier.cellBody)
        
        tbView.register(UINib.init(nibName: "ReligionTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier.cellReligion)
        tbView.register(UINib.init(nibName: "DrinkTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier.cellDrink)
        tbView.register(UINib.init(nibName: "SmokeTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier.cellSmoke)
         tbView.register(UINib.init(nibName: "ButtomTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier.cellBottom)
    }
    
    
    var mData = FavouriteValues()
    
    var mAgeRange = [String]()
    var mLocationDetailChar = [String]()
    var mStyleDetailChar = [String]()
    var mHeightDetailChar = [String]()
    var mBodyDetailChar = [String]()
    var mRelegionMatch = [String]()
    var mDrinkingDetailChar = [String]()
    var mSmokingDetailChar = [String]()
    
    var mAgeRangeTitle = AgeRangeTitle()
    var mLocationDetailCharTitle = ""
    var mStyleDetailCharTitle = ""
    var mHeightDetailCharTitle = ""
    var mBodyDetailCharTitle = ""
    var mRelegionMatchTitle = ""
    var mDrinkingDetailCharTitle = ""
    var mSmokingDetailCharTitle = ""
    
    func getData(){
        
        self.showLoading()
        MenuService.getFavouriteIdeal(completion: { (response) in
            self.stopLoading()

            
            if let pResult = response.data as? Dictionary<String, Any> {

                  self.parseDataFromSv(data:pResult)
            }
            
            
        }) { (erroe) in
            
             self.stopLoading()
        }
        
        
    }
    
    func parseDataFromSv(data:Dictionary<String, Any>){
        
        
        if let value1 = data["ageRangeArr"] as? [String] {
            mAgeRange = value1
        }
        
        if let value2 = data["locationDetailArr"] as? [String] {
            mData.locationDetailChar = value2
        }
        
        if let value3 = data["styleDetailArr"] as? [String] {
            mData.styleDetailChar = value3
        }
        
        if let value4 = data["heightDetailArr"] as? [String] {
            mData.heightDetailChar = value4
        }
        
        if let value5 = data["bodyDetailArr"] as? [String] {
            mData.bodyDetailChar = value5
        }
        
        if let value6 = data["relegionMatchArr"] as? [String] {
            mRelegionMatch = value6
        }
        
        if let value7 = data["drinkingDetailArr"] as? [String] {
            mData.drinkingDetailChar = value7
        }
        
        if let value8 = data["mSmokingDetailArr"] as? [String] {
            mSmokingDetailChar = value8
        }
        
        // ------------
        
        if let value1Title = data["ageRange"] as? String {
            mAgeRangeTitle.content = value1Title
            mFavourite.ageRange = value1Title
        }
        
        if let value2Title = data["locationDetailChar"] as? String {
            mLocationDetailCharTitle = value2Title
            mFavourite.locationDetailChar = value2Title
        }
        
        if let value3Title = data["styleDetailChar"] as? String {
            mStyleDetailCharTitle = value3Title
            mFavourite.styleDetailChar = value3Title
        }
        
        if let value4Title = data["heightDetailChar"] as? String {
            mHeightDetailCharTitle = value4Title
            mFavourite.heightDetailChar = value4Title
        }
        
        if let value5Title = data["bodyDetailChar"] as? String {
            mBodyDetailCharTitle = value5Title
            mFavourite.bodyDetailChar = value5Title
        }
        
        if let value6Title = data["relegionMatch"] as? String {
            mFavourite.relegionMatch = value6Title
            mData.relegionMatch = value6Title
        }
        
        if let value7Title = data["drinkingDetailChar"] as? String {
            mDrinkingDetailCharTitle = value7Title
            mFavourite.drinkingDetailChar = value7Title
        }
        
        if let value8Title = data["smokingDetailChar"] as? String {
            mData.smokingDetailChar = value8Title
            mFavourite.smokingDetailChar = value8Title
            
        }
        
      tbView.reloadData()
        
    }
    
    func PushFavouriteDataToMain(data: String, typeOfFavorData: Int) {
        
        print("Data \(data) Type = \(typeOfFavorData)")
        
        switch typeOfFavorData {
        case 0:
            mFavourite.ageRange = data
        case 1:
            mFavourite.locationDetailChar  = data
        case 2:
            mFavourite.styleDetailChar  = data
        case 3:
            mFavourite.heightDetailChar = data
        case 4:
            mFavourite.bodyDetailChar = data
        case 5: 
            mFavourite.relegionMatch =  data
        case 6:
            mFavourite.drinkingDetailChar = data
        case 7:
            mFavourite.smokingDetailChar = data
        default:
            break
        }

    }
    
    
    var cellExplains = Set<Int>()
    var previousIndex:Int = 0
    func OnItemClickListener(indexOfRow: Int, isHidden:Bool) {
  
        if isHidden {
            cellExplains.removeAll()
            cellExplains.insert(indexOfRow)
        } else {
            cellExplains.remove(indexOfRow)
        }
        
        print("Tag == \(indexOfRow) \(cellExplains.count) ")
 
        // self.tbView.reloadRows(at: [IndexPath.init(row: previousIndex, section: 0),IndexPath.init(row: indexOfRow, section: 0)], with: .none)
        self.tbView.reloadData()
        
        let row = [IndexPath.init(row: indexOfRow, section: 0)]
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.tbView.scrollToRow(at: row[0], at: .middle, animated: false)
            
        }
        
        previousIndex = indexOfRow
    }
    
    
    override func configNavigationBar() {
        
        
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    var mFavourite = Favourite()
    @IBAction func btnOkAction(_ sender: Any) {

        
       

    }
    
    func clickOkAction() {
        
        self.showLoading()
        MenuService.putFavouriteUpdate(pFavourite: mFavourite, completion: {[weak self] (response) in
            guard let _self = self else { return  }
            _self.stopLoading()
            
            if response.code == 0 {
                _self.showDialogAfterPostOrPutSuccessfully()
            } else {
                _self.postFavouriteUpdate()
            }
            
        }) { (error) in
            self.stopLoading()
            
        }
        
    }
    
    func postFavouriteUpdate(){
        
        MenuService.postFavouriteUpdate(pFavourite: mFavourite, completion: {[weak self] (response) in
            guard let _self = self else {return}
            if response.code == 0 {
                _self.showDialogAfterPostOrPutSuccessfully()
            }
        }) { (error) in
         
        }
        
        
    }
    
    func showDialogAfterPostOrPutSuccessfully(){
        let dialog = HoldingPopup.instanceFromNib(content: "수정이 완료되었습니다.", image: "ic_done.png")
        dialog.show()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            dialog.hide()
            self.navigationController?.popViewController(animated: true)
            
        }
    }
    
}



var isExpand = true
extension FavouriteViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.cellAge, for: indexPath) as! FavouriteTableViewCell
        
        switch indexPath.row {
            
            
            
        case 0:
            let cell1 = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.cellAge, for: indexPath) as! FavouriteTableViewCell
            cell1.tag = 0
            cell1.bidingData(isExplain: cellExplains.contains(0), data: mAgeRange, mAgeRangeTitle)
            cell1.onItemClick = self
            return cell1
        case 1:
            let cell2 = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.cellArea, for: indexPath) as! AreaTableViewCell
            cell2.tag = 1
            cell2.bidingData(isHidden: cellExplains.contains(1), data: mData, mLocationDetailCharTitle)
            cell2.onItemClick = self
            cell2.hasFinishedLoadDataFromCell = self
            return cell2
            
        case 2:
            let cell2 = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.cellStyle, for: indexPath) as! StyleTableViewCell
            cell2.tag = 2
            cell2.bidingData(isHidden: cellExplains.contains(2), data: mData,mStyleDetailCharTitle)
            cell2.onItemClick = self
            
            return cell2
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.cellHeight, for: indexPath) as! HeightTableViewCell
            cell.tag = 3
            cell.bidingData(isHidden: cellExplains.contains(3), data: mData, mHeightDetailCharTitle)
            cell.onItemClick = self
            
            return cell
            
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.cellBody, for: indexPath) as! BodyTableViewCell
            cell.tag = 4
            cell.bidingData(isHidden: cellExplains.contains(4), data: mData, mBodyDetailCharTitle)
            cell.onItemClick = self
            
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.cellReligion, for: indexPath) as! ReligionTableViewCell
            cell.tag = 5
            cell.bidingData(isExplain: cellExplains.contains(5), data: mData, mRelegionMatchTitle)
            cell.onItemClick = self
            
            return cell
            
        case 6:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.cellDrink, for: indexPath) as! DrinkTableViewCell
            cell.tag = 6
            cell.bidingData(isHidden: cellExplains.contains(6), data: mData, mDrinkingDetailCharTitle)
            cell.onItemClick = self
    
            return cell
            
        case 7:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.cellSmoke, for: indexPath) as! SmokeTableViewCell
            cell.tag = 7
            cell.bidingData(isExplain: cellExplains.contains(7), data: mData, mSmokingDetailCharTitle)
            cell.onItemClick = self
            return cell
        case 8:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.cellBottom, for: indexPath) as! ButtomTableViewCell
            cell.tag = 8
           cell.onItemClick = self
            return cell
            
        default:
            print("123")
        }
        
        return cell
        
        
    }
    
    
    
    
}

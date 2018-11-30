//
//  GroundFoodShopViewController.swift
//  QClub
//
//  Created by TuanNM on 10/23/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import MBProgressHUD

class GroundFoodShopViewController: BaseViewController {

    enum TAB_TYPE {
        case RECENTLY_FOOD
        case SEARCH_FOOD
        case MY_FOOD
    }
    
    let itemsSize = (SCREEN_WIDTH - 20)/3
    var tabType:TAB_TYPE = .RECENTLY_FOOD
    
    var recentFoods:[GRestaurant] = []
    var searchFoods:[GRestaurant] = []
    var myFoods:[GRestaurant] = []
 
    var offset = 0
    var provinceId:Int = -1
    var districtId:Int = -1
    var provinces:[MasterDataObject] = []
    var districts:[MasterDataObject] = []
    
    
    @IBOutlet weak var navigationBar: NavigationBarQClub!
    @IBOutlet weak var recentlyFoodBtn: GroundTab!
    @IBOutlet weak var searchBtn: GroundTab!
    @IBOutlet weak var myFoodBtn: GroundTab!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func recentlyFoodAction(_ sender: Any) {
        recentlyFoodBtn.setSelected(isSelect: true)
        searchBtn.setSelected(isSelect: false)
        myFoodBtn.setSelected(isSelect: false)
        if tabType != .RECENTLY_FOOD{
            tabType = .RECENTLY_FOOD
            collectionView.reloadData()
            if recentFoods.count == 0 {
                getRecentFood()
            }
        }
    }
    @IBAction func searchAction(_ sender: Any) {
        recentlyFoodBtn.setSelected(isSelect: false)
        searchBtn.setSelected(isSelect: true)
        myFoodBtn.setSelected(isSelect: false)
        if tabType != .SEARCH_FOOD{
            tabType = .SEARCH_FOOD
            collectionView.reloadData()
            if searchFoods.count == 0 {
                getFoodByKey()
            }
        }
    }
    @IBAction func myFoodAction(_ sender: Any) {
        recentlyFoodBtn.setSelected(isSelect: false)
        searchBtn.setSelected(isSelect: false)
        myFoodBtn.setSelected(isSelect: true)
        if tabType != .MY_FOOD{
            tabType = .MY_FOOD
            collectionView.reloadData()
            if myFoods.count == 0 {
                getMyFood()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.config(title: "요긴 꼭 가봐야해! 나의 맛집", image: "ic_food.png")
        navigationBar.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        
        getRecentFood()
        setLocationAddreess()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func loadmoreFood(){
        
        switch tabType {
        case .RECENTLY_FOOD:
            offset = self.recentFoods.count
            getRecentFood()
            break
        case .SEARCH_FOOD:
            offset = self.searchFoods.count
            getFoodByKey()
            break
        case .MY_FOOD:
            break
        }
    }
    

    func getRecentFood(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        GFoodService.getRestaurantCurrent(offset:offset, completion: { [weak self](response) in
            guard let _self = self else{return}
            MBProgressHUD.hide(for: _self.view, animated: true)
            guard let arrFoods = response.data as? [GRestaurant] else{return}
            if _self.offset == 0{
               _self.recentFoods = arrFoods
            }else{
                _self.recentFoods.append(contentsOf: arrFoods)
            }
            _self.collectionView.reloadData()
        }) { [weak self](error) in
            guard let _self = self else{return}
            MBProgressHUD.hide(for: _self.view, animated: true)
            print("getRestaurantCurrent error \(error)")
        }
    }
    
    func getFoodByKey() {
        if provinceId == -1 {return}
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        GFoodService.geRestaurantBy(area1: provinceId, area2: districtId, offset: offset, completion: { [weak self](response) in
            guard let _self = self else{return}
            MBProgressHUD.hide(for: _self.view, animated: true)
            guard let arrFoods = response.data as? [GRestaurant] else{return}
            if _self.offset == 0{
                _self.searchFoods = arrFoods
            }else{
                _self.searchFoods.append(contentsOf: arrFoods)
            }
            
            if _self.searchFoods.count == 0 {
                _self.view.makeToast("해당하는 조건의 맛집이 없습니다")
            }
            
            _self.collectionView.reloadData()
        }) { [weak self](error) in
            guard let _self = self else{return}
            MBProgressHUD.hide(for: _self.view, animated: true)
            print("geRestaurantBy error \(error)")
        }
    }
    
    func getMyFood(){
        MBProgressHUD.showAdded(to: self.view, animated: true)
        GFoodService.getMyRestaurant(offset:offset, completion: { [weak self](response) in
            guard let _self = self else{return}
            MBProgressHUD.hide(for: _self.view, animated: true)
            guard let arrFoods = response.data as? [GRestaurant] else{return}
            _self.myFoods = arrFoods
            if arrFoods.count == 0 {
                _self.view.makeToast("아직 소개해주신 맛집이 없습니다. 맛난 곳 소개해주세요~")
            }
            _self.collectionView.reloadData()
        }) { [weak self](error) in
            guard let _self = self else{return}
            MBProgressHUD.hide(for: _self.view, animated: true)
            _self.view.makeToast("아직 소개해주신 맛집이 없습니다. 맛난 곳 소개해주세요~")
            print("getMyRestaurant error \(error)")
        }
    }
    
    func setLocationAddreess() {
        AuthService.getMasterData(masterSeq: Constants.MasterCode.Location1, completion: { (response) in
            guard let results = response.data as? [MasterDataObject] else{return}
            self.provinces = results
        }) { (error) in
            print("getMasterData Location1 error \(error) ")
        }
        
        AuthService.getMasterData(masterSeq: Constants.MasterCode.Location2, completion: { (response) in
            guard let results = response.data as? [MasterDataObject] else{return}
            self.districts = results
        }) { (error) in
            print("getMasterData Location2 error \(error) ")
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == "newFoodSegue"{
            return tabType == .MY_FOOD
        }
        return true
    }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? UICollectionViewCell else{return}
        guard let index = collectionView.indexPath(for: cell) else{return}
        guard let foodDetailVC = segue.destination as? GroundFoodDetailViewController else{return}
        
        switch tabType {
        case .MY_FOOD:
            let restaurant = myFoods[index.row]
            foodDetailVC.tastySeq = restaurant.tastySeq
        case .RECENTLY_FOOD:
            let restaurant = recentFoods[index.row]
            foodDetailVC.tastySeq = restaurant.tastySeq
            break
        case .SEARCH_FOOD:
            let restaurant = searchFoods[index.row]
            foodDetailVC.tastySeq = restaurant.tastySeq
            break
        }
    }
    
}

extension GroundFoodShopViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return tabType == .SEARCH_FOOD ? 3 : 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch tabType{
        case .MY_FOOD :
            return section == 0 ? myFoods.count : 1
        case .RECENTLY_FOOD:
            return section == 0 ? recentFoods.count : 1
        case .SEARCH_FOOD:
            return section == 1 ? searchFoods.count : 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch indexPath.section {
        case 0:
            if tabType == .SEARCH_FOOD{
                let searchCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroundSearchFoodCell", for: indexPath) as! GroundSearchFoodCell
                searchCell.setLocationAddreess(provinces: self.provinces, districts: self.districts, proviceSelectedRow: self.provinceId, districtSelectedRow: self.districtId)
                searchCell.callBackSearch = {
                    province,district in
                    self.provinceId = province
                    self.districtId = district
                    self.offset = 0
                    self.getFoodByKey()
                }
                return searchCell
            }
            
            let foodItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroundFoodCell", for: indexPath) as! GroundFoodCell
            let restaurant = tabType == .RECENTLY_FOOD ? recentFoods[indexPath.row] : myFoods[indexPath.row]
            
            foodItemCell.setData(restaurant: restaurant)
            return foodItemCell
        case 1:
            
            if tabType == .SEARCH_FOOD{
                let foodItemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroundFoodCell", for: indexPath) as! GroundFoodCell
                let restaurant = searchFoods[indexPath.row]
                foodItemCell.setData(restaurant: restaurant)
                return foodItemCell
            }
            
            let loadmoreCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadMoreCell", for: indexPath) as! GroundFoodLoadMoreCell
            loadmoreCell.setTitle(title: tabType == .MY_FOOD ? "등록" : "최근 등록 맛집 더보기")
            loadmoreCell.loadMoreAction = {
                [weak self] in
                guard let _self = self else {return}
                _self.loadmoreFood()
            }
            loadmoreCell.activeLoadMoreButton(isActive: tabType == .MY_FOOD ? true : recentFoods.count > 0)
            return loadmoreCell
            
        default:
            let loadmoreCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadMoreCell", for: indexPath) as! GroundFoodLoadMoreCell
            loadmoreCell.setTitle(title: "최근 등록 맛집 더보기")
            loadmoreCell.loadMoreAction = {
                [weak self] in
                guard let _self = self else {return}
                _self.loadmoreFood()
            }
            loadmoreCell.activeLoadMoreButton(isActive: searchFoods.count > 0)
            return loadmoreCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0:
            return tabType == .SEARCH_FOOD ? CGSize(width: SCREEN_WIDTH - 10, height: 100) : CGSize(width: itemsSize, height: itemsSize + 40)
        case 1 :
            return tabType == .SEARCH_FOOD ? CGSize(width: itemsSize, height: itemsSize + 40) : CGSize(width: SCREEN_WIDTH - 10, height: 100)
        default:
            return CGSize(width: SCREEN_WIDTH, height: 100)
        }
    }
}

extension GroundFoodShopViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 5
    }
}


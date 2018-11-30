//
//  GroundFoodDetailViewController.swift
//  QClub
//
//  Created by TuanNM on 10/25/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import AXPhotoViewer
class GroundFoodDetailViewController: UIViewController {
    
    @IBOutlet weak var navigationBar: NavigationBarQClub!
    @IBOutlet weak var tbView: UITableView!
    weak var photosViewController: PhotosViewController?
    var foodDetailCell:GroundFoodDetailCel!
    var tastySeq:Int = 0
    var avatarPhotos: [Photo] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.config(title: "요긴 꼭 가봐야해! 나의 맛집", image: "ic_food.png")
        navigationBar.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        
        foodDetailCell = tbView.dequeueReusableCell(withIdentifier: "GroundFoodDetailCell") as! GroundFoodDetailCel
        foodDetailCell.delegate = self
        foodDetailCell.gotoGroundFoodWrite = {
            [weak self] in
            guard let _self = self else{return}
            let vc = _self.storyboard?.instantiateViewController(withIdentifier: "GroundNewFoodViewController")
            _self.navigationController?.pushViewController(vc!, animated: true)
        }
        
        
        foodDetailCell.presentFullScreenSlider = {
            [weak self] cell, url, index in
            
            guard let _self = self else{return}
            _self.avatarPhotos.removeAll()
            _self.avatarPhotos.append(Photo(attributedTitle: NSAttributedString(string: ""),
                                            attributedDescription: NSAttributedString(string: ""),
                                            attributedCredit: NSAttributedString(string: ""),
                                            url: URL(string: "http://\(url[index])" )))
            
            
            let dataSource = PhotosDataSource(photos: _self.avatarPhotos)
            let photosViewController = PhotosViewController(dataSource: dataSource, pagingConfig: PagingConfig.init(), transitionInfo: TransitionInfo.init())
            
            _self.present(photosViewController, animated: true)
            _self.photosViewController = photosViewController
        }
        
        foodDetailCell.wantToSeeProfile = {
            
         
            
            [weak self] userSeq in
            
            guard let _self = self else{return}
            
               _self.showLoading()
            RelationService.getHeartCount(completion: {[ weak self] (response) in
                
                guard let _self = self else { return }
                
                _self.stopLoading()
                
                if let heartNumber = response.data as? Int {
                    let profleDetailAleart = BoardDetailDialog.instanceFromNib(typeOfDialog: "GROUND_FOOD_DETAIL", numberOfHeart: heartNumber)
                    
                    profleDetailAleart.show()
                    profleDetailAleart.action = {
                        profleDetailAleart.hide()
                        
                        _self.doAcceptToRemoveHeart(userSeq)
                        
                        
                    }
                }
            }) { (error) in
                _self.stopLoading()
            }
            
        }
        
        
        foodDetailCell.doLikeRestaurant = {
            
            [weak self] likeOrUnLike in
            
            guard let _self = self else{return}
            
            if likeOrUnLike {
                GFoodService.unLikeRestaurantById(tastySeq: _self.tastySeq, completion: { (response) in
                    _self.getData()
         
                }, fail: { (error) in
         
                    
                })
            } else {
                GFoodService.likeRestaurantById(tastySeq: _self.tastySeq, completion: { (response) in
                    _self.getData()
                }, fail: { (error) in
                    
                })
            }
            
            
        }
        
        
        getData()
        
        
    }
    
    func doAcceptToRemoveHeart(_ userSeq: Int){
        self.showLoading()
        MenuService.postDetailBoardProfile(completion: { (response) in
            self.stopLoading()
            if response.code == 0 {
                Utils.gotoUserVC(viewController: self, userSeq: userSeq)
            } else {
                Utils.gotoStore(viewController: self)
            }


        }) { (error) in

        }
    }
    
    
    func getData(){
        
        GFoodService.getRestaurantById(tastySeq: tastySeq, completion: {
            [weak self](response) in
            guard let _self = self else{return}
            guard let restaurant = response.data as? GRestaurant else{return}
            _self.foodDetailCell.setData(restaurant:restaurant)
            _self.tbView.reloadData()
            
        }) { (error) in
            print("getRestaurantById error \(error)")
        }
        
    }
    
    
    @IBAction func btnMoreImageDetail(_ sender: Any) {
        let imageDetailVC = GroundFooodDetailImageViewController.init(nibName: "GroundFooodDetailImageViewController", bundle: nil)
        navigationController?.pushViewController(imageDetailVC, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension GroundFoodDetailViewController:GroundFoodDetailCellDelegate{
    func willShowUserDetail(userId: Int) {
        showPaymentPopUp()
    }
}

extension GroundFoodDetailViewController: UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if foodDetailCell.restaurant?.isRegister == "Y"{
            return 900
        }
        return 600
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return foodDetailCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        
    }
    
}

extension GroundFoodDetailViewController{
    func showPaymentPopUp(){
        let heartView = HeartView(nibName: "HeartView", bundle: nil)
        heartView.popupTitle = "상세 프로필 확인하기"
        heartView.popupMessage = "맛집을 소개한 회원의 \n 상세프로필을 확인하실 수 있습니다~ "
        heartView.price = "5"
        heartView.myHeart = "50"
        heartView.buttonContent = "상세 프로필 확인하기"
        
        self.addChildViewController(heartView)
        self.view.addSubview(heartView.view)
        
        heartView.callBackSelect = {
            [weak self] in
            guard let _self = self else{return}
            
            let sb = UIStoryboard(name: "RelationCard", bundle: nil)
            let profileVC = sb.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            _self.navigationController?.pushViewController(profileVC, animated: true)
        }
    }
    
    func showStorePopup() {
        let alertQ = AlertQClub.instanceFromNib(content: "하트가 부족합니다 충전하시겠습니까?", image: "ic_store_popup")
        alertQ.show()
        alertQ.action1 = {
            
            
        }
    }
}


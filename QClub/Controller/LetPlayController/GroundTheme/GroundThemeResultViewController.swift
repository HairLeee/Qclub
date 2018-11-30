//
//  GroundThemeResultViewController.swift
//  QClub
//
//  Created by TuanNM on 10/16/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class GroundThemeResultViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var navigationBar: NavigationBarQClub!
    
    var arrResult:[GIMember] = []
    let itemsSize = (SCREEN_WIDTH - 30)/2 - 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.config(title: "테마 인연 찾기", image: "ic_search_theme.png")
        navigationBar.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        if arrResult.count < 2 {
            self.view.makeToast("해당 조건의 인연이 없습니다, 다른 테마를 선택해주새요")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showPopupPayHeartViewProfile(userSeq: Int){
        self.showLoading()
        RelationService.getHeartCount(completion: { (response) in
            self.stopLoading()
            let count = response.data as! Int
            let heartView = HeartView(nibName: "HeartView", bundle: nil)
            heartView.popupTitle = "원하는 지역 인연 검색!"
            heartView.popupMessage = "다른 한 분의 상세 검색 시에는 하트가 필요합니다.\n나머지 회원의 상세프로필을 확인하시겠어요?\n"
            heartView.price = "5"
            heartView.myHeart = "\(count)"
            heartView.buttonContent = "상세 프로필 확인"
            self.addChildViewController(heartView)
            self.view.addSubview(heartView.view)
            
            heartView.callBackSelect = {
                [weak self] in
                guard let _self = self  else {return}
                _self.showLoading()
                GSearchingService.viewPaidProfileLocation(completion: { (response) in
                    _self.stopLoading()
                    if count < 5 {
                        Utils.gotoStore(viewController: _self)
                    } else {
                        Utils.gotoUserVC(viewController: _self, userSeq: userSeq)
                    }
                }, fail: { (error) in
                    _self.stopLoading()
                })
            }
        }) { (error) in
            
        }
    }
}


extension GroundThemeResultViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return arrResult.count > 0 ? 2 : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? arrResult.count : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noticeCell", for: indexPath)
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerSearchCell", for: indexPath) as! PlayerSearchCell
        let member = arrResult[indexPath.row]
        cell.setData(member:member)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1 {
            return CGSize(width: SCREEN_WIDTH  - 30, height: 80)
        }
        
        return CGSize(width: itemsSize, height: 1.5*itemsSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let member = arrResult[indexPath.row]
        if member.isLock {
            self.showPopupPayHeartViewProfile(userSeq: member.userSeq )
        } else {
            Utils.gotoUserVC(viewController: self, userSeq: member.userSeq)
            
            for index in 0...(arrResult.count - 1) {
                if index != indexPath.row {
                    arrResult[index].isLock = true
                }
            }
            self.collectionView.reloadData()
        }
    }
}

extension GroundThemeResultViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: 5)
    }
    
}

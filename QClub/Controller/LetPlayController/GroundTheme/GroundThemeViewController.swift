//
//  GroundThemeViewController.swift
//  QClub
//
//  Created by TuanNM on 10/16/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import MBProgressHUD

class GroundThemeViewController: BaseViewController {
    @IBOutlet weak var navigationBar: NavigationBarQClub!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBtn: UIButton!
    var arrResult:[GIMember] = []
    let segueId = "searchResultSegue"
    
    var indexSelected = -1
    
    var data = [MasterDataObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStyleList()
        searchBtn.alpha = 0.5
        navigationBar.config(title: "테마 인연 찾기", image: "ic_search_theme.png")
        navigationBar.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return arrResult.count > 0 ? true : false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let searchDetail = segue.destination as? GroundThemeResultViewController else{return}
        searchDetail.arrResult = self.arrResult
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func searchAction(_ sender: Any) {
        showPopupPayHeartSearch()
    }
    
    func getStyleList() {
        self.showLoading()
        AuthService.getMasterData(masterSeq: Constants.MasterCode.Style, completion: { (response) in
            self.stopLoading()
            if let data = response.data as? [MasterDataObject] {
                self.data = data
                self.collectionView.reloadData()
            }
        }) { (error) in
            self.stopLoading()
        }
    }
    
}
extension GroundThemeViewController{
    
    func showPopupPayHeartSearch(){
        self.showLoading()
        RelationService.getHeartCount(completion: { (response) in
            self.stopLoading()
            let count = response.data as! Int
            let heartView = HeartView(nibName: "HeartView", bundle: nil)
            heartView.popupTitle = "테마 인연 검색!"
            heartView.popupMessage = "원하시는 스타일을 선택하셨나요? \n 회원님이 좋아하는 모습을 가진 회원을 찾아보세요~ \n 인연은 만들어가는 것! 찾아가는 것!"
            heartView.price = "5"
            heartView.myHeart = "\(count)"
            heartView.buttonContent = "인연 검색하기"
            self.addChildViewController(heartView)
            self.view.addSubview(heartView.view)
            
            heartView.callBackSelect = {
                [weak self] in
                guard let _self = self else{return}
                if count < 5 {
                    Utils.gotoStore(viewController: _self)
                } else {
                    MBProgressHUD.showAdded(to: _self.view, animated: true)
                    GSearchingService.search(stype: _self.data[_self.indexSelected].detailSeq ?? 0, completion: { (response) in
                        MBProgressHUD.hide(for: _self.view, animated: true)
                        guard let members = response.data as? [GIMember] else{return}
                        _self.arrResult = members
                        _self.performSegue(withIdentifier: _self.segueId, sender: nil)
                    }, fail: { (error) in
                        MBProgressHUD.hide(for: _self.view, animated: true)
                        print("search error : \(error)")
                    })
                }

            }
        }) { (error) in
            
        }

    }
    
    
    func showStorePopup() {
        let alertQ = AlertQClub.instanceFromNib(content: "하트가 부족합니다 충전하시겠습니까?", image: "ic_store_popup")
        alertQ.show()
        alertQ.action1 = {
            //[weak self] in
            //guard let _self = self else{return}
            
        }
    }
    
    func showPopupNoResult(){
        let noticePopup = NoticePopupView(nibName: "NoticePopupView", bundle: nil)
        noticePopup.view.frame = view.frame
        noticePopup.view.alpha = 0
        noticePopup.alert1Lb.text = "해당 조건의 인연이 없습니다,"
        noticePopup.alert1Lb.text = "다른 테마를 선택해주세요."
        self.addChildViewController(noticePopup)
        self.view.addSubview(noticePopup.view)
        
        UIView.animate(withDuration: 0.5, animations: {
            noticePopup.view.alpha = 1
        })
        
    }
}


extension GroundThemeViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommentCheckboxCollectionCell", for: indexPath) as! Join3CollectionViewCell
        cell.lbTitle.text =  data[indexPath.row].detailName
        cell.configBackgroundForSelected(isSelected: indexSelected == indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        indexSelected = indexSelected == indexPath.row ? -1 :  indexPath.row
        searchBtn.alpha = indexSelected != -1 ? 1 : 0.5
        collectionView.deselectItem(at: indexPath, animated: false)
        collectionView.reloadData()
    }
    
}

extension GroundThemeViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
}

extension GroundThemeViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.collectionView.frame.size.width)/4 , height: self.collectionView.frame.size.width/7)
    }
}

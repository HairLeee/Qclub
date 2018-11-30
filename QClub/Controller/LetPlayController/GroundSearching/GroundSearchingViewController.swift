//
//  GroundSearchingViewController.swift
//  QClub
//
//  Created by TuanNM on 10/13/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import MBProgressHUD
import IQDropDownTextField

enum SEARCH_TYPE {
    case GROUND_Q
    case GROUND_LOCAL
}

class GroundSearchingViewController: BaseViewController {

    @IBOutlet weak var areaBoxView: BoxView!
    @IBOutlet weak var ageBoxView: BoxView!
    
    @IBOutlet weak var navigationBar: NavigationBarQClub!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var introduceLine1: UILabel!
    @IBOutlet weak var searchBTN: CompleteButton!
    
    var searchType:SEARCH_TYPE = .GROUND_Q
    var arrResult:[GIMember] = []
    let itemsSize = (SCREEN_WIDTH - 30)/2 - 5
    var isShowSearchTitle = true

    var locationInfoList = [MasterDataObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let font = UIFont(name: "NanumSquareOTF", size: 13)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = 8
        paragraphStyle.alignment = .center
        let attributes = [NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle]
        
        if searchType == .GROUND_Q{
            navigationBar.config(title: "Q클럽과의 인연", image: "ic_member_white.png")
            let popupMessage = "Q1이상 회원님과 인연이 되실 수 있습니다.\n인연은 만들어 가는 것!\n찾아가는 것!"
            let attributedText = NSAttributedString(string: popupMessage, attributes: attributes)
            introduceLine1.attributedText = attributedText
            
        }else{
            navigationBar.config(title: "원하는 지역 인연", image: "ic_search_local.png")
            let popupMessage = "가까운 거리에 있는 분과 인연이 된다면, 더 친해질 수 있겠죠?\n원하는 지역의 회원님과 인연이 될 수 있습니다.\n인연은 만들어 가는 것!\n찾아가는 것!"
            let attributedText = NSAttributedString(string: popupMessage, attributes: attributes)
            introduceLine1.attributedText = attributedText
     
        }

        areaBoxView.textField.textAlignment = .center
        areaBoxView.textField.delegate = self
        ageBoxView.textField.textAlignment = .center
        ageBoxView.textField.delegate = self
        ageBoxView.textField.itemList = ["10대","20대","30대","40대","50대 이상"]
        
        navigationBar.backAction = {
            self.navigationController?.popViewController(animated: true)
        }

        collectionView.isHidden = true
        getLocationInfoList()
        
        
    }
    
    func getLocationInfoList() {
        AuthService.getMasterData(masterSeq: Constants.MasterCode.Location, completion: { (response) in
            if let data = response.data as? [MasterDataObject] {
                self.locationInfoList = data
                self.areaBoxView.textField.itemList = data.map{$0.detailName ?? ""}
            }
        }) { (error) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func searchAction(_ sender: Any) {
        if searchType == .GROUND_Q{
            showPopupPayHeartSearchQ()
        }else{
            showPopupPayHeartSearch()
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard  let profileVc = segue.destination as? ProfileViewController else{return}
        guard let cell = sender as? UICollectionViewCell else{return}
        guard let index  = collectionView.indexPath(for: cell) else{return}
        let userSeq = arrResult[index.row].userSeq
        profileVc.userSeq = userSeq
    }
    
    func searchFriend() {
            let location = self.areaBoxView.textField.selectedRow
            let age = self.ageBoxView.textField.selectedRow
            if location == -1 || age == -1 {return}
            self.showLoading()
            GSearchingService.search(location: location + 1, ageRange: age + 1, completion: {
                [weak self](response) in
                guard let _self = self else{return}
                _self.stopLoading()
                guard let members = response.data as? [GIMember] else{return}
                _self.arrResult = members
                _self.collectionView.isHidden = false
                _self.collectionView.reloadData()
            }, fail: { [weak self](error) in
                guard let _self = self else{return}
                _self.stopLoading()
                _self.view.makeToast("해당 조건의 인연이 없습니다, 다른 테마를 선택해주세요", duration: 2.0, position: .center)
            })
        

    }
}

extension GroundSearchingViewController : IQDropDownTextFieldDelegate {
    func textField(_ textField: IQDropDownTextField, didSelectItem item: String?) {
        self.searchBTN.changeState(isActive: areaBoxView.textField.selectedItem != nil && ageBoxView.textField.selectedItem != nil)
    }
}

extension GroundSearchingViewController{
    
    func showPopupPayHeartSearchQ()  {
        self.showLoading()
        RelationService.getHeartCount(completion: { (response) in
            self.stopLoading()
            
            let totalHeart = response.data as! Int
            let heartView = HeartView(nibName: "HeartView", bundle: nil)
            heartView.popupTitle = "Q1이상 회원과의 인연맺기"
            heartView.popupMessage = "신뢰도 높은 Q1~QS 등급의 회원과 인연이 될 수 있습니다.\nQ클럽의 자부심! Q1~QS 회원 2분을 소개해드립니다."
            heartView.price = "5"
            heartView.myHeart = "\(totalHeart)"
            heartView.buttonContent = "Q1 ~ QS 회원 검색하기"
            
            self.addChildViewController(heartView)
            self.view.addSubview(heartView.view)
            
            heartView.callBackSelect = {
                [weak self] in
                guard let _self = self else{return}
                if totalHeart >= 5 {
                    _self.searchFriend()
                } else {
                    Utils.gotoStore(viewController: _self)
                }
            }
            
        }) { (error) in
            
        }
    }
    
    func showPopupPayHeartSearch()  {
        let heartView = HeartView(nibName: "HeartView", bundle: nil)
        heartView.popupTitle = "원하는 지역 인연 검색!"
        heartView.popupMessage = "회원님이 주로 계신 지역의 조건으로 검색하실 수 있어요 \n 가까이 계시면, 더 친해질 수 있겠지요~"
        heartView.price = "5"
        heartView.myHeart = "50"
        heartView.buttonContent = "인연 검색하기"
        
        self.addChildViewController(heartView)
        self.view.addSubview(heartView.view)

        heartView.callBackSelect = {
            [weak self] in
            guard let _self = self else{return}
            _self.searchFriend()
        }
    }
    
    func showPopupPayViewProfileQ(member:GIMember)  {
        
        self.showLoading()
        RelationService.getHeartCount(completion: { (response) in
            self.stopLoading()
            
            let totalHeart = response.data as! Int
            let heartView = HeartView(nibName: "HeartView", bundle: nil)
            heartView.popupTitle = "Q1-QS 회원과의 인연 선택!"
            heartView.popupMessage = "다른 한 분의 상세 프로필을 확인하시겠습니까?"
            heartView.price = "5"
            heartView.myHeart = "\(totalHeart)"
            heartView.buttonContent = "상세 프로필 확인하기"
            
            self.addChildViewController(heartView)
            self.view.addSubview(heartView.view)
            
            heartView.callBackSelect = {
                [weak self] in
                guard let _self = self  else {return}
                if totalHeart < 5 {
                    Utils.gotoStore(viewController: _self)
                } else {
                    _self.showLoading()
                    GSearchingService.viewPaidProfileLocation(completion: { (response) in
                        _self.stopLoading()
                        member.isLock = false
                        member.paidDate = Date()
                        _self.collectionView.reloadData()
                        Utils.gotoUserVC(viewController: _self, userSeq: member.userSeq)
                        _self.updateHideTitleSearch()
                    }, fail: { (error) in
                        _self.stopLoading()
                    })
                    
                }
            }
            
        }) { (error) in
            print("error showPopupPayViewProfileQ")
        }
        
        
    }
    
    func showPopupPayViewProfile(member: GIMember)  {
        self.showLoading()
        RelationService.getHeartCount(completion: { (response) in
            self.stopLoading()
            let totalHeart = response.data as! Int
            
            let heartView = HeartView(nibName: "HeartView", bundle: nil)
            heartView.popupTitle = "추가 회원 상세프로필 확인"
            heartView.popupMessage = "해당 회원을 선택하셨나요?\n회원을 좀 더 알기 위해서는 하트가 필요합니다."
            heartView.price = "5"
            heartView.myHeart = "\(totalHeart)"
            heartView.buttonContent = "상대 확인하기"
            
            self.addChildViewController(heartView)
            self.view.addSubview(heartView.view)

            heartView.callBackSelect = {
                [weak self] in
                guard let _self = self  else {return}
                if totalHeart < 5 {
                    Utils.gotoStore(viewController: _self)
                } else {
                    _self.showLoading()
                    GSearchingService.viewPaidProfileLocation(completion: { (response) in
                        _self.stopLoading()
                        member.isLock = false
                        member.paidDate = Date()
                        _self.collectionView.reloadData()
                        Utils.gotoUserVC(viewController: _self, userSeq: member.userSeq)
                        _self.updateHideTitleSearch()
                    }, fail: { (error) in
                        _self.stopLoading()
                    })
                    
                }
            }
            
        }) { (error) in
            
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
    
    func showPopupGoStore() {
        let alertQ = AlertQClub.instanceFromNib(content: "하트가 부족합니다 충전하시겠습니까?", image: "ic_store_popup")
        alertQ.show()
        alertQ.action1 = {
            //[weak self] in
            //guard let _self = self else{return}
            
        }
    }
    
    func updateHideTitleSearch() {
        isShowSearchTitle = false
        self.collectionView.reloadData()
    }

}

extension GroundSearchingViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return isShowSearchTitle ? 2 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ((section == 0 && isShowSearchTitle) ? 1 : arrResult.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.section == 0 && isShowSearchTitle) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "topTitle", for: indexPath)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayerSearchCell", for: indexPath) as! PlayerSearchCell
            let memnber = arrResult[indexPath.row]
            cell.setData(member: memnber)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.section == 0 && isShowSearchTitle) {
            return CGSize.init(width: SCREEN_WIDTH, height: 90)
        } else {
            return CGSize(width: itemsSize, height: 1.5*itemsSize)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !(indexPath.section == 0 && isShowSearchTitle) {
            let member = arrResult[indexPath.row]
            if canGetFreeItem() || member.paidDate != nil{
                Utils.gotoUserVC(viewController: self, userSeq: member.userSeq)
                updateHideTitleSearch()
                member.paidDate = Date()
                if allFreeItem() {
                    for index in 0...(arrResult.count - 1) {
                        arrResult[index].isLock = false
                    }
                } else {
                    for index in 0...(arrResult.count - 1) {
                        if index != indexPath.row {
                            arrResult[index].isLock = true
                        }
                    }
                }
                self.collectionView.reloadData()
            }else{
                if searchType == .GROUND_Q {
                    self.showPopupPayViewProfileQ(member: member)
                }else{
                    self.showPopupPayViewProfile(member: member)
                }
            }
        }

    }
    
    func canGetFreeItem()->Bool{
        for user in arrResult{
            if user.paidDate != nil{
                return false
            }
        }
        return true
    }
    
    func allFreeItem()->Bool{
        for user in arrResult{
            if user.paidDate == nil{
                return false
            }
        }
        return true
    }
}

extension GroundSearchingViewController : UICollectionViewDelegateFlowLayout{
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
    
}

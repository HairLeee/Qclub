//
//  GroundItemDetailViewController.swift
//  QClub
//
//  Created by TuanNM on 10/27/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class GroundItemDetailViewController: BaseViewController {

    @IBOutlet weak var lbNamePresentPerson: UILabel!
    @IBOutlet weak var imagePresentPerson: UIImageView!
    @IBOutlet weak var viewPresentPerson: UIView!
    @IBOutlet weak var viewPresentPersonHeight: NSLayoutConstraint!
    @IBOutlet weak var navigationBar: NavigationBarQClub!
    @IBOutlet weak var tbView: UITableView!
    var item : ItemObject?
    var itemDetail : ItemDetailObject?
    var images = [ItItemPictures]()
    var isShowLikeView = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.config(title: "My 잇아이템", image: "ic_myItem.png")
        navigationBar.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        tbView.separatorStyle = .none
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func reloadData() {
        if let itemDetail = self.itemDetail {
            if let data = itemDetail.itItemPictures {
                images = data
                self.tbView.reloadData()
            }
            if itemDetail.gender == Context.getUserLogin()?.gender || itemDetail.userSeq == Context.getUserLogin()?.userSeq {
                viewPresentPersonHeight.constant = 0
            } else {
                imagePresentPerson.kf.setImage(with: URL.init(string: itemDetail.registerProfilePic))
                imagePresentPerson.clipsToBounds = true
                imagePresentPerson.layer.cornerRadius = imagePresentPerson.frame.size.width/2
                lbNamePresentPerson.text = itemDetail.registerName
            }
        }
    }
    
    func getData() {
        if let item = self.item {
            self.showLoading()
            ItemService.geItemDetail(itItemSeq: item.itItemSeq, completion: { (response) in
                if let data = response.data as? ItemDetailObject {
                    self.stopLoading()
                    self.itemDetail = data
                    self.reloadData()
                }
                self.stopLoading()
            }, fail: { (error) in
                self.stopLoading()
            })
        }
    }
    
    @IBAction func showPresentPerson(_ sender: Any) {
        if let item = self.itemDetail {
            self.showPaymentPopUp(userSeq: item.userSeq)
        }
    }
    
}

extension GroundItemDetailViewController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section != 0{
            return 1
        }
        return images.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0:
            return 110
        case 1:
            return 50
        default:
            return isShowLikeView ? 10 + 2*(SCREEN_WIDTH - 50)/3 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tbView.dequeueReusableCell(withIdentifier: "GroundItemWriteCell") as! GroundItemWriteCell
            cell.setupData(picture: images[indexPath.row])
            cell.introduceTv.isEditable = false
            cell.introduceTv.placeholder = ""
            return cell
        case 1:
            let cell = tbView.dequeueReusableCell(withIdentifier: "GroundItemExpandCell") as! GroundItemExpandCell
            cell.setupData(itemDetail: self.itemDetail)
            cell.expandAction = {
                [weak self] in
                guard let _self = self else {return}
                
                    _self.isShowLikeView = !_self.isShowLikeView
                    _self.tbView.reloadRows(at: [IndexPath(item: 0, section: 2)], with: .bottom)
                    _self.tbView.scrollToRow(at: IndexPath(item: 0, section: 2), at: .bottom, animated: true)
                
            }
            cell.likeAction = {
                [weak self] isLike, itemSeq in
                guard let _self = self else {return}
                if !isLike {
                    _self.showLoading()
                    ItemService.likeItem(itItemSeq: itemSeq, completion: { (response) in
                        _self.stopLoading()
                        _self.itemDetail?.myLikeCnt += 1
                        _self.itemDetail?.likeCnt += 1
                        _self.tbView.reloadSections(IndexSet.init(integer: 1), with: .none)
                    }, fail: { (error) in
                        _self.stopLoading()
                    })
                } else {
                    _self.showLoading()
                    ItemService.unLikeItem(itItemSeq: itemSeq, completion: { (response) in
                        _self.stopLoading()
                        _self.itemDetail?.myLikeCnt = 0
                        _self.itemDetail?.likeCnt -= 1
                        _self.tbView.reloadSections(IndexSet.init(integer: 1), with: .none)
                    }, fail: { (error) in
                        _self.stopLoading()
                    })
                }
            }
            return cell
        default:
            let cell = tbView.dequeueReusableCell(withIdentifier: "UserLikeCell") as! UserLikeCell
            cell.delegate = self
            cell.setData(users: itemDetail?.itItemLikeUsers)
            return cell
        }
    }
    
}

extension GroundItemDetailViewController:GroundFoodDetailCellDelegate{
    func willShowUserDetail(userId: Int) {
        showPaymentPopUp(userSeq: userId)
    }
}

extension GroundItemDetailViewController{
    func showPaymentPopUp(userSeq: Int){
        RelationService.getHeartCount(completion: { (response) in
            let count = response.data as! Int
            let heartView = HeartView(nibName: "HeartView", bundle: nil)
            heartView.popupTitle = "상세 프로필 확인하기"
            heartView.popupMessage = "잇아이템을 소개한 회원의\n 상세프로필을 확인하실 수 있습니다~"
            heartView.price = "5"
            heartView.myHeart = "\(count)"
            heartView.buttonContent = "상세 프로필 확인하기"
            
            self.addChildViewController(heartView)
            self.view.addSubview(heartView.view)
            
            heartView.callBackSelect = {
                [weak self] in
                guard let _self = self else{return}
                if count < 5 {
                    Utils.gotoStore(viewController: _self)
                } else {
                    Utils.gotoUserVC(viewController: _self, userSeq: userSeq)
                }
                
            }
        }) { (error) in
            
        }

    }
    
    func showStorePopup() {
        let alertQ = AlertQClub.instanceFromNib(content: "하트가 부족합니다 충전하시겠습니까?", image: "ic_store_popup")
        alertQ.show()
        alertQ.action1 = {
            
            
        }
    }
}

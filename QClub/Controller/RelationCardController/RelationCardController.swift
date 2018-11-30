//
//  RelationCardController.swift
//  QClub
//
//  Created by Dream on 9/13/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

/*
 Main1,Main3 Page 23,24,46 in StoryBoard
 */

class RelationCardController: UIViewController {
    
    @IBOutlet weak var todayCollectionView: UICollectionView!
    @IBOutlet weak var favoriteTableView: UITableView!
    @IBOutlet weak var todayRelationBtn: SlideButton!
    @IBOutlet weak var favoriteRelationBtn: SlideButton!
    
    var bubbleView:BubbleView?
    var todayMatchInfos : [UserMatchInfo] = []
    var specialMembers:[SpecialMember] = []
    var matchingMembers:[UserMatchInfo] = []
    
    var favoriteMembersFromMe:[UserMatchInfo] = []
    var favoriteMembersToMe:[UserMatchInfo] = []
    var isFromMeMore = false
    var isToMeMore = false
    var buttonDissMissBubble : UIButton?
    
    let itemsSize = (SCREEN_WIDTH - 30)/2 - 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableview()
        setupCollectionView()
        getTodayList()
        getSpecialList()
        getTodayCustomize()

        checkHasLogined()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupTableview() {
        favoriteTableView.allowsSelection = false
        favoriteTableView.separatorStyle = .none
    }
    
    func setupCollectionView() {
        todayCollectionView.register(UINib.init(nibName: "RelationCardHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "RelationCardHeaderView")
        todayCollectionView.register(UINib.init(nibName: "RelationCardHeaderSpecialView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "RelationCardHeaderSpecialView")
        todayCollectionView.register(UINib.init(nibName: "RelationCardHeaderToday", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "RelationCardHeaderToday")
        todayCollectionView.register(UINib.init(nibName: "RelationCardFooterView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "RelationCardFooterView")
    }
    
    
    @IBAction func todayRelationAction(_ sender: Any) {
        todayRelationBtn.setSelect(isSelected: true)
        favoriteRelationBtn.setSelect(isSelected: false)
        self.view.bringSubview(toFront: todayCollectionView)
    }
    @IBAction func favoriteRelationAction(_ sender: Any) {
        todayRelationBtn.setSelect(isSelected: false)
        favoriteRelationBtn.setSelect(isSelected: true)
        self.view.bringSubview(toFront: favoriteTableView)
        getFavorite()
    }
    
    func getTodayList() {
        MatchService.getTodayList(completion: { (response) in
            if let userMatchInfos = response.data as? [UserMatchInfo] {
                self.todayMatchInfos = userMatchInfos
                self.todayCollectionView.reloadData()
            }
        }) { (error) in
            
        }
    }
    
    func getTodayMore() {
        MatchService.getTodayMore(completion: { (response) in
            if let userMatchInfos = response.data as? [UserMatchInfo] {
                self.todayMatchInfos = userMatchInfos
                self.todayCollectionView.reloadData()
            }
        }) { (error) in
            
        }
    }
    
    func getFavorite() {
        var completionCount = 0
        self.showLoading()
        MatchService.getFromMe(completion: { (response) in
            if let userMatchInfos = response.data as? [UserMatchInfo] {
                let unNil = userMatchInfos.filter{ $0.targetUserInfo != nil}
                self.favoriteMembersFromMe = unNil
                self.favoriteTableView.reloadData()
                
                if completionCount == 1 {
                    self.stopLoading()
                } else {
                    completionCount += 1
                }
            }
        }) { (error) in
            if completionCount == 1 {
                self.stopLoading()
            } else {
                completionCount += 1
            }
        }
        
        MatchService.getToMe(completion: { (response) in
            if let userMatchInfos = response.data as? [UserMatchInfo] {
                self.favoriteMembersToMe = userMatchInfos
                self.favoriteTableView.reloadData()
                
                if completionCount == 1 {
                    self.stopLoading()
                } else {
                    completionCount += 1
                }
            }
        }) { (error) in
            if completionCount == 1 {
                self.stopLoading()
            } else {
                completionCount += 1
            }
        }
    }
    

    
    func getTodayCustomize() {
        MatchService.getCustomizedList(completion: { (response) in
            if let userMatchInfos = response.data as? [UserMatchInfo] {
                self.matchingMembers = userMatchInfos
                self.todayCollectionView.reloadData()
            }
        }) { (error) in
            
        }
    }
    
    func getSpecialList() {
        MatchService.getSpecialList(completion: { (response) in
            if let data = response.data as? [SpecialMember] {
                self.specialMembers = data
                self.todayCollectionView.reloadData()
            }
        }) { (error) in
            
        }
    }
    
    func pushToProfileVC(member: UserMatchInfo) {
        let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        profileVC.userSeq = member.targetUserSeq
        profileVC.isHideRelationSpecial = true
        profileVC.delegate = self
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    func getTodayChoice(todayMatchInfo : UserMatchInfo) {
        if let matchTodaySeq = todayMatchInfo.matchTodaySeq {
            self.showLoading()
            MatchService.getTodayChoice(userSeq: matchTodaySeq, completion: { (response) in
                self.stopLoading()
                self.pushToProfileVC(member: todayMatchInfo)
                todayMatchInfo.paidDate = Date().timeIntervalSince1970
            }) { (error) in
                self.stopLoading()
            }
        }
    }
    
    
    func getTodayChoiceFree(todayMatchInfo : UserMatchInfo) {
        if let matchTodaySeq = todayMatchInfo.matchTodaySeq {
            self.showLoading()
            MatchService.getTodayChoiceFree(userSeq: matchTodaySeq, completion: { (response) in
                self.stopLoading()
                self.pushToProfileVC(member: todayMatchInfo)
                todayMatchInfo.paidDate = Date().timeIntervalSince1970
            }) { (error) in
                self.stopLoading()
            }
        }
    }
    
    
    func alertDeleteFavoriteMember(index: Int, isFromMe: Bool) {
        let alert = UIAlertController.init(title: nil, message: "해당 내역을 삭제 하시겠습니까?”", preferredStyle: .alert)
        let okAction = UIAlertAction.init(title: "확인", style: .default, handler: { (action) in
            let target  = (isFromMe ? self.favoriteMembersFromMe[index].interestMatchSeq : self.favoriteMembersToMe[index].interestMatchSeq)
            MatchService.deleteFavorite(interestMatchSeq:target ?? 0 , completion: { (response) in
                if isFromMe {
                    self.favoriteMembersFromMe.remove(at: index)
                } else {
                    self.favoriteMembersToMe.remove(at: index)
                }
                DispatchQueue.main.async {
                    self.favoriteTableView.reloadData()
                }
            }, fail: { (error) in
                
            })
        })
        let cancelAction = UIAlertAction.init(title: "취소", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        })
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    func checkHasLogined() {
        if let userLogin = Context.getUserLogin() {
            if userLogin.latestLoginTime == nil{
                let popup = MainPopup6.instanceFromNib()
                popup.actionOk = {
                    [weak self] in
                    guard let _self = self else {return}
                    let vc = MyInfoMainViewController.init(nibName: "MyInfoMainViewController", bundle: nil)
                    _self.navigationController?.pushViewController(vc, animated: true)
                }
                popup.show()
            }
        }
    }
    
    // if one user have paidDate
    func hasGetTodayFree() ->Bool{
        for member in todayMatchInfos{
            if member.paidDate != nil{
                return true
            }
        }
        return false
    }
    
    func isShowLock(member:UserMatchInfo) -> Bool {
        if hasGetTodayFree() {
            return member.paidDate == nil
        } else {
            return false
        }
    }
    
    @objc func dissMissBubbleView() {
        self.bubbleView?.removeFromSuperview()
        self.buttonDissMissBubble?.removeFromSuperview()
    }
}

extension RelationCardController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            if favoriteMembersFromMe.count > 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteMemberCell") as! FavoriteMemberCell
                cell.setupData(members: self.favoriteMembersFromMe, isFromMe: true)
                cell.showMoreAction = {
                    [weak self] in
                    guard let _self = self else {return}
                    _self.isFromMeMore = true
                    _self.favoriteTableView.reloadData()
                }
                cell.selectMember = {
                    [weak self] member in
                    guard let _self = self else {return}
                    Utils.gotoUserVC(viewController: _self, userSeq: member.targetUserInfo?.userSeq ?? 0, userSpecialPopupType: .other, isHideSpecialRegist: false)
                }
                cell.deleteMember = {
                    [weak self] index in
                    guard let _self = self else {return}
                    _self.alertDeleteFavoriteMember(index: index, isFromMe: true)
                }
                cell.letterAction = {
                    [weak self] status, index in
                    guard let _self = self else {return}
                    Utils.messageAction(user: _self.favoriteMembersFromMe[index].targetUserInfo!, viewController: _self)
                }
                return cell
                
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteMemberNoDataCell") as! FavoriteMemberNoDataCell
                cell.setupData(type: 0)
                return cell
            }
        case 1:
            if favoriteMembersToMe.count > 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteMemberCell") as! FavoriteMemberCell
                cell.setupData(members: self.favoriteMembersToMe, isFromMe: false)
                cell.showMoreAction = {
                    [weak self] in
                    guard let _self = self else {return}
                    _self.isToMeMore =  true
                    _self.favoriteTableView.reloadData()
                }
                cell.selectMember = {
                    [weak self] member in
                    guard let _self = self else {return}
                    
                    if member.paidDate == nil && member.targetUserInfo?.likability == 0 {
                        _self.showLoading()
                        RelationService.getHeartCount(completion: { (response) in
                            _self.stopLoading()
                            let popup = Main3Popup.instanceFromNib(numberOfHeart: response.data as! Int, type: .popup1,nickname: member.targetUserInfo?.nickName ?? "")
                            popup.show()
                            popup.okAction = {
                                _self.showLoading()
                                MatchService.getInterestChoice(interestMatchSeq: member.interestMatchSeq ?? 0, completion: { (response) in
                                    _self.stopLoading()
                                    Utils.gotoUserVC(viewController: _self, userSeq: member.targetUserInfo?.userSeq ?? 0, userSpecialPopupType: .other, isHideSpecialRegist: true)
                                    member.paidDate = Date().timeIntervalSince1970
                                    _self.favoriteTableView.reloadRows(at: [IndexPath.init(row: 1, section: 0)], with: UITableViewRowAnimation.none)
                                }, fail: { (error) in
                                    _self.stopLoading()
                                })
                            }
                        }, fail: { (error) in
                            _self.stopLoading()
                        })
                    }else{
                        Utils.gotoUserVC(viewController: _self, userSeq: member.targetUserInfo?.userSeq ?? 0, userSpecialPopupType: .other, isHideSpecialRegist: true)
                    }
                }
                cell.deleteMember = {
                    [weak self] index in
                    guard let _self = self else {return}
                    _self.alertDeleteFavoriteMember(index: index, isFromMe: false)
                }
                cell.letterAction = {		
                    [weak self] status, index in
                    guard let _self = self else {return}
                    Utils.messageAction(user: _self.favoriteMembersToMe[index].targetUserInfo!, viewController: _self)
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteMemberNoDataCell") as! FavoriteMemberNoDataCell
                cell.setupData(type: 1)
                return cell
            }
        default:
            break
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (favoriteMembersFromMe.count == 0 && indexPath.row == 0) || (favoriteMembersToMe.count == 0 && indexPath.row == 1) {
            return tableView.frame.size.height/2
        }
        
        let numberOfMember = (indexPath.row == 0 ? favoriteMembersFromMe.count : favoriteMembersToMe.count)
        var numberOfRow = (numberOfMember + 3 - 1)/3
        if numberOfRow > 2 && !isFromMeMore {numberOfRow = 2}
        let heightOfMemberCollectionCell = ((SCREEN_WIDTH - 20 - 30)/3*1.8)
        let heightOfMembers = ((heightOfMemberCollectionCell) * CGFloat(numberOfRow))
        let height = (numberOfMember > 6 && !isFromMeMore ? 120 : 45) + heightOfMembers  + (10 * CGFloat(numberOfRow))
        return height
    }
    
}

extension RelationCardController: UICollectionViewDelegate,UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Context.getUserLogin()?.gender == "F" ? 4 : 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return todayMatchInfos.count
        case 1:
            return specialMembers.count
        case 2 :
            return 1
        case 3 :
            return matchingMembers.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0,3:
            let memberInfoCell = todayCollectionView.dequeueReusableCell(withReuseIdentifier: "MemberInfomationCell", for: indexPath) as! MemberInfomationCell
            
            var member:UserMatchInfo?
            
            if indexPath.section == 3{
                memberInfoCell.fontSize = 9
                member = matchingMembers[indexPath.row]
                memberInfoCell.setData(member: member!, isBlur: false)
                memberInfoCell.infoNewMemberBtn.isHidden = true
                memberInfoCell.infoMemberShipbtn.isHidden = true
                
            }else{
                memberInfoCell.fontSize = 11
                member = todayMatchInfos[indexPath.row]
                memberInfoCell.setData(member: member!, isBlur: self.isShowLock(member: member!))
            }
            
            memberInfoCell.callBackShowEmail = {
                [weak self] messageStatus in
                guard let _self = self else{return}
                Utils.messageAction(user: (member?.targetUserInfo!)!, viewController: _self)
            }
            
            memberInfoCell.callBackShowInfo = {
                [weak self] cell in
                guard let _self = self else{return}
                
                if (_self.bubbleView != nil && _self.bubbleView?.superview != nil) {
                    _self.bubbleView?.removeFromSuperview()
                    _self.bubbleView = nil
                    return
                }
                
                _self.bubbleView = BubbleView.loadFromXib()
                _self.bubbleView?.autoDissmiss = true
                let originY = memberInfoCell.frame.origin.y + _self.itemsSize - 20
                let tipX = CGFloat(70)
                let originX = cell.frame.origin.x - 10
                
                _self.bubbleView!.setTipX(tipX: tipX)
                _self.bubbleView!.frame = CGRect(x: originX, y: originY, width: _self.itemsSize + 20, height: 100)
                _self.bubbleView!.bubbleContentLb.text = "상대회원이 회원님에게 준 호감도 점수입니다."
                _self.todayCollectionView.addSubview(_self.bubbleView!)
                
            }
            
            memberInfoCell.callBackShowMembershipInfo = {
                [weak self] cell in
                
                guard let _self = self else{return}
                
                if (_self.bubbleView != nil && _self.bubbleView?.superview != nil) {
                    _self.bubbleView?.removeFromSuperview()
                    _self.bubbleView = nil
                    return
                }
                
                _self.bubbleView = BubbleView.loadFromXib()
                _self.bubbleView?.autoDissmiss = true
                let originY = memberInfoCell.frame.origin.y + _self.itemsSize - 20
                let tipX = _self.itemsSize - 30
                let originX = cell.frame.origin.x - 10
                
                _self.bubbleView!.setTipX(tipX: tipX)
                _self.bubbleView!.frame = CGRect(x: originX, y: originY, width: _self.itemsSize + 20, height: 100)
                _self.bubbleView!.bubbleContentLb.text = "Q1이상 등급일 경우에만, 큐클럽 심볼이 보여집니다."
                _self.todayCollectionView.addSubview(_self.bubbleView!)
                
            }
            
            return memberInfoCell
        case 1:
            let specialMemberCell = todayCollectionView.dequeueReusableCell(withReuseIdentifier: "SpeciaMemberCell", for: indexPath) as! SpeciaMemberCell
            
            let member = specialMembers[indexPath.row]
            specialMemberCell.setData(member: member)
            specialMemberCell.disableBubble = {
                [weak self] in
                guard let _self = self else{return}
                _self.bubbleView?.removeFromSuperview()
            }
            return specialMemberCell
        default:
            let optionCell = todayCollectionView.dequeueReusableCell(withReuseIdentifier: "RelationCardOptionCell", for: indexPath) as! RelationCardOptionCell
            optionCell.setUI()
            
            optionCell.callBackGetTodayCandidates = {
                Utils.checkHeartIsEnough(viewController: self,numberOfHeartIsNeed: 5, completion: { (isEnough, count) in
                    if isEnough {
                        let main1Popup2 = MainPopup.instanceFromNib(type: .main2, numberOfHeart: count)
                        main1Popup2.okAction = {
                            [weak self] in
                            guard let _self = self else {return}
                            _self.getTodayMore()
                        }
                        main1Popup2.show()
                    }
                }, fail: { (error) in
                    
                })
            }
            
            optionCell.callBackGetQ1 = {
                Utils.checkHeartIsEnough(viewController: self,numberOfHeartIsNeed: 5, completion: { (isEnough, count) in
                    if isEnough {
                        let main1Popup4 = MainPopup.instanceFromNib(type: .main4, numberOfHeart: count)
                        main1Popup4.okAction = {
                            MatchService.getAboveQ1(completion: { (response) in
                                if let member = response.data as? Member {
                                    let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                                    profileVC.isHideRelationSpecial = true
                                    profileVC.userSeq = member.userSeq
                                    self.navigationController?.pushViewController(profileVC, animated: true)
                                }
                            }, fail: { (error) in
                                let code = (error as NSError).code
                                if code == 750{
                                    self.view.makeToast("더이상 보여드릴 회원이 안계세요", duration: 2.5, position: .center)
                                }
                            })
                        }
                        main1Popup4.show()
                    }
                }, fail: { (error) in
                    
                })
            }
            
            optionCell.callBackGetTopMemberShip = {
                Utils.checkHeartIsEnough(viewController: self,numberOfHeartIsNeed: 5, completion: { (isEnough, count) in
                    if isEnough {
                        let main1Popup5 = MainPopup.instanceFromNib(type: .main5, numberOfHeart: count)
                        main1Popup5.okAction = {
                            MatchService.getAboveCharm20(completion: { (response) in
                                if let member = response.data as? Member {
                                    let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                                    profileVC.isHideRelationSpecial = true
                                    profileVC.userSeq = member.userSeq
                                    self.navigationController?.pushViewController(profileVC, animated: true)
                                }
                            }, fail: { (error) in
                                let code = (error as NSError).code
                                if code == 750{
                                    self.view.makeToast("더이상 보여드릴 회원이 안계세요", duration: 2.5, position: .center)
                                }
                            })
                        }
                        main1Popup5.show()
                    }
                }, fail: { (error) in
                    
                })
            }
            
            optionCell.callBackGetTodayHistory = {
                let historyVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main1HistoryViewController")
                self.navigationController?.pushViewController(historyVC, animated: true)
            }
            
            return optionCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0:
            return CGSize(width: itemsSize, height: itemsSize + 70)
        case 1:
            return CGSize(width: itemsSize, height: itemsSize)
        case 2 :
            return CGSize(width: SCREEN_WIDTH - 30, height: 300)
        default:
            let width = (SCREEN_WIDTH - 41)/3
            return CGSize(width: width, height: width  + 70)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader{
            switch indexPath.section {
            case 0:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "RelationCardHeaderView", for: indexPath) as! RelationCardHeaderView
                header.setData()
                return header
            case 1:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "RelationCardHeaderSpecialView", for: indexPath) as! RelationCardHeaderSpecialView
                header.callBackShowInfo = {
                    [weak self] button in
                    
                    guard let _self = self else{return}
                    
                    if _self.bubbleView !=  nil && _self.bubbleView?.superview != nil {
                        _self.bubbleView?.removeFromSuperview()
                        _self.bubbleView = nil
                        return
                    }
                    
                    _self.bubbleView = BubbleView.loadFromXib()
//                    _self.bubbleView?.autoDissmiss = false
//                    _self.bubbleView?.timeAutoDissmiss = 5
                    let originY =  button.frame.origin.y + 15
                    let tipX = button.frame.origin.x + 10
                    
                    _self.bubbleView!.setTipX(tipX: tipX)
                    _self.bubbleView!.bubbleContentLb.text = "스페셜인연은 이성회원이 회원님의 프로필을 보고\n회원님께 큰 호감이 있어서,\n인연이 되고 싶은 강한 의사를 표현한 것 입니다."
                    _self.bubbleView!.frame = CGRect(x: 5, y: originY, width: SCREEN_WIDTH - 10, height: 90)
                    header.addSubview(_self.bubbleView!)
                    header.bringSubview(toFront: _self.bubbleView!)
                    
                    //Add fake dissmissbutton to collection
                    let buttonY = _self.todayCollectionView.cellForItem(at: IndexPath.init(row: 0, section: 1))?.frame.origin.y
                    _self.buttonDissMissBubble = UIButton.init(frame: CGRect.init(x: 5, y: buttonY ?? 0, width: SCREEN_WIDTH - 10, height: 50))
                    _self.buttonDissMissBubble?.isUserInteractionEnabled = true
                    _self.buttonDissMissBubble?.addTarget(self, action: #selector(_self.dissMissBubbleView), for: .touchUpInside)
                    _self.todayCollectionView.addSubview(_self.buttonDissMissBubble!)
                    
                    // remove after bubble autoDissmiss
                    _self.bubbleView?.dissMiss = {
                        _self.dissMissBubbleView()
                    }
                }
                return header
            case 3:
                let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "RelationCardHeaderToday", for: indexPath) as! RelationCardHeaderToday
                return header
            default:
                break
            }
        } else if kind == UICollectionElementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "RelationCardFooterView", for: indexPath) as! RelationCardFooterView
            return footer
        }
        return UICollectionReusableView()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.bubbleView !=  nil{
            self.bubbleView?.removeFromSuperview()
            self.bubbleView = nil
        }
        
        switch indexPath.section {
        case 0:
            let member = todayMatchInfos[indexPath.row]
            
            if hasGetTodayFree() {
                // already choice a free card
                if member.paidDate != nil {
                    self.pushToProfileVC(member: member)
                } else {
                    Utils.checkHeartIsEnough(viewController: self, numberOfHeartIsNeed: 3, completion: { (isEnough, count) in
                        if isEnough {
                            let main1popup1 = MainPopup.instanceFromNib(type: .main1, numberOfHeart: count)
                            main1popup1.okAction = {
                                self.getTodayChoice(todayMatchInfo: member)
                            }
                            main1popup1.show()
                        }
                    }, fail: { (error) in
                        
                    })
                }
            } else {
                // never choice a free card
                let alert = UIAlertController.init(title: nil, message: "프로필을 확인 하시겠습니까?", preferredStyle: .alert)
                let okAction = UIAlertAction.init(title: "확인", style: .default, handler: { (action) in
                    self.getTodayChoiceFree(todayMatchInfo: member)
                })
                let cancelAction = UIAlertAction.init(title: "취소", style: .default, handler: { (action) in
                    alert.dismiss(animated: true, completion: nil)
                })
                alert.addAction(okAction)
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)
            }
            break
        case 1:
            let member = self.specialMembers[indexPath.row]
            if let _ = member.paidDate {
                let alert = UIAlertController.init(title: nil, message: "프로필을 확인 하시겠습니까?", preferredStyle: .alert)
                let okAction = UIAlertAction.init(title: "확인", style: .default, handler: { (action) in
                    let member = self.specialMembers[indexPath.row]
                    let profileVC = UIStoryboard.init(name: "RelationCard", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                    profileVC.isHideRelationSpecial = true
                    profileVC.userSeq = member.sendUserSeq
                    profileVC.delegate = self
                    self.navigationController?.pushViewController(profileVC, animated: true)
                })
                let cancelAction = UIAlertAction.init(title: "취소", style: .default, handler: { (action) in
                    alert.dismiss(animated: true, completion: nil)
                })
                alert.addAction(okAction)
                alert.addAction(cancelAction)
                self.present(alert, animated: true, completion: nil)
                break
                
            } else {
                var type = PopupType.main31
                if member.paidTarget == "Y" {
                    type = .main32
                } else {
                    type = .main31
                }
                
                self.showLoading()
                RelationService.getHeartCount(completion: { (reponse) in
                    self.stopLoading()
                    let main1Popup3 = MainPopup.instanceFromNib(type: type, numberOfHeart: reponse.data as! Int, senderNickname : member.nickname)
                    main1Popup3.okAction = {
                        [weak self] in
                        guard let _self = self else {return}
                        if type == .main31 {
                            Utils.checkHeartIsEnough(viewController: _self, numberOfHeartIsNeed: 3, completion: { (isEnough, count) in
                                if isEnough {
                                    _self.showLoading()
                                    MatchService.getSpecialChoice(userSeq: member.matchSpecialSeq ?? 0, completion: { (response) in
                                        _self.stopLoading()
                                        let profileVC = UIStoryboard.init(name: "RelationCard", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                                        profileVC.isHideRelationSpecial = true
                                        profileVC.userSeq = member.sendUserSeq
                                        profileVC.delegate = self
                                        _self.navigationController?.pushViewController(profileVC, animated: true)
                                    }, fail: { (error) in
                                        _self.stopLoading()
                                    })
                                    
                                }
                            }, fail: { (error) in
                                
                            })
                        } else {
                            let profileVC = UIStoryboard.init(name: "RelationCard", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
                            profileVC.isHideRelationSpecial = true
                            profileVC.userSeq = member.sendUserSeq
                            profileVC.delegate = self
                            _self.navigationController?.pushViewController(profileVC, animated: true)
                        }
                        
                    }
                    main1Popup3.show()
                }, fail: { (error) in
                    
                })
            }
            
            
        case 3:
            let alert = UIAlertController.init(title: nil, message: "프로필을 확인 하시겠습니까?", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "확인", style: .default, handler: { (action) in
                let member = self.matchingMembers[indexPath.row]
                self.pushToProfileVC(member: member)
            })
            let cancelAction = UIAlertAction.init(title: "취소", style: .default, handler: { (action) in
                alert.dismiss(animated: true, completion: nil)
            })
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
            break
        default:
            break
        }
    }
    
    
}

extension RelationCardController : UICollectionViewDelegateFlowLayout{
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        switch section {
        case 0,1,3:
            return CGSize.init(width: SCREEN_WIDTH, height: 20)
        default:
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: SCREEN_WIDTH, height: 50)
        case 1:
            if specialMembers.count > 0 {
                return CGSize(width: SCREEN_WIDTH, height: 70)
            } else {
                return CGSize.zero
            }
        case 3:
            return (Context.getUserLogin()?.gender == "F" && matchingMembers.count > 0) ? CGSize(width: SCREEN_WIDTH, height: 50) : CGSize.zero
        default:
            return CGSize.zero
        }
    }
    
}

extension RelationCardController: ProfileViewDelegate{
    func willMoveToParent() {
        getTodayList()
        getSpecialList()
        getTodayCustomize()
    }
}

extension RelationCardController: UserLetterViewControllerDelegate{
    func sendImageSuccess() {
        getTodayList()
        getSpecialList()
        getTodayCustomize()
    }
}


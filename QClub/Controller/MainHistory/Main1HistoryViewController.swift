//
//  Main1HistoryViewController.swift
//  QClub
//
//  Created by SMR on 10/13/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

/*
 Main1_history, Page 43 in StoryBoard
 */

class Main1HistoryViewController: BaseViewController {

    @IBOutlet weak var navigationView: NavigationBarQClub!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var datas = [[UserMatchInfo]]()
    var dataDay = [String]()
    
    struct identifier {
        static let memberInfomationCell = "MemberInfomationCell"
        static let memberInfomationHeader = "Main1HistoryHeader"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func configNavigationBar() {
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        navigationView.config(title: "Today 인연 히스토리", image: "ic_navigation_main_history")
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "MainHistoryHeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: identifier.memberInfomationHeader)
    }
    
    
    func getData() {
        self.showLoading()
        MatchService.getTodayHistory(completion: { (response) in
            if let data = response.data as? [UserMatchInfo] {
                self.datas.removeAll()
                self.dataDay.removeAll()
                self.sortDatasByDay(data: data)
                self.collectionView.reloadData()
                self.stopLoading()
            }
        }) { (error) in
            
        }
    }
    
    func sortDatasByDay(data : [UserMatchInfo]) {
        self.dataDay.removeAll()
        self.datas.removeAll()
        
        let dataValid = data.filter {$0.targetUserInfo != nil}
        
        for info in dataValid {
            if let matchedDate = info.matchedDate {
                let dateString = Date.init(timeIntervalSince1970: matchedDate/1000).toMatchHistoryString()
                if dataDay.contains(dateString) {
                    datas[dataDay.index(of: dateString)!].append(info)
                } else {
                    var dataNew = [UserMatchInfo]()
                    dataNew.append(info)
                    dataDay.append(dateString)
                    self.datas.append(dataNew)
                }
            }
        }
    }


}
extension Main1HistoryViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return datas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let memberInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier.memberInfomationCell, for: indexPath) as! MemberInfomationCell
        
        var member:UserMatchInfo?
        
        memberInfoCell.fontSize = 9
        member = datas[indexPath.section][indexPath.row]
        memberInfoCell.setData(member: member!, isBlur: member?.paidDate == nil)
        memberInfoCell.infoNewMemberBtn.isHidden = true
        memberInfoCell.infoMemberShipbtn.isHidden = true
        
        memberInfoCell.callBackShowEmail = {
            [weak self] messageStatus in
            guard let _self = self else{return}
            Utils.messageAction(user: (member?.targetUserInfo)!, viewController: _self)
        }
        return memberInfoCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.collectionView.frame.size.width - 45)/2 , height: ((self.collectionView.frame.size.width - 45)/2) + 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier.memberInfomationHeader, for: indexPath) as! MainHistoryHeaderCollectionReusableView
            headerView.setTitle(text: dataDay[indexPath.section])
            return headerView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let member = datas[indexPath.section][indexPath.row]
        if member.paidDate == nil {
            Utils.checkHeartIsEnough(viewController: self, numberOfHeartIsNeed: 3, completion: { (isEnough, count) in
                if isEnough {
                    let popup = Main1HistoryPopup.instanceFromNib(numberOfHeart: count)
                    popup.actionOK = {
                        [weak self] in
                        guard let _self = self else {return}
                        _self.showLoading()
                        MatchService.getTodayHistoryChoice(matchTodaySeq: member.matchTodaySeq ?? 0, completion: { (response) in
                            _self.stopLoading()
                            Utils.gotoUserVC(viewController: _self, userSeq: member.targetUserInfo?.userSeq ?? 0, userSpecialPopupType: .other, isHideSpecialRegist: true)
                            member.paidDate = Date().timeIntervalSince1970
                            _self.collectionView.reloadData()
                        }, fail: { (error) in
                            _self.stopLoading()
                        })
                    }
                    popup.show()
                }
            }, fail: { (error) in
                
            })

        } else {
            Utils.gotoUserVC(viewController: self, userSeq: member.targetUserInfo?.userSeq ?? 0, userSpecialPopupType: .other, isHideSpecialRegist: true)
        }
    }
}
extension Main1HistoryViewController : UserLetterViewControllerDelegate {
    func sendImageSuccess() {
        getData()
    }
}

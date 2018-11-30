//
//  GroundMeetingDetailViewController.swift
//  QClub
//
//  Created by TuanNM on 10/13/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

/*
 ground_meeting_detail ,Page 69 in StoryBoard
 */
class GroundMeetingDetailViewController: UIViewController {
    
    @IBOutlet weak var tbView: UITableView!
    @IBOutlet weak var navigationBar: NavigationBarQClub!
    
    var viewModel = GroundMeetingDetailViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.config(title: "흥미진진 3:3미팅", image: "ic_ground_metting_white.png")
        navigationBar.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        tbView.rowHeight = UITableViewAutomaticDimension
        tbView.estimatedRowHeight = 150
        
        self.showLoading()
        viewModel.getData {
            self.tbView.reloadData()
            self.stopLoading()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func modifyApeal() {
        let text = tbView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! GroundMeetingDetailCell
        if text.appealTextView.text.count > 0 {
            MeetingService.modifyApeal(appeal: text.appealTextView.text, completion: { (response) in
                print("Modify apeal to : \(text.appealTextView.text)")
                UIApplication.shared.keyWindow?.currentViewController()?.view.makeToast("정상적으로 수정되었습니다", duration: 2.0, position: .center)
            }, fail: { (error) in
                
            })
        }
    }
    
    
    func avatarTouch(playerView : PlayerView) {
        
        guard let user = playerView.user else{return}
        if Utils.nowIn12To18h() {
            self.showLoading()
            self.viewModel.getViewUser(targetUserSeq: playerView.user?.userSeq ?? 0, completion: { (profile) in
                self.stopLoading()
                profile?.level = playerView.user?.qlevel ?? ""
                let popup = MeetingDetailPopup1.instanceFromNib(user: profile)
                popup.select = {
                    [weak self] in
                    guard let _self = self else {return}
                    _self.connectToUser(playerView: playerView)
                }
                popup.show()
            })
        }else
            if Utils.nowIn18To24h() {
            if viewModel.targetAndMeIsConnected(user: user) {
                self.showHeartPopup(user: user)
            } else {
                self.showLoading()
                self.viewModel.getViewUser(targetUserSeq: user.userSeq ?? 0, completion: { (profile) in
                    self.stopLoading()
                    profile?.level = user.qlevel ?? ""
                    let popup = MeetingDetailPopup2.instanceFromNib(user: profile)
                    
                    popup.select40 = {
                        [weak self] in
                        guard let _self = self else {return}
                        _self.viewModel.registSpecial40(viewController: _self, userSeq: user.userSeq ?? 0)
                    }
                    popup.select42 = {
                        [weak self] in
                        guard let _self = self else {return}
                        _self.viewModel.registSpecial42(viewController: _self, userSeq: user.userSeq ?? 0)
                    }
                    popup.show()
                })
                
            }
        }
        
    }
    
    func connectToUser(playerView : PlayerView){
        let cell = self.tbView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! GroundMeetingDetailCell
        let meetingView = cell.playerMeeting
        
        self.showLoading()
        MeetingService.choiceMeetingUser(meetingSeq: self.viewModel.meetingSeq, targetUserSeq: playerView.user?.userSeq ?? 0, completion: { (response) in
            self.stopLoading()
            meetingView?.disconnectL11()
            meetingView?.disconnectL12()
            meetingView?.disconnectL13()
            
            switch playerView.tag {
            case 4:
                meetingView?.connectL11()
            case 5:
                meetingView?.connectL12()
            case 6:
                meetingView?.connectL13()
            default:
                break
            }
        }) { (error) in
            
        }
        
        
    }
}

extension GroundMeetingDetailViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: "GroundMeetingDetailCell") as! GroundMeetingDetailCell
        cell.setData(players: viewModel.members)
        cell.avatarTouch = {
            [weak self] playerView in
            guard let _self = self else { return  }
            if playerView.user?.gender != Context.getUserLogin()?.gender {
                _self.avatarTouch(playerView: playerView)
            }
        }
        
        cell.appealChange = {
            [weak self] in
            guard let _self = self else { return  }
            _self.modifyApeal()
        }
        
        return cell
    }
    
    func showHeartPopup(user : UserMeetingRoom){
        Utils.checkHeartIsEnough(viewController: self, numberOfHeartIsNeed: 5, completion: { (isEnough, count) in
            let heartView = HeartView(nibName: "HeartView", bundle: nil)
            heartView.myHeart = "\(count)"
            heartView.price = "0"
            heartView.popupTitle = "커플 상세프로필 확인!"
            heartView.popupMessage = "와아~~ 추카드려요~ 서로 호감화살을 쏘셨네요~ \n상대 회원의 상세프로필을 확인하실 수 있어요"
            heartView.buttonContent = "상대회원 상세프로필보기"
            
            self.addChildViewController(heartView)
            self.view.addSubview(heartView.view)
            
            heartView.callBackSelect = {
                [weak self] in
                guard let _self = self else {return}
                
                if let userSeq = user.userSeq{
                    Utils.gotoUserVC(viewController: _self, userSeq: userSeq, userSpecialPopupType: UserSpecialPopup.PopupType.meeting)
                }
            }
        }) { (error) in
            
        }
        
        
    }
    
    func showMettingDetailPopUp(type: MeetingPopUp){
        let playerView = PlayerPopupView(nibName: "PlayerPopupView", bundle: nil)
        playerView.view.frame = view.frame
        playerView.view.alpha = 0
        self.addChildViewController(playerView)
        self.view.addSubview(playerView.view)
        playerView.popupType = type
        
        UIView.animate(withDuration: 0.5, animations: {
            playerView.view.alpha = 1
        })
        
        playerView.callBackSelect = {
            
        }
    }
}

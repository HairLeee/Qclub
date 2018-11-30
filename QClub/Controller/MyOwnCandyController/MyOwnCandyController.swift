//
//  MyOwnCandyController.swift
//  QClub
//
//  Created by Dream on 9/13/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import IQDropDownTextField
import SendBirdSDK

/*
 Candy, Page 55 in StoryBoard
 */

class MyOwnCandyController: UIViewController {


    var scrollviewCandy: CandyViewController?
    var registerWaitingView: CandyRegisterWaitingViewController?
    var talkView: CandyTalkViewController?
    var registerView: ViewRegisterViewController?
    var searchListView: SearchListViewController?
    @IBOutlet weak var candyContainer: UIView!
    @IBOutlet weak var registerWaitingContainer: UIView!
    @IBOutlet weak var talkContainer: UIView!
    @IBOutlet weak var registerContainer: UIView!
    @IBOutlet weak var searchListContainer: UIView!

    enum currentScreen {
        case candy
        case searchList
        case register
        case registerWaiting
        case talk
    }
    var currentStatus = currentScreen.candy
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getStatus()
        setupAction()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? CandyViewController {
            self.scrollviewCandy = vc
        } else if let vc = segue.destination as? CandyRegisterWaitingViewController {
            self.registerWaitingView = vc
        } else if let vc = segue.destination as? CandyTalkViewController {
            self.talkView = vc
        } else if let vc = segue.destination as? ViewRegisterViewController {
            self.registerView = vc
        } else if let vc = segue.destination as? SearchListViewController {
            self.searchListView = vc
        }
    }
    

    func setupUI(status : CandyStatusModel) {
        switch status.status {
        case .freeCandy?:
            if status.candyUserCount == 0 {
                self.view.bringSubview(toFront: self.candyContainer)
            } else {
                self.view.bringSubview(toFront: self.searchListContainer)
            }
        case .waitingCandy?:
            self.view.bringSubview(toFront: self.registerWaitingContainer)
        case .candyInChat?:
            self.view.bringSubview(toFront: self.talkContainer)
            self.talkView?.setupData(userSeq: status.hostUserSeq ?? 0)
        case .none:
            break
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(candySelected), name: NSNotification.Name(rawValue: Constants.Notifications.CandySelect), object: nil)
    }
    
    @objc func candySelected() {
        if currentStatus == currentScreen.searchList || currentStatus == currentScreen.register {
            self.view.bringSubview(toFront: self.candyContainer)
        }
    }
    
    func getStatus() {
        self.showLoading()
        CandyService.getStatus(completion: { (response) in
            if let status = response.data as? CandyStatusModel {
                self.setupUI(status: status)
            }
            self.stopLoading()
        }) { (error) in
            self.stopLoading()
        }
    }

    
    func gotoLiskTalk(channel: SBDGroupChannel?, member: CandyMemberModel) {
        let talkVC = self.storyboard?.instantiateViewController(withIdentifier: "CandyListTalkViewController") as! CandyListTalkViewController
        talkVC.member = member
        talkVC.channel = channel
        self.navigationController?.pushViewController(talkVC, animated: true)
    }
    
//    func createChannel(user: CandyMemberModel) {
//        let myUser : Int = Context.getUserLogin()?.userSeq ?? 0
//        SBDGroupChannel.createChannel(withName: Constants.ChannelName.Candy, isDistinct: false, userIds: ["\(myUser)","\(user.userSeq)"], coverUrl: nil, data: nil, completionHandler: { (channel, error) in
//            self.stopLoading()
//            if error != nil {
//                NSLog("Error: %@", error!)
//                return
//            } else {
//                channel?.createMetaData(["list_seq": "\(myUser)"], completionHandler: { (response, error) in
//
//                })
//                self.gotoLiskTalk(channel: channel, member: user)
//            }
//        })
//    }
//
//    func checkChannel(user: CandyMemberModel) {
//        self.showLoading()
//        let query = SBDGroupChannel.createMyGroupChannelListQuery()
//        query?.setUserIdsExactFilter(["\(user.userSeq)"])
//        query?.loadNextPage(completionHandler: { (channels, error) in
//            if let channelsUnwrap = channels {
//                for channel in channelsUnwrap {
//                    if channel.name == Constants.ChannelName.Candy {
//                        self.gotoLiskTalk(channel: channel, member: user)
//                        self.stopLoading()
//                        return
//                    }
//                }
//                self.createChannel(user: user)
//            } else {
//                self.createChannel(user: user)
//            }
//
//        })
//    }


    func setupAction() {
        self.scrollviewCandy?.freeCandySearch = {
            [weak self] in
            guard let _self = self else {return}
            _self.view.bringSubview(toFront: _self.searchListContainer)
            self?.currentStatus = .searchList
        }
        
        self.scrollviewCandy?.freeCandyRegister = {
            [weak self] in
            guard let _self = self else {
                return
            }
            _self.view.bringSubview(toFront: _self.registerContainer)
            self?.currentStatus = .register
        }
        
        registerWaitingView?.registerWaitingAction = {
            [weak self] in
            guard let _self = self else {return}
            _self.showLoading()
            CandyService.candyCancel(completion: { (response) in
                _self.stopLoading()
                _self.view.bringSubview(toFront: _self.candyContainer)
                self?.currentStatus = .candy
            }, fail: { (error) in
                _self.stopLoading()
            })
        }
        
        registerView?.registerOkAction = {
            [weak self] in
            guard let _self = self else {return}
            _self.view.bringSubview(toFront: _self.registerWaitingContainer)
            self?.currentStatus = .registerWaiting
        }
        
        registerView?.registerCancelAction = {
            [weak self] in
            guard let _self = self else {return}
            _self.view.bringSubview(toFront: _self.candyContainer)
            self?.currentStatus = .candy
        }
        
        searchListView?.goToListTalk = {
            [weak self] member in
            guard let _self = self else {return}
            Utils.createOrGetChannel(channelType: Constants.ChannelName.Candy, viewController: _self, userSeq: member.userSeq, completion: { (channel) in
                self?.gotoLiskTalk(channel: channel, member: member)
                self?.currentStatus = .talk
            }, fail: { (error) in
                
            })
            
        }
        
        searchListView?.goToStore = {
            [weak self] in
            guard let _self = self else {return}
            Utils.gotoStore(viewController: _self)
        }
        
        searchListView?.goToUserVC = {
            [weak self] userSeq in
            guard let _self = self else {return}
            Utils.gotoUserVC(viewController: _self, userSeq: userSeq, userSpecialPopupType : UserSpecialPopup.PopupType.candy)
        }
        
        searchListView?.goToRegisterVC = {
            [weak self] userSeq in
            guard let _self = self else {return}
            _self.view.bringSubview(toFront: _self.registerContainer)
            self?.currentStatus = .register
        }
        
    }
    
}







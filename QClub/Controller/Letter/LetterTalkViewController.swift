//
//  LetterTalkViewController.swift
//  QClub
//
//  Created by SMR on 10/17/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import SendBirdSDK

/*
 Letter_talk, Page 53 in StoryBoard
 */
class LetterTalkViewController: BaseViewController {

    @IBOutlet weak var navigationView: NavigationBarQClub!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var chatContainer: UIView!
    var chattingView : ChattingViewController!
    var groupChannel: SBDGroupChannel?
    var interestMessageSeq = 0
    var targetUser: TargetUserInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func configNavigationBar() {

        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        
        navigationView.rightAction = {
            let deletePopup = Main3PopupDelete.instanceFromNib(deleteSide: .inSideChat)
            deletePopup.actionOk = {
                [weak self] in
                guard let _self = self else { return  }
                _self.showLoading()
                _self.groupChannel?.createMetaData([Constants.SendBirdMetaData.IsClose : "YES"], completionHandler: { (response, error) in
                    DispatchQueue.main.async {
                        _self.stopLoading()
                        _self.navigationController?.popViewController(animated: true)
                    }
                })
            }
            deletePopup.show()
        }
    }
    
    
    func setupInfo() {
        self.showLoading()
        ProfileService.getProfileBasic(userSeq: targetUser?.userSeq ?? 0, completion: { (response) in
            self.stopLoading()
            if let user = response.data as? Member {
                let nickName = self.targetUser?.nickName ?? ""
                let location = self.targetUser?.location ?? ""
                let age = self.targetUser?.age ?? 0
                let job = self.targetUser?.job ?? ""
                var text = "\(nickName)님은\(location)에 거주하며,\(age)세이며, 직업은 \(job)이며"
                text.append(", \(user.userStyles)")
                text += "스타일입니다."
                self.lbContent.text = text
                
                self.navigationView.config(title: self.targetUser?.nickName ?? "", image: self.targetUser?.gender == "F" ? "ic_navigation_woman" : "ic_navigation_man", rightBtnImage: "ic_navigation_delete")
            }
        }, fail: { (error) in
            self.stopLoading()
        })
    }
    
    func setupUI() {
        /*
        if let channel = groupChannel {
            if let url = channel.getInviter()?.profileUrl {
                if url.contains("http") {
                    imageAvatar.kf.setImage(with: URL.init(string: url))
                } else {
                    imageAvatar.kf.setImage(with: URL.init(string: "http://\(url)"))
                }
            }
        }
        */
        
        
        if let avatar = self.targetUser?.profilePicture {
            imageAvatar.kf.setImage(with: URL.init(string: avatar))
        }
        
        self.groupChannel?.getMetaData(withKeys: [Constants.SendBirdMetaData.IsClose], completionHandler: { (response, error) in
            DispatchQueue.main.async {
                if let data = response {
                    if let isClose = data[Constants.SendBirdMetaData.IsClose] as? String {
                        if isClose == "YES" {
                            let nickName = self.targetUser?.nickName ?? ""
                            self.lbContent.text = "\(nickName)님이 대화창에서 나가셨습니다."
                            self.chattingView.view.isHidden = true
                            self.navigationView.config(title: self.targetUser?.nickName ?? "", image: self.targetUser?.gender == "F" ? "ic_navigation_woman" : "ic_navigation_man", rightBtnImage: nil)
                        } else {
                            self.setupInfo()
                        }
                    } else {
                        self.setupInfo()
                    }
                } else {
                    self.setupInfo()
                }
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ChattingViewController {
            vc.groupChannel = self.groupChannel
            self.chattingView = vc
        }
    }
    
}


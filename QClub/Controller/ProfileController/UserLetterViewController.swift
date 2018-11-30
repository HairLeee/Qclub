//
//  UserLetterViewController.swift
//  QClub
//
//  Created by SMR on 10/12/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import Kingfisher

protocol UserLetterViewControllerDelegate {
    func sendImageSuccess()
}

/*
 User_letter, Page 40 in StoryBoard
 */

class UserLetterViewController: BaseViewController {
    
    @IBOutlet weak var navigationView: NavigationBarQClub!
    @IBOutlet weak var imageAvatarBackground: UIImageView!
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var tvMessage: UITextView!
    @IBOutlet weak var numberOfHeartToSend1: UILabel!
    @IBOutlet weak var numberOfHeartToSend2: UILabel!
    @IBOutlet weak var buttonSend1: UIButton!
    @IBOutlet weak var buttonSend2: UIButton!
    
    var delegate : UserLetterViewControllerDelegate?
    var member: Member?
    var userMatchInfo: TargetUserInfo?
    var isRequestSpecialRelation = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
          setupUI()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI(){
        buttonSend1.alpha = 0.5
        buttonSend2.alpha = 0.5
        imageAvatarBackground.clipsToBounds = true
        imageAvatarBackground.contentMode = .scaleAspectFill
        imageAvatar.clipsToBounds = true
        imageAvatar.layer.cornerRadius = imageAvatar.frame.size.height/2
        
        if let memberUnwrap = self.member {
            if let profileImages = memberUnwrap.profilePicture {
                let imageURl = profileImages[0].profilePictureUrl
                imageAvatarBackground.kf.setImage(with: URL.init(string: imageURl))
                imageAvatar.kf.setImage(with: URL.init(string: imageURl))
            }
            lbName.text = memberUnwrap.nickname
            getLookForData(userSeq: memberUnwrap.userSeq)
        } else {
            if let targetUserInfoUnwrap = self.userMatchInfo {
                
                let imageURl = targetUserInfoUnwrap.profilePicture
                imageAvatarBackground.kf.setImage(with: URL.init(string: imageURl))
                imageAvatar.kf.setImage(with: URL.init(string: imageURl))
                lbName.text = targetUserInfoUnwrap.nickName ?? ""
                getLookForData(userSeq: targetUserInfoUnwrap.userSeq ?? 0)
            }
        }
        
        
        if isRequestSpecialRelation {
            numberOfHeartToSend1.text = "20"
            numberOfHeartToSend2.text = "25"
        } else {
            numberOfHeartToSend1.text = "35"
            numberOfHeartToSend2.text = "40"
        }
        
        tvMessage.delegate = self
    }
    
    func getLookForData(userSeq: Int) {
        self.showLoading()
        ProfileService.getProfileBasic(userSeq: userSeq, completion: { (response) in
            if let member = response.data as? Member {
                self.updateDesLayout(nameOfYourFriend: member.nickname, lookFor: member.lookFor ?? "")
            }
            self.stopLoading()
        }) { (error) in
            self.stopLoading()
        }
    }
    
    
    func updateDesLayout(nameOfYourFriend:String, lookFor : String){
        lbContent.text = "\(nameOfYourFriend)님은 \(lookFor)을 찾고 계십니다.\n관심편지 작성 시 어필내용으로 참고하시면 도움 되실 거예요.\n정성이 진심이 담긴 관심편지가 마음을 움직입니다.~"
    }
    
    @IBAction func send1TUI(_ sender: Any) {
        var userSeq = 0
        if let memberUnwrap = self.member {
            userSeq = memberUnwrap.userSeq
        } else if let targetUnwrap = self.userMatchInfo {
            userSeq = targetUnwrap.userSeq ?? 0
        }
        
        Utils.checkHeartIsEnough(viewController: self, numberOfHeartIsNeed: (isRequestSpecialRelation ? 20 : 35), completion: { (isEnough, count) in
            if isEnough {
                MessageService.sendMessageUser(userSeq: userSeq, message: self.tvMessage.text, alreadyPaid: false, completion: { (response) in
                    Utils.createOrGetChannel(channelType: Constants.ChannelName.Letter, viewController: self, userSeq: userSeq, completion: { (channel) in
                        
                        channel.sendUserMessage(self.tvMessage.text, completionHandler: { (message, error) in
                            print("Send message to sendbird success")
                        })
                        
                    }, fail: { (error) in
                        print("Send message to sendbird error: \(error)")
                    })
                    
                    self.view.makeToast("관심편지가 전송되었습니다", duration: 2, position: .center, title: nil, image: nil, style: nil, completion: { (done) in
                        self.delegate?.sendImageSuccess()
                        self.navigationController?.popViewController(animated: true)
                    })
                    
                }, fail: { (error) in
                    self.view.makeToast("이미 보내셨습니다.")
                })
            }
        }, fail: { (error) in
            
        })

    }
    
    @IBAction func send2TUI(_ sender: Any) {
        var userSeq = 0
        if let memberUnwrap = self.member {
            userSeq = memberUnwrap.userSeq
        } else if let targetUnwrap = self.userMatchInfo {
            userSeq = targetUnwrap.userSeq ?? 0
        }
        
        Utils.checkHeartIsEnough(viewController: self, numberOfHeartIsNeed: (isRequestSpecialRelation ? 25 : 40), completion: { (isEnough, count) in
            if isEnough {
                MessageService.sendMessageUser(userSeq: userSeq, message: self.tvMessage.text, alreadyPaid: true, completion: { (response) in
                    
                    Utils.createOrGetChannel(channelType: Constants.ChannelName.Letter, viewController: self, userSeq: userSeq, completion: { (channel) in
                        channel.sendUserMessage(self.tvMessage.text, completionHandler: { (message, error) in
                            print("Send message to sendbird success")
                        })
                    }, fail: { (error) in
                        print("Send message to sendbird error: \(error)")
                    })
                    
                    self.view.makeToast("관심편지가 전송되었습니다", duration: 2, position: .center, title: nil, image: nil, style: nil, completion: { (done) in
                        self.delegate?.sendImageSuccess()
                        self.navigationController?.popViewController(animated: true)
                    })
                    
                }, fail: { (error) in
                    self.view.makeToast("이미 보내셨습니다.")
                })
            }
        }, fail: { (error) in
            
        })
    }
    
    override func configNavigationBar() {
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        navigationView.config(title: "관심편지 보내기", image: "ic_navigation_user_letter")
    }
    
}

extension UserLetterViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        buttonSend1.alpha = numberOfChars > 0 ? 1 : 0.5
        buttonSend2.alpha = numberOfChars > 0 ? 1 : 0.5
        return numberOfChars < 301
    }
}

//
//  CandyTalkViewController.swift
//  QClub
//
//  Created by SMR on 11/3/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import SendBirdSDK

/*
 candy_register_talk, Page 63 in StoryBoard
 */

class CandyTalkViewController: UIViewController {

    @IBOutlet weak var lbContentTalk: UILabel!
    @IBOutlet weak var chattingView: UIView!
    @IBOutlet weak var lbStyle: UILabel!
    @IBOutlet weak var lbName: UILabel!
    var chattingVC : ChattingViewController!
    var groupChannel: SBDGroupChannel!
    var userSeq = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setupData(userSeq : Int) {
        self.userSeq = userSeq
        Utils.createOrGetChannel(channelType: Constants.ChannelName.Candy, viewController: self, userSeq: userSeq, completion: { (channel) in
            self.chattingVC.updateChannel(channel: channel)
        }) { (error) in
            print("Error: %@", error)
        }
        
        ProfileService.getProfileBasic(userSeq: userSeq, completion: { (response) in
            if let profile = response.data as? Member {
                self.lbName.text = profile.nickname
                self.lbStyle.text = profile.userStyles + " 캔디입니다."
            }
        }) { (error) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupRegisterTalk() {
        lbContentTalk.attributedText = Utils.getAtributedStringWithLinespace(text: "핸드폰 번호나 이메일, 카톡 아이디등 개인 연락처를 대화창에 입력하는 행위는 금지됩니다.\n이를 어길 경우 강제탈퇴 되실 수 있습니다.\n또한 이런 행위는 상대회원에게 오히려 부정적인 이미지를 줄 수 있습니다. 회원님의 품격을 잃지 마시기 바랍니다.", lineSpace: 5, alignment: .left)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ChattingViewController {
            vc.groupChannel = self.groupChannel
            self.chattingVC = vc
        }
    }

}

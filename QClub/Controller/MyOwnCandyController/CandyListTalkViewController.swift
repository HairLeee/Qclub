//
//  CandyListTalkViewController.swift
//  QClub
//
//  Created by SMR on 11/1/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import SendBirdSDK

/*
 candy_list_talk , Page 59 in StoryBoard
 */
class CandyListTalkViewController: BaseViewController {

    var member : CandyMemberModel?
    var channel : SBDGroupChannel?
    @IBOutlet weak var viewChat: UIView!
    var chatContainer : ChattingViewController?
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbStyles: UILabel!
    
    
    @IBOutlet weak var navigationView: NavigationBarQClub!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateListSeq()
        setupUI()
    }
    
    func updateListSeq() {
        if let channelUnwrap = self.channel {
            channelUnwrap.createMetaData([Constants.SendBirdMetaData.ListSeq : "\(member?.candyListSeq ?? 0)"], completionHandler: { (response, error) in
                
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
//        lbName.text = member?.userInfo?.nickName ?? ""
        
        ProfileService.getProfileBasic(userSeq: member?.userSeq ?? 0, completion: { (response) in
            if let profile = response.data as? Member {
                self.lbName.text = profile.nickname
                self.lbStyles.text = profile.userStyles + " 캔디입니다."
            }
        }) { (error) in
            
        }
    }
    

    override func configNavigationBar() {
        self.navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        self.navigationView.config(title: member?.userInfo?.nickName ?? "", image: member?.userInfo?.gender == "M" ? "ic_navigation_man" : "ic_navigation_woman")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? ChattingViewController {
            vc.groupChannel = self.channel
            chatContainer = vc
        }
    }

}

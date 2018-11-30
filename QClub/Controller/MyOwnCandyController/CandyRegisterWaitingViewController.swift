//
//  CandyRegisterWaitingViewController.swift
//  QClub
//
//  Created by SMR on 11/3/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

/*
 candy_register_waiting, Page 62 in StoryBoard
 */

class CandyRegisterWaitingViewController: UIViewController {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbContent: UILabel!
    @IBOutlet weak var imageRadar: UIImageView!
    @IBOutlet weak var registerWaitingCancelBtn: UIButton!
    
    var registerWaitingAction : (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRegisterWatting()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerWaitingCancel(_ sender: Any) {
        registerWaitingAction?()
    }
    

    func setupRegisterWatting() {
        //On
        lbTitle.text = "현재, ‘On 캔디’ 상태입니다."
        lbContent.attributedText = Utils.getAtributedStringWithLinespace(text: "상대방의 캔디 신청을 기다리고 있습니다.\n캔디로 선택되면 알림을 보내드립니다.")
        registerWaitingCancelBtn.setTitle("캔디되기 취소(Off 캔디)", for: .normal)
        imageRadar.image = UIImage.init(named: "ic_candy_radar")
        
//        //Off
//        lbTitle.text = "현재, ‘Off 캔디’ 상태입니다."
//        lbContent.attributedText = Utils.getAtributedStringWithLinespace(text: "Off 캔디 상태인 경우,\n상대방의 캔디신청을 받을 수 없습니다.")
//        registerWaitingCancelBtn.setTitle("On 캔디로 전환", for: .normal)
//        imageRadar.image = UIImage.init(named: "ic_candy_radar_off")
    }

}

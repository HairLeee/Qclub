//
//  GroundMeetingDetailCell.swift
//  QClub
//
//  Created by TuanNM on 10/13/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class GroundMeetingDetailCell: UITableViewCell {

    @IBOutlet weak var appealTextView: UITextView!
    @IBOutlet weak var meetingTitleLb: UILabel!
    @IBOutlet weak var lbDetail: UILabel!
    @IBOutlet weak var mettingTitleMoreLB: UILabel!
    @IBOutlet weak var mettingResultLb: UILabel!
    @IBOutlet weak var playerMeeting: PlayerMeeting!
    var players : [UserMeetingRoom] = [UserMeetingRoom(),UserMeetingRoom(),UserMeetingRoom(),UserMeetingRoom(),UserMeetingRoom(),UserMeetingRoom()]
    var leftUserSeq : [Int] = [0,0,0,0,0,0]
    var targetUserSeq : [Int] = [0,0,0,0,0,0]
    var usersLeftConnect = [(Int, Int)]()
    var usersRightConnect = [(Int, Int)]()
    var isChangingAppeal = false
    
    var appealChange : (() -> ())?
    var avatarTouch : ((_ user : PlayerView) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        playerMeeting.configStart()
        appealTextView.delegate = self
        
        lbDetail.attributedText = Utils.getAtributedStringWithLinespace(text: "본인어필을 매력있게 작성하시면, 호감화살을 받을 확률이 대폭 상승!\n본인어필은 한번만 작성하면 OK! 언제든지 수정가능~", lineSpace: 5, alignment: .left)
        
        if Utils.nowIn12To18h() {
            meetingTitleLb.text = "Meeting Time~"
            mettingTitleMoreLB.isHidden = false
            mettingResultLb.isHidden = true
            mettingResultLb.text = ""
        } else {
            meetingTitleLb.text = "두둥~ Meeting 결과 오픈"
            mettingResultLb.isHidden = false
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configMeetingResultLB(males: [String], females : [String]) {
        if males.count == 0 {
            mettingResultLb.isHidden = true
        } else if males.count == 1 {
            mettingResultLb.text = "\(males[0])님과 \(females[0])님이 커플이 됐습니다. 축하드립니다~\n커플이 되신 분은 서로 상대방의 상세 프로필을 확인할 수 있습니다."
        } else if males.count == 2 {
            mettingResultLb.text = "\(males[0])님과 \(females[0])님,\(males[1])님과 \(females[1])님이 커플이 됐습니다. 축하드립니다~\n커플이 되신 분은 서로 상대방의 상세 프로필을 확인할 수 있습니다."
        } else {
            mettingResultLb.text = "모두 커플이 되셨네요. 축하드립니다~\n커플이 되신 분은 서로 상대방의 상세 프로필을 확인할 수 있습니다."
        }
    }

    func setData(players : [UserMeetingRoom]){
        for user in players {
            if user.gender == Context.getUserLogin()?.gender {
                // same gender
                if user.userSeq == Context.getUserLogin()?.userSeq {
                    playerMeeting.playerL1.setData(user: user, isLeft: true)
                    self.players[0] = user
                    appealTextView.text = user.appeal
                } else {
                    if playerMeeting.playerL2.isSetupData() {
                        playerMeeting.playerL3.setData(user: user, isLeft: true, avatarString: user.gender == "F" ? "woman2" : "man2" )
                        self.players[2] = user
                    } else {
                        playerMeeting.playerL2.setData(user: user, isLeft: true, avatarString: user.gender == "F" ? "woman3" : "man3" )
                        self.players[1] = user
                    }
                }
            } else {
                //other gender
                if playerMeeting.playerR1.user == nil {
                    playerMeeting.playerR1.setData(user: user, isLeft: false)
                    self.players[3] = user
                } else {
                    if playerMeeting.playerR2.user == nil {
                        playerMeeting.playerR2.setData(user: user, isLeft: false)
                        self.players[4] = user
                    } else {
                        playerMeeting.playerR3.setData(user: user, isLeft: false)
                        self.players[5] = user
                    }
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.setupArrow()
        }
        setupTouch()
    }
    
    func setupUserLeftConnect() {
        for i in 0...2 {
            for j in 3...5 {
                if players[i].targetUserSeq != nil && players[i].targetUserSeq != 0 && players[i].targetUserSeq == players[j].userSeq {
                    usersLeftConnect.append((i,j))
                }
            }
        }
    }
    func setupUserRightConnect() {
        for i in 3...5 {
            for j in 0...2 {
                if players[i].targetUserSeq != nil && players[i].targetUserSeq != 0 && players[i].targetUserSeq == players[j].userSeq {
                    usersRightConnect.append((i,j))
                }
            }
        }
    }
    
    func setupArrow() {
        setupUserLeftConnect()
        setupUserRightConnect()
        

        var l11 = false,l12 = false,l13 = false, l21 = false,l22 = false,l23 = false, l31 = false,l32 = false,l33 = false
        var r11 = false,r12 = false,r13 = false, r21 = false,r22 = false,r23 = false, r31 = false,r32 = false,r33 = false
        
        for userConnect in usersLeftConnect {
            switch userConnect.0 {
            case 0:
                if userConnect.1 == 3 {
                    playerMeeting.connectL11()
                    l11 = true
                } else if userConnect.1 == 4 {
                    playerMeeting.connectL12()
                    l12 = true
                } else if userConnect.1 == 5 {
                    playerMeeting.connectL13()
                    l13 = true
                }
            case 1:
                if userConnect.1 == 3 {
                    playerMeeting.connectL21()
                    l21 = true
                } else if userConnect.1 == 4 {
                    playerMeeting.connectL22()
                    l22 = true
                } else if userConnect.1 == 5 {
                    playerMeeting.connectL23()
                    l23 = true
                }
            case 2:
                if userConnect.1 == 3 {
                    playerMeeting.connectL31()
                    l31 = true
                } else if userConnect.1 == 4 {
                    playerMeeting.connectL32()
                    l32 = true
                } else if userConnect.1 == 5 {
                    playerMeeting.connectL33()
                    l33 = true
                }
            default:
                break
            }
        }
        
        for userConnect in self.usersRightConnect {
            switch userConnect.0 {
            case 3:
                if userConnect.1 == 0 {
                    self.playerMeeting.connectR11()
                    r11 = true
                } else if userConnect.1 == 1 {
                    self.playerMeeting.connectR12()
                    r12 = true
                } else if userConnect.1 == 2 {
                    self.playerMeeting.connectR13()
                    r13 = true
                }
            case 4:
                if userConnect.1 == 0 {
                    self.playerMeeting.connectR21()
                    r21 = true
                } else if userConnect.1 == 1 {
                    self.playerMeeting.connectR22()
                    r22 = true
                } else if userConnect.1 == 2 {
                    self.playerMeeting.connectR23()
                    r23 = true
                }
            case 5:
                if userConnect.1 == 0 {
                    self.playerMeeting.connectR31()
                    r31 = true
                } else if userConnect.1 == 1 {
                    self.playerMeeting.connectR32()
                    r32 = true
                } else if userConnect.1 == 2 {
                    self.playerMeeting.connectR33()
                    r33 = true
                }
            default:
                break
            }
        }
        
        var males = [String]()
        var females = [String]()
        if l11 && r11 {
            males.append(self.players[0].gender == "M" ? self.playerMeeting.playerL1.user?.nickName ?? "" : self.playerMeeting.playerR1.user?.nickName ?? "")
            females.append(self.players[0].gender == "M" ? self.playerMeeting.playerR1.user?.nickName ?? "" : self.playerMeeting.playerL1.user?.nickName ?? "")
        } else if l12 && r21 {
            males.append(self.players[0].gender == "M" ? self.playerMeeting.playerL1.user?.nickName ?? "" : self.playerMeeting.playerR2.user?.nickName ?? "")
            females.append(self.players[0].gender == "M" ? self.playerMeeting.playerR2.user?.nickName ?? "" : self.playerMeeting.playerL1.user?.nickName ?? "")
        } else if l13 && r31 {
            males.append(self.players[0].gender == "M" ? self.playerMeeting.playerL1.user?.nickName ?? "" : self.playerMeeting.playerR3.user?.nickName ?? "")
            females.append(self.players[0].gender == "M" ? self.playerMeeting.playerR3.user?.nickName ?? "" : self.playerMeeting.playerL1.user?.nickName ?? "")
        } else if l21 && r12 {
            males.append(self.players[0].gender == "M" ? self.playerMeeting.playerL2.user?.nickName ?? "" : self.playerMeeting.playerR1.user?.nickName ?? "")
            females.append(self.players[0].gender == "M" ? self.playerMeeting.playerR1.user?.nickName ?? "" : self.playerMeeting.playerL2.user?.nickName ?? "")
        } else if l22 && r22 {
            males.append(self.players[0].gender == "M" ? self.playerMeeting.playerL2.user?.nickName ?? "" : self.playerMeeting.playerR2.user?.nickName ?? "")
            females.append(self.players[0].gender == "M" ? self.playerMeeting.playerR2.user?.nickName ?? "" : self.playerMeeting.playerL2.user?.nickName ?? "")
        } else if l23 && r32 {
            males.append(self.players[0].gender == "M" ? self.playerMeeting.playerL1.user?.nickName ?? "" : self.playerMeeting.playerR1.user?.nickName ?? "")
            females.append(self.players[0].gender == "M" ? self.playerMeeting.playerR1.user?.nickName ?? "" : self.playerMeeting.playerL1.user?.nickName ?? "")
        } else if l31 && r13 {
            males.append(self.players[0].gender == "M" ? self.playerMeeting.playerL3.user?.nickName ?? "" : self.playerMeeting.playerR1.user?.nickName ?? "")
            females.append(self.players[0].gender == "M" ? self.playerMeeting.playerR1.user?.nickName ?? "" : self.playerMeeting.playerL3.user?.nickName ?? "")
        } else if l32 && r23 {
            males.append(self.players[0].gender == "M" ? self.playerMeeting.playerL3.user?.nickName ?? "" : self.playerMeeting.playerR2.user?.nickName ?? "")
            females.append(self.players[0].gender == "M" ? self.playerMeeting.playerR2.user?.nickName ?? "" : self.playerMeeting.playerL3.user?.nickName ?? "")
        } else if l33 && r33 {
            males.append(self.players[0].gender == "M" ? self.playerMeeting.playerL3.user?.nickName ?? "" : self.playerMeeting.playerR3.user?.nickName ?? "")
            females.append(self.players[0].gender == "M" ? self.playerMeeting.playerR3.user?.nickName ?? "" : self.playerMeeting.playerL3.user?.nickName ?? "")
        }
        
        self.configMeetingResultLB(males: males, females: females)
    }
    
    func setupTouch() {
        playerMeeting.playerL1.avatarTouch = {
            [weak self] user in
            guard let _self = self else { return  }
            _self.avatarTouch?(user)
        }
        playerMeeting.playerL2.avatarTouch = {
            [weak self] user in
            guard let _self = self else { return  }
            _self.avatarTouch?(user)
        }
        playerMeeting.playerL3.avatarTouch = {
            [weak self] user in
            guard let _self = self else { return  }
            _self.avatarTouch?(user)
        }
        playerMeeting.playerR1.avatarTouch = {
            [weak self] user in
            guard let _self = self else { return  }
            _self.avatarTouch?(user)
        }
        playerMeeting.playerR2.avatarTouch = {
            [weak self] user in
            guard let _self = self else { return  }
            _self.avatarTouch?(user)
        }
        playerMeeting.playerR3.avatarTouch = {
            [weak self] user in
            guard let _self = self else { return  }
            _self.avatarTouch?(user)
        }
    }
    
}
extension GroundMeetingDetailCell : UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        self.appealChange?()
    }
}

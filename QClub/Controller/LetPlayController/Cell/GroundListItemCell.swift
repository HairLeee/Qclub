//
//  GroundListItemCell.swift
//  QClub
//
//  Created by TuanNM on 10/9/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class GroundListItemCell: UITableViewCell {

    @IBOutlet weak var roomTitleLb: UILabel!
    @IBOutlet weak var dateLb: UILabel!
    @IBOutlet weak var woman1: PlayerInfoView!
    @IBOutlet weak var woman2: PlayerInfoView!
    @IBOutlet weak var woman3: PlayerInfoView!
    @IBOutlet weak var man1: PlayerInfoView!
    @IBOutlet weak var man2: PlayerInfoView!
    @IBOutlet weak var man3: PlayerInfoView!
    var index : Int?
    var enterAction : ((_ index : Int) -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func enterAction(_ sender: Any) {
        enterAction?(self.index ?? 0)
    }
    
    func setupData(room : MeetingRoomObject, index: Int) {
        self.index = index
        roomTitleLb.text = "Meeting Room \(index)"//"\(index)번방"
        if let dateString = room.meetingDate?.toMeetingRoomString() {
            dateLb.text =  "입장시간 \(dateString)"
        }
        
        if let users = room.users {
             let avatarIndexs = random()
            for user in users {
                if user.gender == Context.getUserLogin()?.gender {
                    // same gender
                    if user.userSeq == Context.getUserLogin()?.userSeq {
                        woman1.setData(user: user)
                    } else {
                        if woman2.user == nil {
                            woman2.setData(user: user,avatarString: user.gender == "F" ? "woman\(avatarIndexs[1])" : "man\(avatarIndexs[1])")
                        } else {
                            woman3.setData(user: user,avatarString: user.gender == "F" ? "woman\(avatarIndexs[2])" : "man\(avatarIndexs[2])")
                        }
                    }
                } else {
                    //other gender

                    if man1.user == nil {
                        man1.setData(user: user,avatarString: user.gender == "F" ? "woman\(avatarIndexs[0])" : "man\(avatarIndexs[0])")
                    } else {
                        if man2.user == nil {
                            man2.setData(user: user,avatarString: user.gender == "F" ? "woman\(avatarIndexs[1])" : "man\(avatarIndexs[1])")
                        } else {
                            man3.setData(user: user,avatarString: user.gender == "F" ? "woman\(avatarIndexs[2])" : "man\(avatarIndexs[2])")
                        }
                    }
                }

                
            }
        }
    }
    
    func random()->[Int]{
        let index = arc4random_uniform(5)
        switch index {
        case 0:
            return [1,2,3]
        case 1:
            return [1,3,2]
        case 2:
            return [2,1,3]
        case 3:
            return [2,3,1]
        case 4:
            return [3,1,2]
        default:
            return [3,2,1]
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

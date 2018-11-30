//
//  GroundMeetingDetailViewModel.swift
//  QClub
//
//  Created by SMR on 11/6/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class GroundMeetingDetailViewModel: NSObject {
    var members = [UserMeetingRoom]()
    var meetingSeq = 0
    
    func getData(completion: @escaping() -> ()) {
        MeetingService.getRoomDetail(meetingSeq: self.meetingSeq, completion: { (response) in
            if let m = response.data as? [UserMeetingRoom] {
                self.members = m
            }
            completion()
        }) { (error) in
            completion()
        }
    }
    
    func targetAndMeIsConnected(user: UserMeetingRoom) -> Bool {
        for memberMe in members {
            if memberMe.userSeq == Context.getUserLogin()?.userSeq {
                if memberMe.targetUserSeq == user.userSeq && memberMe.userSeq == user.targetUserSeq {
                    return true
                }
            }
        }
        return false
    }
    
    func getViewUser(targetUserSeq: Int, completion : @escaping (_ response: MeetingProfile?) -> ()) {
        MeetingService.getProfile(targetUserSeq: targetUserSeq, completion: { (response) in
            if let data = response.data as? MeetingProfile {
                completion(data)
            }
        }) { (error) in
            completion(nil)
        }
    }
    

    
    func registSpecial42(viewController: UIViewController, userSeq : Int) {
        //check heart
        Utils.checkHeartIsEnough(viewController: viewController, numberOfHeartIsNeed: 42, completion: { (isEnough, count) in
            if isEnough {
                // regist
                MatchService.registSpecialRelationship(specialMatchTargetUserSeq: userSeq , alreadyPaied: true, completion: { (response) in
                    
                }, fail: { (error) in
                       UIApplication.shared.keyWindow?.currentViewController()?.view.makeToast("이미 신청했습니다", duration: 2.0, position: .center)
                })
            }
        }, fail: { (error) in
            
        })
    }
    
    func registSpecial40(viewController: UIViewController, userSeq : Int) {
        //check heart
        Utils.checkHeartIsEnough(viewController: viewController, numberOfHeartIsNeed: 40, completion: { (isEnough, count) in
            if isEnough {
                // regist
                MatchService.registSpecialRelationship(specialMatchTargetUserSeq: userSeq , alreadyPaied: true, completion: { (response) in
                    
                }, fail: { (error) in
                    UIApplication.shared.keyWindow?.currentViewController()?.view.makeToast("이미 신청했습니다", duration: 2.0, position: .center)
                })
            }
        }, fail: { (error) in
            
        })
    }
}

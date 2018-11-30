//
//  Utils.swift
//  QClub
//
//  Created by SMR on 9/28/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import Foundation
import UIKit
import SendBirdSDK


class Utils {
    
    static func mDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    static func stringClassFromString(_ className: String) -> AnyClass! {
        
        /// get namespace
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String;
        
        /// get 'anyClass' with classname and namespace
        let cls: AnyClass = NSClassFromString("\(namespace).\(className)")!;
        
        // return AnyClass!
        return cls;
    }
    
    static func getAtributedStringWithLinespace(text: String, lineSpace: Int? = nil, alignment: NSTextAlignment? = nil) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = (CGFloat(lineSpace == nil ? 5 : lineSpace!))
        paragraphStyle.alignment = (alignment == nil ? .center : alignment!)
        attributedString.addAttribute(NSParagraphStyleAttributeName, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        return attributedString
    }
    
    static func checkHeartIsEnough(viewController: UIViewController, numberOfHeartIsNeed: Int, completion : @escaping (_ isEnough: Bool, _ count: Int) -> (), fail: @escaping (Error) -> Void) {
        viewController.showLoading()
        RelationService.getHeartCount(completion: { (response) in
            viewController.stopLoading()
            if response.code == 0 {
                let count : Int = response.data as! Int
                if count >= numberOfHeartIsNeed {
                    completion(true, count)
                } else {
                    completion(false,count)
                    weak var weakViewController = viewController
                    Utils.gotoStore(viewController: weakViewController!)
                }
            } else {
                let error = NSError(domain: "", code: response.code ?? 0, userInfo: nil)
                fail(error)
            }
        }, fail: {(error) in
            fail(error)
        })
    }
    
    static func gotoStore(viewController : UIViewController) {
        let alertQ = AlertQClub.instanceFromNib(content: "하트가 부족합니다 충전하시겠습니까?", image: "ic_store_popup")
        alertQ.show()
        alertQ.action2 = {
            [weak viewController] in
            guard let _viewController = viewController else{return}
            
            if Context.getUserLogin()?.createDate?.toLoginDate().addingTimeInterval(604800).compare(Date()) == ComparisonResult.orderedAscending {
                let storePromotionVC = StoreAfterPromotionViewController.init(nibName: "StoreAfterPromotionViewController", bundle: nil)
                _viewController.navigationController?.pushViewController(storePromotionVC, animated: true)
            } else {
                let storePromotion = StoreViewController.init(nibName: "StoreViewController", bundle: nil)
                _viewController.navigationController?.pushViewController(storePromotion, animated: true)
            }
        }
    }
    
    static func gotoUserVC(viewController : UIViewController, userSeq: Int, userSpecialPopupType : UserSpecialPopup.PopupType? = nil, isHideSpecialRegist : Bool? = nil) {
        let userVC = UIStoryboard.init(name: "RelationCard", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        userVC.userSeq = userSeq
        userVC.userSpecialPopupType = userSpecialPopupType ?? UserSpecialPopup.PopupType.other
        userVC.isHideRelationSpecial = isHideSpecialRegist ?? false
        viewController.navigationController?.pushViewController(userVC, animated: true)
    }
    
    static func messageAction(user: TargetUserInfo, viewController: UIViewController, messageSeq : Int? = nil) {
        switch user.messageStatus {
        case "S"?:
            let main3Sent = Main3PopupMessage.instanceFromNib(type: .from, userInfo : user)
            main3Sent.show()
        case "R"?:
            
            let letters = (UIApplication.shared.delegate as! AppDelegate).newLetters
            if let letterObj = letters.filter({ (letter) -> Bool in
                return letter.fromUserSeq == user.userSeq
            }).last{
                if letterObj.paidDate != nil {
                    let freePopUp = Main3ComfirmPopup.instanceFromNib(nickName: user.nickName ?? "")
                    freePopUp.show()
                    freePopUp.action = {
                        let main3Sent = Main3PopupMessage.instanceFromNib(type: .to, userInfo : user)
                        main3Sent.actionFromAccept = {
                            [weak viewController] content in
                            guard let _viewController = viewController else{return}
                            
                            let letterTalkVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LetterTalkViewController") as! LetterTalkViewController
                            Utils.createOrGetChannel(channelType: Constants.ChannelName.Letter, viewController: viewController!, userSeq: user.userSeq ?? 0, completion: { (channel) in
                                channel.sendUserMessage(content, completionHandler: nil)
                                letterTalkVC.groupChannel = channel
                                letterTalkVC.interestMessageSeq = messageSeq ?? 0
                                letterTalkVC.targetUser = user
                                _viewController.navigationController?.pushViewController(letterTalkVC, animated: true)
                            }, fail: { (error) in
                                print("\(error)")
                            })
                        }
                        main3Sent.show()
                    }
                
                }else{
                    Utils.checkHeartIsEnough(viewController: viewController, numberOfHeartIsNeed: 0, completion: { (isEnough, numberHeart) in
                        if isEnough{
                            let main3popup = Main3Popup.instanceFromNib(numberOfHeart: numberHeart, type: .popup2,nickname: user.nickName ?? "")
                            main3popup.show()
                            main3popup.okAction = {
                                
                                if numberHeart > 5 {
                                    Utils.gotoStore(viewController: viewController)
                                }else{
                                    MessageService.viewMessage(targetUserSeq: user.userSeq!, completion: { (response) in
                                        let main3Sent = Main3PopupMessage.instanceFromNib(type: .to, userInfo : user)
                                        main3Sent.actionFromAccept = {
                                            [weak viewController] content in
                                            guard let _viewController = viewController else{return}
                                            let letterTalkVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LetterTalkViewController") as! LetterTalkViewController
                                            Utils.createOrGetChannel(channelType: Constants.ChannelName.Letter, viewController: viewController!, userSeq: user.userSeq ?? 0, completion: { (channel) in
                                                channel.sendUserMessage(content, completionHandler: nil)
                                                letterTalkVC.groupChannel = channel
                                                letterTalkVC.interestMessageSeq = messageSeq ?? 0
                                                letterTalkVC.targetUser = user
                                                _viewController.navigationController?.pushViewController(letterTalkVC, animated: true)
                                            }, fail: { (error) in
                                                print("\(error)")
                                            })
                                        }
                                        main3Sent.show()
                                    }, fail: { (error) in
                                        print("viewMessage error \(error)")
                                    })
                                }
                            }
                        }
                    }, fail: { (error) in
                        print("checkHeartIsEnough error \(error)")
                    })
                }
            }
            
        case "A"?:
            let letterTalkVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LetterTalkViewController") as! LetterTalkViewController
            Utils.createOrGetChannel(channelType: Constants.ChannelName.Letter, viewController: viewController, userSeq: user.userSeq ?? 0, completion: { (channel) in
                letterTalkVC.groupChannel = channel
                letterTalkVC.interestMessageSeq = messageSeq ?? 0
                letterTalkVC.targetUser = user
                viewController.navigationController?.pushViewController(letterTalkVC, animated: true)
            }, fail: { (error) in
                print("\(error)")
            })
            
        default:
            let userLetterVC = UIStoryboard.init(name: "RelationCard", bundle: nil).instantiateViewController(withIdentifier: "UserLetterViewController") as! UserLetterViewController
            userLetterVC.userMatchInfo = user
            userLetterVC.delegate = viewController as? UserLetterViewControllerDelegate
            viewController.navigationController?.pushViewController(userLetterVC, animated: true)
        }
    }
    
    static func addCheckbox(privacyCheckBox:Checkbox, tag:Int) {
        privacyCheckBox.borderStyle = .square
        privacyCheckBox.checkmarkStyle = .square
        privacyCheckBox.borderWidth = 1
        privacyCheckBox.borderColor = UIColor.init(hexString: "#e86a12")
        privacyCheckBox.checkmarkColor = UIColor.init(hexString: "#e86a12")
        privacyCheckBox.checkmarkSize = 13
    }
    
    
    static func createOrGetChannel(channelType: String, viewController : UIViewController, userSeq: Int, completion : @escaping (_ channel: SBDGroupChannel) -> (), fail: @escaping (Error) -> Void) {
        viewController.showLoading()
        let query = SBDGroupChannel.createMyGroupChannelListQuery()
        query?.setUserIdsExactFilter(["\(userSeq)"])
        query?.includeEmptyChannel = true
        query?.loadNextPage(completionHandler: { (channels, error) in
            let channelSortByTime = channels?.sorted{ $0.createdAt > $1.createdAt }
            if let channelsUnwrap = channelSortByTime {
                for channel in channelsUnwrap {
                    if channel.name == channelType {
                        completion(channel)
                        viewController.stopLoading()
                        return
                    }
                }
                
                // create channel
                let myUser : Int = Context.getUserLogin()?.userSeq ?? 0
                SBDGroupChannel.createChannel(withName: Constants.ChannelName.Letter, isDistinct: false, userIds: ["\(myUser)","\(userSeq)"], coverUrl: nil, data: nil, completionHandler: { (channel, error) in
                    viewController.stopLoading()
                    if error != nil {
                        fail(error!)
                        return
                    } else {
                        completion(channel!)
                    }
                })
                
            } else {
                // create channel
                let myUser : Int = Context.getUserLogin()?.userSeq ?? 0
                SBDGroupChannel.createChannel(withName: Constants.ChannelName.Letter, isDistinct: false, userIds: ["\(myUser)","\(userSeq)"], coverUrl: nil, data: nil, completionHandler: { (channel, error) in
                    viewController.stopLoading()
                    if error != nil {
                        fail(error!)
                        return
                    } else {
                        completion(channel!)
                    }
                })
            }
            
        })
    }
    
    static func connectSendbird() {
        if let userId  = (Context.getUserLogin()?.userSeq) {
            SBDMain.connect(withUserId: "\(userId)", completionHandler: { (user, error) in
                if error != nil {
                    return
                }
                
                if SBDMain.getPendingPushToken() != nil {
                    SBDMain.registerDevicePushToken(SBDMain.getPendingPushToken()!, unique: true, completionHandler: { (status, error) in
                        if error == nil {
                            if status == SBDPushTokenRegistrationStatus.pending {
                                print("Push registeration is pending.")
                            }
                            else {
                                print("APNS Token is registered.")
                            }
                        }
                        else {
                            print("APNS registration failed.")
                        }
                    })
                }
                
                SBDMain.updateCurrentUserInfo(withNickname: Context.getUserLogin()?.nickname!, profileUrl: Context.getUserLogin()?.avatar ?? "", completionHandler: { (error) in
                    if error != nil {
                        return
                    }
                })
            })
        }
        
    }
    
    static func nowIn18To24h() -> Bool {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm"
        let hourIn18 = format.date(from: "\(Calendar.current.component(.year, from: Date()))-\(Calendar.current.component(.month, from: Date()))-\(Calendar.current.component(.day, from: Date())) 18:00")
        let tomorrow = format.date(from: "\(Calendar.current.component(.year, from: Date()))-\(Calendar.current.component(.month, from: Date()))-\(Calendar.current.component(.day, from: Date()) + 1) 00:00")
        
        if Date().compare(hourIn18!) == .orderedDescending && Date().compare(tomorrow!) == .orderedAscending {
            return true
        }
        return false
    }
    
    static func nowIn12To18h() -> Bool {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm"
        let hourIn12 = format.date(from: "\(Calendar.current.component(.year, from: Date()))-\(Calendar.current.component(.month, from: Date()))-\(Calendar.current.component(.day, from: Date())) 12:00")
        let hourIn18 = format.date(from: "\(Calendar.current.component(.year, from: Date()))-\(Calendar.current.component(.month, from: Date()))-\(Calendar.current.component(.day, from: Date())) 18:00")
        
        if Date().compare(hourIn12!) == .orderedDescending && Date().compare(hourIn18!) == .orderedAscending {
            return true
        }
        return false
    }
    
}


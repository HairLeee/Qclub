//
//  ProfileViewController.swift
//  QClub
//
//  Created by Dream on 9/22/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import AXPhotoViewer
import PromiseKit

protocol ProfileViewDelegate:class {
   func willMoveToParent()
}
/*
 User, Page 32 in StoryBoard
 */
class ProfileViewController: BaseViewController {

    @IBOutlet weak var navigationView: NavigationBarQClub!
    @IBOutlet weak var tbView: UITableView!
    
    weak var delegate:ProfileViewDelegate?
    
    weak var photosViewController: PhotosViewController?
    var member : Member?
    var userSeq : Int?
    var bubbleView:BubbleView?
    var likability : LikabilityObject?
    var completionObject = CompletionObject()
    var likabilityOptions = [MasterDataObject]()
    
    var arrCell:[UITableViewCell] = []
    var avatarPhotos: [Photo] = []
    var isShowRegisterSpecialRelationship = true
    var isHideRelationSpecial = false
    var isPostingCompleteScore = false
    
    var userSpecialPopupType = UserSpecialPopup.PopupType.other

    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupCell()

        tbView.estimatedRowHeight = 100
        tbView.allowsSelection = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showLetter(_ sender: Any) {
        self.showLoading()
        MessageService.getLetterStatus(targetUserSeq: self.member?.userSeq ?? 0, completion: { (status) in
            self.stopLoading()
            if status == .sendFavoriteLetter {
                self.view.makeToast("이미 보냈습니다.", duration: 2.0, position: .center)
            } else {
                let letterVC = self.storyboard?.instantiateViewController(withIdentifier: "UserLetterViewController") as! UserLetterViewController
                letterVC.isRequestSpecialRelation = false
                letterVC.member = self.member
                self.navigationController?.pushViewController(letterVC, animated: true)
            }
        }) { (error) in
            self.stopLoading()
        }



    }
    
    override func configNavigationBar() {
        navigationView.backAction = {
            self.delegate?.willMoveToParent()
            self.navigationController?.popViewController(animated: true)
        }
        navigationView.config(title: "프로필", image: "ic_navigation_woman")
    }

    @IBAction func showReportPopup(_ sender: Any) {
        // if reportDetail = 12 -- need to set value for reportDetailStr
        let popup = UserPolicePopup.instanceFromNib()
        popup.actionSend = {
            [weak self] reportDetail,reportEtc,selectedItem,tfReasonETCChar in
            guard let _self = self else{return}
            var pReasonETCChar = ""
            if selectedItem == 12 {
                
                pReasonETCChar = tfReasonETCChar
            }
            _self.showLoading()
            if let member = self?.member {
                ReportService.sendReportUser(userSeq: member.userSeq, reportDetail: selectedItem, reportDetailStr: pReasonETCChar, reportEtc: reportEtc, completion: { (response) in
                    _self.stopLoading()
                    if response.code == 0 {
                        _self.view.makeToast("신고가 접수되었습니다. 확인 후 조치를 취하고, 결과를 알려드리겠습니다")
                    }
                }, fail: { (error) in
                    _self.view.makeToast("Error !")
                    _self.stopLoading()
                })
            }
        }
        popup.show()
    }
    
    
    func makeAvatarData() {
        if let memberUnWrap = self.member {
            if let pictures = memberUnWrap.profilePicture {
                for profilePicture in pictures {
                    self.avatarPhotos.append(Photo(attributedTitle: NSAttributedString(string: profilePicture.descriptionString ?? ""),
                                                   attributedDescription: NSAttributedString(string: ""),
                                                   attributedCredit: NSAttributedString(string: ""),
                                                   url: URL(string: profilePicture.profilePictureUrl )))
                }
            }
        }
    }
    
    func makeLikability(score : Int?, impressions: Set<Int>?) {
        if let _ = self.likability {
            
        } else {
            self.likability = LikabilityObject()
        }
        if let scoreUnwarp = score {
            self.likability?.score = scoreUnwarp
        }
        if let impressionUnwarp = impressions {
            var ims = [ImpressionObject]()
            for impressionInt in impressionUnwarp {
                let im = ImpressionObject()
                im.impressionMaster = self.member?.gender == "여자" ? 10 : 11
                im.impressionDetail = impressionInt
                ims.append(im)
            }
            self.likability?.impression = ims
        }
        
        if let cell:FriendlyScoreCell = self.tbView.cellForRow(at: IndexPath.init(row: 5, section: 0)) as? FriendlyScoreCell {
            cell.checkStateOkButton(likAbility: self.likability)
        }
    }

    func updateStatusAfterPostLikability() {
        if let likabilityUnwrap = self.likability {
            likabilityUnwrap.evaluationDate = "now"
            if let cell:FriendlyScoreCell = self.tbView.cellForRow(at: IndexPath.init(row: 5, section: 0)) as? FriendlyScoreCell {
                cell.updateLikAbility(likAbility: likabilityUnwrap)
            }
            
            if let cell:CommentCheckBoxCell = self.tbView.cellForRow(at: IndexPath.init(row: 4, section: 0)) as? CommentCheckBoxCell {
                cell.updateLikAbility(likAbility: likabilityUnwrap)
            }
        }
    }
    
    func checkShowRegisterSpecialCell() -> Bool {
        if let member = self.member {
            if let matchStatus = member.matchStatus {
                if matchStatus.special == 1 || matchStatus.today == 1 || matchStatus.meeting == 1 ||  matchStatus.candy == 1 {
                    return !isHideRelationSpecial
                } else {
                    return true
                }
            }
        }
        return false
    }
    
    func reloadSpecialRelationship() {
        firstly {
            return getDataBasic()
            }.then { () -> Void in
                self.tbView.reloadData()
                self.stopLoading()
            }.catch { (error) in
                self.stopLoading()
        }
    }
}

//Get and setup Data
extension ProfileViewController {
    func getData() {
        self.showLoading()
        firstly {
            return getDataBasic()
            }.then { () -> Void in
                self.getLikabilityOptions()
            }.always {
                self.tbView.reloadData()
            }.catch { (error) in
           print(error)
        }
        
        firstly {
            when(fulfilled: self.getLikAbility(), self.getCompletionScore())
            }.then { () -> Void in
                self.stopLoading()
            }.always {
                self.tbView.reloadData()
            }.catch { (error) in
                self.stopLoading()
        }
        
    }
    
    func getDataBasic() -> Promise<()> {
        return Promise { fulfill, reject in
            if let userSeqUnWrap = self.userSeq {
                ProfileService.getProfileBasic(userSeq: userSeqUnWrap, completion: { (response) in
                    self.member = response.data as? Member
                    self.makeAvatarData()
                    self.navigationView.config(title: "프로필", image: self.member?.gender == "여자" ? "ic_navigation_woman" : "ic_navigation_man")
                    fulfill()
                }) { (error) in
                    reject(error)
                }
            } else {
                reject(NSError())
            }
        }
    }
    
    func getLikAbility() -> Promise<()> {
        return Promise { fulfill, reject in
            if let userSeqUnWrap = self.userSeq {
                ProfileService.getLikAbility(userSeq: userSeqUnWrap, completion: { (response) in
                    self.likability = response.data as? LikabilityObject
                    fulfill()
                }, fail: { (error) in
                    reject(error)
                })
            } else {
                reject(NSError())
            }
        }
    }
    
    func getCompletionScore() -> Promise<()> {
        return Promise { fulfill, reject in
            if let userSeqUnWrap = self.userSeq {
                ProfileService.getCompletionScore(userSeq: userSeqUnWrap, completion: { (response) in
                    if let object  = response.data as? CompletionObject {
                        self.completionObject = object
                    }
                    fulfill()
                }, fail: { (error) in
                    reject(error)
                })
            } else {
                reject(NSError())
            }
        }
    }
    
    func getLikabilityOptions(){
        if let memberSeqUnWrap = self.member {
            AuthService.getMasterData(masterSeq: memberSeqUnWrap.gender == "여자" ? Constants.MasterCode.MaleImpression : Constants.MasterCode.FemaleImpression, completion: { (response) in
                if let data = response.data as? [MasterDataObject] {
                    self.likabilityOptions = data
                    self.tbView.reloadRows(at: [IndexPath.init(row: 4, section: 0)], with: .none)
                    
                } else {
                    
                }
            }) { (error) in
                
            }
        } else {
            
        }
    }
}

//Setup Cell
extension ProfileViewController {
    func setupCell() {
        let sildeImgCell = tbView.dequeueReusableCell(withIdentifier: "ProfileSlideImageCell") as! ProfileSlideImageCell
        sildeImgCell.presentFullScreenSlider = {
            [weak self] cell,index in
            
            guard let _self = self else{return}
            
            let dataSource = PhotosDataSource(photos: _self.avatarPhotos, initialPhotoIndex: index)
            let photosViewController = PhotosViewController(dataSource: dataSource, pagingConfig: PagingConfig.init(), transitionInfo: TransitionInfo.init())

            _self.present(photosViewController, animated: true)
            _self.photosViewController = photosViewController
        }
        sildeImgCell.showInfo = {
            [weak self] cell in
            
            guard let _self = self else{return}
            
            if _self.bubbleView !=  nil && _self.bubbleView?.superview != nil {
                _self.bubbleView?.removeFromSuperview()
                _self.bubbleView = nil
                return
            }
            
            _self.bubbleView = BubbleView.loadFromXib()
            _self.bubbleView?.autoDissmiss = true
            let originY = sildeImgCell.btnShowInfo.frame.origin.y + sildeImgCell.btnShowInfo.frame.size.height - 10
            let tipX = sildeImgCell.btnShowInfo.frame.origin.x + 10
            let originX: CGFloat = 10
            
            _self.bubbleView!.setTipX(tipX: tipX)
            _self.bubbleView!.frame =  CGRect.init(x: originX, y: originY, width: SCREEN_WIDTH - 20, height: 100)
            _self.bubbleView!.bubbleContentLb.text = "상대회원이 회원님에게 준 호감도 점수입니다."
            _self.tbView.addSubview(_self.bubbleView!)
            
        }
        
        let myInfoCell = tbView.dequeueReusableCell(withIdentifier: "ProfileMyInfoCell") as! ProfileMyInfoCell
        let moreInfoCell = tbView.dequeueReusableCell(withIdentifier: "ProfileMoreInfoCell") as! ProfileMoreInfoCell
        let introduceYourSelf = tbView.dequeueReusableCell(withIdentifier: "IntroduceSelfCell") as! ProfileIntroduceYourselfCell
        
        let commentCheckboxCell = tbView.dequeueReusableCell(withIdentifier: "CommentCheckBoxCell") as! CommentCheckBoxCell
        
        commentCheckboxCell.postLikAbilitySelected = {
            [weak self] selectedIndex in
            guard let _self = self else {return}
            _self.makeLikability(score: nil, impressions: selectedIndex)
        }
        
        let friendlyScoreCell = tbView.dequeueReusableCell(withIdentifier: "FriendlyScoreCell") as! FriendlyScoreCell
        
        friendlyScoreCell.selectedScoreAction = {
            [weak self] score in
            guard let _self = self else {return}
            _self.makeLikability(score: score, impressions: nil)
        }
        friendlyScoreCell.postScoreAction = {
            [weak self] in
            guard let _self = self else {return}
            _self.showLoading()
            ProfileService.postLikAbility(userSeq: (_self.member?.userSeq)!, likAbility: _self.likability!, completion: { (response) in
                _self.stopLoading()
                _self.updateStatusAfterPostLikability()
            }, fail: { (error) in
                _self.stopLoading()
            })
        }
        
        let completeProfileScoreCell = tbView.dequeueReusableCell(withIdentifier: "CompleteProfileScoreCell") as! CompleteProfileScoreCell
        
        completeProfileScoreCell.postCompletionScore = {
            [weak self] score in
            guard let _self = self else {return}
            if _self.isPostingCompleteScore == true {
                return
            } else {
                _self.isPostingCompleteScore = true
                ProfileService.postCompletionScore(userSeq: (_self.member?.userSeq)!, score: score, completion: { (response) in
                    _self.isPostingCompleteScore = false
                    _self.completionObject.score = score
                    if let cell = _self.tbView.cellForRow(at: IndexPath.init(row: 6, section: 0)) as? CompleteProfileScoreCell {
                        cell.updateScore(completionObject: _self.completionObject)
                    }
                    
                }, fail: { (error) in
                    _self.isPostingCompleteScore = false
                })
            }
        }
        
        let friendlyScroreChartCell = tbView.dequeueReusableCell(withIdentifier: "FriendlyScoreChartCell") as! FriendlyScoreChartCell
        friendlyScroreChartCell.delegate = self
        
        let acceptSpecialRelationCell = tbView.dequeueReusableCell(withIdentifier: "AcceptSpecialRelation") as! AcceptSpecialRelationCell
        acceptSpecialRelationCell.actionCancel = {
            let popup = UserLetterCancel.instanceFromNib()
            popup.action = {
                [weak self] in
                guard let _self = self else { return  }
                MatchService.responseSpecial(matchSpecialSeq: (_self.member?.userSeq)!, response: false, completion: { (response) in
                    
                }, fail: { (error) in
                    
                })
            }
            popup.show()
        }
        acceptSpecialRelationCell.actionOk = {
            let popup = UserLetterAccept.instanceFromNib()
            popup.show()
            popup.actionOk = {
                [weak self] in
                guard let _self = self else { return  }
                
                MatchService.responseSpecial(matchSpecialSeq: (_self.member?.userSeq)!, response: true, completion: { (response) in
                    
                }, fail: { (error) in
                    
                })
                
                let userLetterVC = self?.storyboard?.instantiateViewController(withIdentifier: "UserLetterViewController") as! UserLetterViewController
                userLetterVC.member = _self.member
                userLetterVC.isRequestSpecialRelation = true
                _self.navigationController?.pushViewController(userLetterVC, animated: true)
            }
        }
        
        let registerSpecialRelationCell = tbView.dequeueReusableCell(withIdentifier: "RegisterSpecialRelation") as! RegisterSpecialRelationCell
        registerSpecialRelationCell.requestSpecialRelationShip = {
            [weak self] in
            guard let _self = self else { return  }
            Utils.checkHeartIsEnough(viewController: _self, numberOfHeartIsNeed: 42, completion: { (isEnough, count) in
                if isEnough {
                    let popup = UserSpecialPopup.instanceFromNib(type: _self.userSpecialPopupType , heartCount: count)
                    popup.animationType = .upDown
                    popup.request40 = {
                        _self.showLoading()
                        MatchService.registSpecialRelationship(specialMatchTargetUserSeq: _self.userSeq ?? 0, alreadyPaied: false, completion: { (response) in
                            print(response.message ?? "")
                            _self.reloadSpecialRelationship()
                            _self.view.makeToast("스폐셜인연이 전달되었습니다", duration: 2.0, position: .center)
                        }, fail: { (error) in
                            _self.stopLoading()
                        })
                    }
                    
                    popup.request42 = {
                        _self.showLoading()
                        MatchService.registSpecialRelationship(specialMatchTargetUserSeq: _self.userSeq ?? 0, alreadyPaied: true, completion: { (response) in
                            print(response.message ?? "")
                            _self.reloadSpecialRelationship()
                            _self.view.makeToast("스폐셜인연이 전달되었습니다", duration: 2.0, position: .center)
                        }, fail: { (error) in
                            _self.stopLoading()
                        })
                    }
                    popup.show()
                }
            }, fail: { (error) in
                
            })

        }
        let showCommentPopupCell = tbView.dequeueReusableCell(withIdentifier: "CommentPopupCell") as! ShowCommentPopupCell
      
        arrCell = [sildeImgCell,myInfoCell,moreInfoCell,introduceYourSelf,commentCheckboxCell,friendlyScoreCell,completeProfileScoreCell,friendlyScroreChartCell,showCommentPopupCell,acceptSpecialRelationCell,registerSpecialRelationCell]
        if isHideRelationSpecial{
            arrCell.removeLast()
        }
    }

}

extension ProfileViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let sildeImgCell = arrCell[0] as! ProfileSlideImageCell
            if let memberUnwrap = self.member {
                sildeImgCell.setData(member: memberUnwrap)
            }
            return sildeImgCell
        case 1:
            let myInfoCell = arrCell[1] as! ProfileMyInfoCell
            if let memberUnwrap = self.member {
                myInfoCell.setData(member: memberUnwrap)
            }
            return myInfoCell
        case 2:
            let profileMoreInfoCell = arrCell[2] as! ProfileMoreInfoCell
            if let memberUnwrap = self.member {
                profileMoreInfoCell.setData(member: memberUnwrap)
            }
            return profileMoreInfoCell
        case 3:
            let profileIntroduceYourselfCell = arrCell[3] as! ProfileIntroduceYourselfCell
            if let memberUnwrap = self.member {
                profileIntroduceYourselfCell.setData(member: memberUnwrap)
            }
            return profileIntroduceYourselfCell
        case 4:
            let commentCheckBoxCell = arrCell[4] as! CommentCheckBoxCell
            if let memberUnwrap = self.member {
                commentCheckBoxCell.setData(member: memberUnwrap, data: self.likabilityOptions, likAbility: self.likability)
            }
            return commentCheckBoxCell
        case 5:
            let friendlyScoreCell = arrCell[5] as! FriendlyScoreCell
            if let memberUnwrap = self.member {
                friendlyScoreCell.setData(member: memberUnwrap, likAbility: self.likability)
            }
            return friendlyScoreCell
        case 6:
            let completeProfileScoreCell = arrCell[6] as! CompleteProfileScoreCell
            if let memberUnwrap = self.member {
                completeProfileScoreCell.setData(member: memberUnwrap, completionObject: self.completionObject)
            }
            return completeProfileScoreCell
        case 8:
            let showCommentPopupCell = arrCell[8] as! ShowCommentPopupCell
            showCommentPopupCell.delegate = self
            if let memberUnwrap = self.member {
                showCommentPopupCell.setData(member: memberUnwrap)
            }
            return showCommentPopupCell
        default:
            break
        }
        return arrCell[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 9 {
            if self.member?.matchStatus?.special != 1 {
                return CGFloat.leastNormalMagnitude
            }
        } else if indexPath.row == 10 {
            if checkShowRegisterSpecialCell() {
                return UITableViewAutomaticDimension
            } else {
                return CGFloat.leastNormalMagnitude
            }
        }
        return UITableViewAutomaticDimension
    }
    
}

extension ProfileViewController: FriendlyScoreChartCellDelegate {
    func showChart() {
        let chartVC = self.storyboard?.instantiateViewController(withIdentifier: "UserCharmViewController") as! UserCharmViewController
        chartVC.userSeq = self.userSeq
        chartVC.nickName = self.member?.nickname
        self.navigationController?.pushViewController(chartVC, animated: true)
    }
}

extension ProfileViewController: UIViewControllerTransitioningDelegate {
    
}

//
//  GroundIntroduceMyComment.swift
//  QClub
//
//  Created by TuanNM on 10/16/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class GroundIntroduceMyComment: BaseViewController {

    @IBOutlet weak var navigationBar: NavigationBarQClub!
    @IBOutlet weak var tbView: UITableView!
    var members:[GIMember] = []
    
    var profileSegue = "profileDetail"
    var canViewProfile = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.config(title: "나를 소개합니다.", image: "ic_introduce.png")
        navigationBar.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        tbView.rowHeight = UITableViewAutomaticDimension
        tbView.estimatedRowHeight = 100

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        GIntroduceService.getFriendsComment(completion: {
            [weak self]response in
            guard let _self = self else{return}
            guard let members = response.data as? [GIMember] else{return}
            _self.members = members
            _self.tbView.reloadData()
        }) { (error) in
            print("")
        }
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return canViewProfile
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let desVC = segue.destination as? ProfileViewController else{return}
        guard let indexPath = sender as? IndexPath else{return}
        desVC.userSeq = members[indexPath.row].userSeq
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension GroundIntroduceMyComment: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbView.dequeueReusableCell(withIdentifier: "GroundIntroduceCommentCell") as! GroundIntroduceCommentCell
        cell.setData(member:members[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 40))
        header.backgroundColor = UIColor.white
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: SCREEN_WIDTH, height: 40))
        label.text = "비밀 댓글(\(members.count))"
        label.font = UIFont(name: "NanumSquareOTFR", size: 14)
        label.textColor = UIColor.darkGray
        header.addSubview(label)
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tbView.deselectRow(at: indexPath, animated: true)
        
        Utils.checkHeartIsEnough(viewController: self, numberOfHeartIsNeed: 5, completion: { (success, heart) in
            if success{
                let heartView = HeartView(nibName: "HeartView", bundle: nil)
                heartView.popupTitle = "댓글 단 회원 상세프로필 보기"
                heartView.popupMessage = "댓글을 작서한 회원이 어떤 분인지 궁금하시죠?\n회원님이 찾는 분일지도~\n인연은 만들어가는 것~ 찾아가는 것~"
                heartView.buttonContent = "상세 프로필 확인 (하트)"
                heartView.price = "5"
                heartView.myHeart = "\(heart)"
                
                heartView.callBackSelect = {
                    [weak self] in
                    guard let _self = self else{return}
                    _self.canViewProfile = true
                    _self.performSegue(withIdentifier: _self.profileSegue, sender: indexPath)
                }
                
                self.addChildViewController(heartView)
                self.view.addSubview(heartView.view)
            }
        }) { (error) in
            print("checkHeartIsEnough error \(error)")
        }
        
        
    }
    
}

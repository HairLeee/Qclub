//
//  GroundIntroduceDetailViewController.swift
//  QClub
//
//  Created by TuanNM on 10/16/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import MBProgressHUD

class GroundIntroduceDetailViewController: BaseViewController {

    @IBOutlet weak var navigationBar: NavigationBarQClub!
    @IBOutlet weak var avatarImv: UIImageView!
    
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var addressLb: UILabel!
    @IBOutlet weak var ageLb: UILabel!
    @IBOutlet weak var jobLb: UILabel!
    @IBOutlet weak var heightLb: UILabel!
    @IBOutlet weak var bodyLb: UILabel!
    @IBOutlet weak var infoTv: IQTextView!
    @IBOutlet weak var inputCommentTv: UITextView!
    @IBOutlet weak var postbtn: UIButton!
    
    var member:GIMember!
    var canViewProfile = false
    let profileSegue = "profileDetail"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.config(title: "나를 소개합니다.", image: "ic_introduce.png")
        navigationBar.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        
        avatarImv.contentMode = .scaleAspectFit
        
        postbtn.alpha = 0.5
        inputCommentTv.delegate = self
        
        avatarImv.kf.setImage(with: URL(string: member.representPicture))
        
        nameLb.text = member.nickname
        addressLb.text = member.location
        ageLb.text = "\(member.age)세"
        jobLb.text = member.job
        heightLb.text = "\(member.height)cm"
        bodyLb.text = member.body
        infoTv.text = member.introduce
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func postAction(_ sender: Any) {
        guard let comment = inputCommentTv.text else{return}
        if comment.count > 0 {
            inputCommentTv.resignFirstResponder()
            let alert = UIAlertController(title: "", message: "등록되었습니다", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {
                [weak self](action) in
                guard let _self = self else{return}
                MBProgressHUD.showAdded(to: _self.view, animated: true)
                GIntroduceService.postComment(content: comment,introduceSeq:_self.member.introduceSeq,completion: { (response) in
                    MBProgressHUD.hide(for: _self.view, animated: true)
                }, fail: { (error) in
                    print("postComment \(error)")
                    MBProgressHUD.hide(for: _self.view, animated: true)
                })
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (action) in
                
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return canViewProfile
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let desVC = segue.destination as? ProfileViewController else{return}
        desVC.userSeq = member.userSeq
    }
    
    
    @IBAction func showDetailAction(_ sender: Any) {
        
        Utils.checkHeartIsEnough(viewController: self, numberOfHeartIsNeed: 5, completion: { (success, heart) in
            if success{
                self.showPopupPaymentHeart(heart: heart)
            }
        }) { (error) in
            print("checkHeartIsEnough error \(error)")
        }
    }
    
    func showPopupPaymentHeart(heart:Int){
        let heartView = HeartView(nibName: "HeartView", bundle: nil)
        heartView.popupTitle = "회원 상세 프로필"
        heartView.popupMessage = "해당 회원을 선택하셨나요? \n 회원을 좀더 알기 위해서는 하트가 필요합니다!"
        heartView.price = "5"
        heartView.myHeart = "\(heart)"
        heartView.buttonContent = "상세프로필 확인"
        
        self.addChildViewController(heartView)
        self.view.addSubview(heartView.view)
        
        heartView.callBackSelect = {
            [weak self] in
            guard let _self = self else{return}
            _self.canViewProfile = true
            _self.performSegue(withIdentifier: _self.profileSegue, sender: nil)
        }
    }

}

extension GroundIntroduceDetailViewController:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        postbtn.alpha = textView.text.count > 0 ? 1 : 0.5
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let text = (textView.text as NSString).replacingCharacters(in: range, with: text)
        return text.count < 101
    }
}

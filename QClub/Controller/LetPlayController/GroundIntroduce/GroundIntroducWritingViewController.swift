//
//  GroundIntroducWritingViewController.swift
//  QClub
//
//  Created by TuanNM on 10/16/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import MBProgressHUD

class GroundIntroducWritingViewController: BaseViewController {

    
    @IBOutlet weak var navigationBar: NavigationBarQClub!
    @IBOutlet weak var avatarImv: UIImageView!
    @IBOutlet weak var addressLb: UILabel!
    @IBOutlet weak var ageLb: UILabel!
    @IBOutlet weak var jobLb: UILabel!
    @IBOutlet weak var heightLb: UILabel!
    @IBOutlet weak var bodyLb: UILabel!
    
    @IBOutlet weak var InputTv: IQTextView!
    
    @IBOutlet weak var registerBtn: CompleteButton!
    @IBOutlet weak var viewCommentBtn: UIButton!
    @IBOutlet weak var modifyCommentBtn: UIButton!
    
    var member:GIMember?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.config(title: "나를 소개합니다.", image: "ic_introduce.png")
        navigationBar.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        
        InputTv.delegate = self
        
        if let member = member{
            
            avatarImv.kf.setImage(with: URL(string: member.representPicture))
            avatarImv.contentMode = .scaleAspectFit
            
            addressLb.text = member.location
            ageLb.text = "\(member.age)세"
            jobLb.text = member.job
            heightLb.text = "\(member.height)cm"
            bodyLb.text = member.body
            InputTv.text = "\(member.introduce)"
            
            registerBtn.isHidden = member.introduce.count > 0
            viewCommentBtn.isHidden = member.introduce.count == 0
            modifyCommentBtn.isHidden = member.introduce.count == 0
            
            viewCommentBtn.setTitle("비밀 댓글 확인하기 (\(member.reviewCnt))", for: .normal)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func viewCommentAction(_ sender: Any) {
        
    }
    
    @IBAction func modifyCommentAction(_ sender: Any) {
        if InputTv.text.count > 0{
            self.showLoading()
            GIntroduceService.updateIntroduce(content: self.InputTv.text, completion: { (response) in
                self.stopLoading()
                UIApplication.shared.keyWindow?.makeToast("수정되었습니다", duration: 2.0, position: .center)
                self.navigationController?.popViewController(animated: true)
            }, fail: { (error) in
                self.stopLoading()
                print("postIntroduce error : \(error)")
            })

        }
    }
    
    @IBAction func registerAction(_ sender: Any) {
        if InputTv.text.count > 200 {
            let alert = UIAlertController(title: "", message: "최대 200자 까지 입력가능", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                
            }))
            self.present(alert, animated: true, completion: nil)
            return
        }
        self.showLoading()
        GIntroduceService.postIntroduce(content: self.InputTv.text, completion: { (response) in
            self.stopLoading()
            UIApplication.shared.keyWindow?.makeToast("등록되었습니다", duration: 2.0, position: .center)
            self.navigationController?.popViewController(animated: true)
        }, fail: { (error) in
            self.stopLoading()
            UIApplication.shared.keyWindow?.makeToast("\(error.domain)", duration: 2.0, position: .center)
            print("postIntroduce error : \(error)")
        })
    }
    
}

extension GroundIntroducWritingViewController:UITextViewDelegate{
    func textViewDidChange(_ textView: UITextView) {
        guard let introduce = InputTv.text else{return}
        registerBtn.changeState(isActive: introduce.count > 0 && introduce != member?.introduce)
        modifyCommentBtn.alpha = (introduce.count > 0 && introduce != member?.introduce) ? 1 : 0.5
    }
}

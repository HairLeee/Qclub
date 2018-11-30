//
//  MyInfoViewController.swift
//  QClub
//
//  Created by Dreamup on 10/5/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class MyInfoViewController: UIViewController {

    @IBOutlet weak var navigationView: NavigationBarQClub!
    
    @IBOutlet weak var imvDetailAvatar: UIImageView!
    @IBOutlet weak var imvAvar1: UIImageView!
    
    @IBOutlet weak var btnMyInfo2: UIButton!
    
    
    @IBOutlet weak var btnMyInfo3: UIButton!
    
    
    @IBAction func btnMyInfo3Action(_ sender: Any) {
        

        let infoViewVc3 = MyinfoModifyThreeViewController.init(nibName: "MyinfoModifyThreeViewController", bundle: nil)
        self.navigationController?.pushViewController(infoViewVc3, animated: true)
        
        
//        let TestVc = FavouriteViewController.init(nibName: "FavouriteViewController", bundle: nil)
//
//        TestVc.name = "KAkaka"
//
//        self.navigationController?.pushViewController(TestVc, animated: true)

        
    }
    
    @IBAction func btnMyInfo2Action(_ sender: Any) {
        
        let infoView2VC = MyinfoModifyTwoViewController.init(nibName: "MyinfoModifyTwoViewController", bundle: nil)
          self.navigationController?.pushViewController(infoView2VC, animated: true)
        
    }
    
    @IBAction func btnCommentAction(_ sender: Any) {
        
        let commentViewVC = MyInfoCommentViewController.init(nibName: "MyInfoCommentViewController", bundle: nil)
        self.navigationController?.pushViewController(commentViewVC, animated: true)
                
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        imvAvar1.image = UIImage.init(named: "avatar")
        
        
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(self.showAvatarDetail(sender:)))
        imvAvar1.isUserInteractionEnabled = true
        imvAvar1.tag = 1
        imvAvar1?.addGestureRecognizer(gesture)
   
    }
    
    func showAvatarDetail (sender:Any){
        
        if let gesture = sender as? UIGestureRecognizer{
            
            print("\(gesture.view?.tag)")
            
        }
        
        
    }

    func configNavigationBar() {
        navigationView.backAction = {
              self.navigationController?.popViewController(animated: true)
//            self.dismiss(animated: true, completion: nil)
        }
        navigationView.config(title: "공지사항", image: "setting_header_icon")
    }

}

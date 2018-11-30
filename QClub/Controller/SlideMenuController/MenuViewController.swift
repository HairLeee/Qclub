//
//  MenuViewController.swift
//  QClub
//
//  Created by Dream on 9/13/17.
//  Copyright © 2017 Dream. All rights reserved.
//
//Page 135 in the Storyboard
import UIKit

class MenuViewController: UIViewController {
    
    var homeViewController: HomeViewController!
    
    @IBOutlet var lbName: UILabel!
    
    @IBOutlet var imvAvatar: UIImageView!
    
    @IBOutlet var imvBg: UIImageView!
    var member:Member?
    
    
    
    @IBOutlet var btnLevelNAme: UIButton!
    
    @IBOutlet var stampPersonImv: UIButton!
    
    @IBOutlet var stampCompanyImv: UIButton!
    @IBOutlet var stampMarryImv: UIButton!
    @IBOutlet var stampIncomeImv: UIButton!
    @IBOutlet var stampRateImv: UIButton!
    @IBOutlet weak var lbHeart: UILabel!
    
    
    let stampMember:[String] = ["stamp_q1.png","stamp_q2.png","stamp_q3.png","stamp_qs.png","stamp_q0"]
    let stampPerson:[String] = ["stamp_invalid_person.png","stamp_valid_person.png"]
    let stampCompany:[String] = ["stamp_invalid_company.png","stamp_valid_company.png"]
    let stampMarry:[String] = ["stamp_invalid_marry.png","stamp_valid_marry.png"]
    let stampIcome:[String] = ["stamp_invalid_income.png","stamp_valid_income.png"]
    let stampRate:[String] = ["stamp_rate_average.png","stamp_rate_pretty.png","stamp_rate_good.png","stamp_rate_great.png","stamp_rate_excellent.png"]
    
    
    
    @IBAction func closeLeftMenuAction(_ sender: Any) {
        
        
        self.slideMenuController()?.closeLeft()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        RelationService.getHeartCount(completion: { (response) in
            if let count = response.data as? Int {
                self.lbHeart.text = "x \(count)"
            }
        }) { (error) in
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData(){
        if let pUserSeq = Context.getUserLogin()?.userSeq {
            self.showLoading()
            ProfileService.getProfileBasic(userSeq: pUserSeq, completion: {[weak self] (response) in
                guard let _self = self else { return }
                _self.stopLoading()
                _self.member = response.data as? Member
                _self.makeAvatarData()
                _self.setData(member: _self.member!)
            }) { (error) in
                
            }
        }
        
    }
    
    func makeAvatarData() {
        if let memberUnWrap = self.member {
            if let pictures = memberUnWrap.profilePicture {
                
                lbName.text = memberUnWrap.nickname
                imvAvatar.kf.setImage(with: URL.init(string: pictures[0].profilePictureUrl))
                imvBg.kf.setImage(with: URL.init(string: pictures[0].profilePictureUrl))

                
            }
        }
    }
    
    func setData(member:Member){
        self.member = member

        switch member.levelName.lowercased() {
        case "q1":
            
            btnLevelNAme.setImage(UIImage(named: stampMember[0]), for: .normal)
            break
        case "q2":
            btnLevelNAme.setImage(UIImage(named: stampMember[1]), for: .normal)
            break
        case "q3":
            btnLevelNAme.setImage(UIImage(named: stampMember[2]), for: .normal)
            break
        case "qs":
            btnLevelNAme.setImage(UIImage(named: stampMember[3]), for: .normal)
            break
        default:
              btnLevelNAme.setImage(UIImage(named: stampMember[4]), for: .normal)
            break
        }
        stampPersonImv.setImage(UIImage(named: stampPerson[1]), for: .normal)
        stampCompanyImv.setImage(UIImage(named: stampCompany[member.certQ1Cnt > 0 ? 1 : 0]), for: .normal)
        
        stampMarryImv.setImage(UIImage(named: stampMarry[member.certQ2Cnt > 0 ? 1 : 0]), for: .normal)
        stampIncomeImv.setImage(UIImage(named: stampIcome[member.certQ3Cnt > 0 ? 1 : 0]),for: .normal)
        
        
        if member.totalScore >= 90 {
            
            stampRateImv.setImage(UIImage(named: stampRate[4]), for: .normal)
        } else if member.totalScore >= 80 {
            stampRateImv.setImage(UIImage(named: stampRate[3]), for: .normal)
        } else if member.totalScore >= 70 {
            stampRateImv.setImage(UIImage(named: stampRate[2]), for: .normal)
        } else if member.totalScore >= 60 {
            stampRateImv.setImage(UIImage(named: stampRate[1]), for: .normal)
        } else {
            stampRateImv.setImage(UIImage(named: stampRate[0]), for: .normal)
        }
        
    }
    
    @IBAction func MyInfoAction(_ sender: Any) {
        let myInfoVC = MyInfoMainViewController.init(nibName: "MyInfoMainViewController", bundle: nil)
        navigationController?.pushViewController(myInfoVC, animated: true)
    }
    
    @IBAction func btnHeartAction(_ sender: Any) {
        
        let heartVC = HeartsViewController.init(nibName: "HeartsViewController", bundle: nil)
        navigationController?.pushViewController(heartVC, animated: true)
    }
    
    
    @IBAction func btnFavor(_ sender: Any) {
        let favVC = FavouriteViewController.init(nibName: "FavouriteViewController", bundle: nil)
        navigationController?.pushViewController(favVC, animated: true)
    }
    
    @IBAction func btnStore(_ sender: Any) {
        if Context.getUserLogin()?.createDate?.toLoginDate().addingTimeInterval(604800).compare(Date()) == ComparisonResult.orderedAscending {
            let storePromotionVC = StoreAfterPromotionViewController.init(nibName: "StoreAfterPromotionViewController", bundle: nil)
            self.navigationController?.pushViewController(storePromotionVC, animated: true)
        } else {
            let storePromotion = StoreViewController.init(nibName: "StoreViewController", bundle: nil)
            self.navigationController?.pushViewController(storePromotion, animated: true)
        }
    }
    
    @IBAction func shareAction(_ sender: Any) {
        let kakao = KakaoTalkManager()
        kakao.shareDownloadLink()
    }
    
    
    @IBAction func btnAttraction(_ sender: Any) {
        
        let dialog = AlertQClub.instanceFromNib(content: "나의 매력도를 확인하려면 하트2개가 필요합니다. 확인하시겠습니까?", image: "attraction_icon")
        dialog.action2 = {
            
            let charmVC = UIStoryboard.init(name: "RelationCard", bundle: nil).instantiateViewController(withIdentifier: "UserCharmViewController") as! UserCharmViewController
            charmVC.nickName = Context.getUserLogin()?.nickname
            self.navigationController?.pushViewController(charmVC, animated: true)
            
        }
        dialog.show()
        
    }
}

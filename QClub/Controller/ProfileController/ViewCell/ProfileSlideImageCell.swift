//
//  ProfileSlideImageCell.swift
//  QClub
//
//  Created by Dream on 9/22/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import FSPagerView
import Kingfisher

class ProfileSlideImageCell: ProfileBaseCell {

    var pagerView: FSPagerView!
    var presentFullScreenSlider : ((_ cell:ProfileBaseCell, _ index: Int)->())?
    var showInfo : (()->())?
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var pageViewContainer: UIView!
    
    @IBOutlet weak var numberLikeLb: UILabel!
    
    @IBOutlet weak var stampMemberImv: UIImageView!
    @IBOutlet weak var stampPersonImv: UIImageView!
    @IBOutlet weak var stampCompanyImv: UIImageView!
    @IBOutlet weak var stampMarryImv: UIImageView!
    @IBOutlet weak var stampIncomeImv: UIImageView!
    @IBOutlet weak var stampRateImv: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var icManWoman: UIImageView!
    @IBOutlet weak var btnShowInfo: UIButton!
    @IBOutlet weak var viewLike: UIView!
    
    var member: Member?
    
    
    let stampMember:[String] = ["stamp_q1","stamp_q2","stamp_q3","stamp_qs","stamp_q0"]
    let stampPerson:[String] = ["stamp_invalid_person","stamp_valid_person"]
    let stampCompany:[String] = ["stamp_invalid_company","stamp_valid_company"]
    let stampMarry:[String] = ["stamp_invalid_marry","stamp_valid_marry"]
    let stampIcome:[String] = ["stamp_invalid_income","stamp_valid_income"]
    let stampRate:[String] = ["stamp_rate_average","stamp_rate_pretty","stamp_rate_good","stamp_rate_great","stamp_rate_excellent"]
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pagerView = FSPagerView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_WIDTH * 9 / 16))
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.transformer = FSPagerViewTransformer(type: .depth)
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pageViewContainer.addSubview(pagerView)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setData(member:Member){
        self.member = member
        lbName.text = self.member?.nickname
        if let x : Int = (self.member?.likabilityScore) {
            if x > 0 {
                viewLike.isHidden = false
                btnShowInfo.isHidden = false
                numberLikeLb.text = "\(x)"
            } else {
                viewLike.isHidden = true
                btnShowInfo.isHidden = true
            }

        } else {
            viewLike.isHidden = true
            btnShowInfo.isHidden = true
        }
        icManWoman.image = (self.member?.gender == "여자" ? UIImage.init(named: "ic_woman_name") : UIImage.init(named: "ic_man_name"))
        
        switch member.levelName.lowercased() {
        case "q1":
            stampMemberImv.image = UIImage(named: stampMember[0])
            break
        case "q2":
            stampMemberImv.image = UIImage(named: stampMember[1])
            break
        case "q3":
            stampMemberImv.image = UIImage(named: stampMember[2])
            break
        case "qs":
            stampMemberImv.image = UIImage(named: stampMember[3])
            break
        default:
           stampMemberImv.image = UIImage(named: stampMember[4])
            break
        }
        
        stampPersonImv.image = UIImage(named: stampPerson[1])
        stampCompanyImv.image = UIImage(named: stampCompany[member.certQ1Cnt > 0 ? 1 : 0])
        stampMarryImv.image = UIImage(named: stampMarry[member.certQ2Cnt > 0 ? 1 : 0])
        stampIncomeImv.image = UIImage(named: stampIcome[member.certQ3Cnt > 0 ? 1 : 0])
        

        if member.totalScore >= 90 {
            stampRateImv.image = UIImage(named: stampRate[4])
        } else if member.totalScore >= 80 {
            stampRateImv.image = UIImage(named: stampRate[3])
        } else if member.totalScore >= 70 {
            stampRateImv.image = UIImage(named: stampRate[2])
        } else if member.totalScore >= 60 {
            stampRateImv.image = UIImage(named: stampRate[1])
        } else {
            stampRateImv.image = UIImage(named: stampRate[0])
        }
        
        if let memberUnWrap = self.member {
            if let picture = memberUnWrap.profilePicture {
                pageControl.numberOfPages = picture.count
            } else {
                pageControl.numberOfPages = 0
            }
        }
        pageControl.currentPage = 0
        pagerView.reloadData()
    }
    @IBAction func showInfo(_ sender: Any) {
        showInfo?()
    }
    
}

extension ProfileSlideImageCell : FSPagerViewDataSource,FSPagerViewDelegate{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        if let memberUnWrap = self.member {
            if let picture = memberUnWrap.profilePicture {
                return picture.count
            }
            return 0
        }
        return 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.contentMode = .scaleAspectFill
        if let pictures = self.member?.profilePicture {
            cell.imageView?.kf.setImage(with: URL(string: pictures[index].profilePictureUrl))
        }
        return cell
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        guard self.pageControl.currentPage != pagerView.currentIndex else {
            return
        }
        self.pageControl.currentPage = pagerView.currentIndex
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        if let action = presentFullScreenSlider {
            action(self, index)
        }

    }
    
}


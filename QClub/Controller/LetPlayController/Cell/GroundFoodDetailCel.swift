//
//  GroundFoodDetailCel.swift
//  QClub
//
//  Created by TuanNM on 10/25/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import FSPagerView

protocol GroundFoodDetailCellDelegate:class  {
    func willShowUserDetail(userId:Int)
}

class GroundFoodDetailCel: UITableViewCell {

    weak var delegate:GroundFoodDetailCellDelegate?
    
    @IBOutlet var btnGender: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var avatarImv: UIImageView!
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var slideImgContainer: UIView!
    @IBOutlet weak var numberLikeLb: UILabel!
    @IBOutlet weak var expandImv: UIImageView!
    @IBOutlet weak var addressLb: UILabel!
    @IBOutlet weak var mainFood: UILabel!
    @IBOutlet weak var restaurantName: UILabel!
    @IBOutlet weak var priceLb: UILabel!
    @IBOutlet weak var contactLb: UILabel!
    @IBOutlet weak var introduceLb: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var line1HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var line2HeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var likeViewHeighConstraint: NSLayoutConstraint!
    @IBOutlet var btn: UIButton!
    
    var pagerView: FSPagerView!
    var restaurant:GRestaurant?
    
    let itemsSize = (SCREEN_WIDTH - 50)/3

    var gotoGroundFoodWrite : (() ->())?
    var gotoImageDetail : (()->())?
    var doLikeRestaurant : ((_ likeOrUnLike: Bool)->())?
    var wantToSeeProfile : ((_ userSeq: Int)->())?
    var presentFullScreenSlider : ((_ cell:GroundFoodDetailCel, _ url: [String], _ index: Int)->())?
    @IBAction func showLikeAction(_ sender: Any) {
        if restaurant?.isRegister == "Y"{
            UIView.animate(withDuration: 0.2, animations: {
                self.likeViewHeighConstraint.constant = self.likeViewHeighConstraint.constant != 0 ? 0 : 10 + 2*self.itemsSize
                self.layoutIfNeeded()
                self.expandImv.transform = self.expandImv.transform.rotated(by: .pi)
            })
        }
    }
    @IBAction func gotoGroundFoodWrite(_ sender: Any) {
        gotoGroundFoodWrite?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likeViewHeighConstraint.constant = 0
        line1HeightConstraint.constant = 0.6
        line2HeightConstraint.constant = 0.6
        
        pagerView = FSPagerView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: slideImgContainer.frame.height))
        pagerView.delegate = self
        pagerView.dataSource = self
        pagerView.backgroundColor = UIColor.lightGray
        pagerView.transformer = FSPagerViewTransformer(type: .depth)
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        pageControl.numberOfPages = 0
        
        slideImgContainer.addSubview(pagerView)
        slideImgContainer.bringSubview(toFront: pageControl)
//        slideImgContainer.bringSubview(toFront: btn)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func setData(restaurant:GRestaurant){
        self.restaurant = restaurant
        nameLb.text = restaurant.registerName
        numberLikeLb.text = "\(restaurant.likeCnt)"
        addressLb.text = restaurant.address
        priceLb.text = restaurant.price
        contactLb.text = restaurant.contact
        introduceLb.text = restaurant.description
        mainFood.text = restaurant.mainDish
        restaurantName.text = restaurant.restaurant

        avatarImv.kf.setImage(with: URL(string: "http://\(restaurant.registerProfilePic)"))

        if restaurant.sameGender == "Y" {
            btnGender.isHidden = true
        } else {
            btnGender.isHidden = false
        }
        self.pageControl.numberOfPages = restaurant.tastyPictures.count
        
        self.collectionView.reloadData()
        self.pagerView.reloadData()
    }
    
    @IBAction func btnImageDetail(_ sender: Any) {
       
    }
    
    
    @IBAction func btnLikeAction(_ sender: Any) {
        doLikeRestaurant?(restaurant!.myLikeCnt == 1)
    }
    
    @IBAction func btnGenderAction(_ sender: Any) {
        
         wantToSeeProfile?(restaurant!.userSeq)
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
extension GroundFoodDetailCel:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restaurant?.tastyLikeUsers?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let userCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikeUserCell", for: indexPath) as! LikeUserCell
        userCell.avatar.layer.cornerRadius = itemsSize/2 - 10
        userCell.avatar.clipsToBounds = true
        userCell.avatar.kf.setImage(with: URL(string: ""))
        return userCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemsSize, height: itemsSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.willShowUserDetail(userId: indexPath.row)
    }
    
}

extension GroundFoodDetailCel : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 5, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat{
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat{
        return 5
    }
}


extension GroundFoodDetailCel : FSPagerViewDataSource,FSPagerViewDelegate{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return restaurant?.tastyPictures.count ?? 0
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        if let tastyPic = restaurant?.tastyPictures[index]{
            cell.imageView?.kf.setImage(with: URL(string: "http://" + tastyPic))
        }
        cell.imageView?.contentMode = .scaleAspectFill
        
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
            action(self, restaurant!.tastyPictures, index)
        }
    }
    
}



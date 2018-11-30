//
//  GroundFoodCell.swift
//  QClub
//
//  Created by TuanNM on 10/23/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class GroundFoodCell: UICollectionViewCell {
    
    @IBOutlet weak var foodImv: UIImageView!
    @IBOutlet weak var foodNameLb: UILabel!
    @IBOutlet weak var lbRestaurantName: UILabel!
    @IBOutlet weak var lbLocation: UILabel!
    @IBOutlet weak var likeView: UIView!
    @IBOutlet weak var numberLilkeLb: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor.init(hexString: LINE_GRAY_COLOR)?.cgColor
        
        likeView.layer.cornerRadius = 3
        likeView.clipsToBounds = true
    }
    
    func addSubiew(){
        let imageName = "ic_character.png"
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        self.addSubview(imageView)
    }
    
    func setData(restaurant:GRestaurant){
   
        foodImv.kf.setImage(with: URL(string: restaurant.tastyPicture))
        foodNameLb.text = restaurant.mainDish
        lbRestaurantName.text = restaurant.restaurant
        lbLocation.text = restaurant.tastyLocation
        if restaurant.likeCnt > 0 {
            likeView.isHidden = false
            numberLilkeLb.text = "\(restaurant.likeCnt)"
        } else {
            likeView.isHidden = true
        }
    }
    
}

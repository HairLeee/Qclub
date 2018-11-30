//
//  MyInfoMainTopViewCell.swift
//  QClub
//
//  Created by Dreamup on 10/25/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import Kingfisher
import TOCropViewController
class MyInfoMainTopViewCell: UITableViewCell {
    
    struct cellID {
        static let MyInfoCellID = "MyInfoCellID"
    }
    
    var isMan = false
    var chooseOrTakeImageDelegate:ChooseOrTakeImage?
    @IBOutlet var btnLevelNAme: UIImageView!
    
    @IBOutlet var stampPersonImv: UIImageView!
    
    @IBOutlet var stampCompanyImv: UIImageView!
    
    @IBOutlet var stampMarryImv: UIImageView!
    
    @IBOutlet var stampIncomeImv: UIImageView!
    
    @IBOutlet var stampRateImv: UIImageView!
    
    
    @IBOutlet var lbNickName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var imvDetal: UIImageView!
    
    
    let stampMember:[String] = ["stamp_q1.png","stamp_q2.png","stamp_q3.png","stamp_qs.png","stamp_q0.png"]
    let stampPerson:[String] = ["stamp_invalid_person.png","stamp_valid_person.png"]
    let stampCompany:[String] = ["stamp_invalid_company.png","stamp_valid_company.png"]
    let stampMarry:[String] = ["stamp_invalid_marry.png","stamp_valid_marry.png"]
    let stampIcome:[String] = ["stamp_invalid_income.png","stamp_valid_income.png"]
    let stampRate:[String] = ["stamp_rate_average.png","stamp_rate_pretty.png","stamp_rate_good.png","stamp_rate_great.png","stamp_rate_excellent.png"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupUI(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "MyInfomationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellID.MyInfoCellID)
        
        
    }
    
    var mImageList = [UserImage]()
    func bidingData(member:Member){
        lbNickName.text = member.nickname
        setData(member: member)
        if let profilePicture = member.profilePicture {
            
            let profile =  profilePicture[0]
            
            print("Image MyInfoMainTopViewCell == \(profile.profilePictureUrl)")
            
            mImageList = profilePicture
           
             imvDetal.kf.setImage(with: URL.init(string: mImageList[0].profilePictureUrl))
            let numberOfEmptyRow = 10 - mImageList.count
            
            for _ in 0 ..< numberOfEmptyRow {
                
                let userImage = UserImage()
                userImage.profilePicture = nil
                userImage.profilePictureUrl = ""
                userImage.descriptionString = ""
                userImage.orderSeq = -1
                mImageList.append(userImage)
            }
            
             collectionView.reloadData()
        }
    }
    
    func setData(member:Member){
       
        
        switch member.levelName.lowercased() {
        case "q1":
            
            btnLevelNAme.image = UIImage(named: stampMember[0])
            break
        case "q2":
           btnLevelNAme.image = UIImage(named: stampMember[1])
            break
        case "q3":
           btnLevelNAme.image = UIImage(named: stampMember[2])
            break
        case "qs":
            btnLevelNAme.image = UIImage(named: stampMember[3])
            break
        default:
             btnLevelNAme.image = UIImage(named: stampMember[4])
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
        
    }
    
    func updateImageAfterChooseOrTakeImage(pImage: UIImage,indexOfCollectionItem:Int){
        mImageList[indexOfCollectionItem].profilePicture = pImage
        mImageList[indexOfCollectionItem].orderSeq = indexOfCollectionItem
        collectionView.reloadData()
    }
    
}


extension MyInfoMainTopViewCell : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID.MyInfoCellID, for: indexPath) as! MyInfomationCollectionViewCell
        if mImageList.count > indexPath.row {
            cell.bidingData(url: mImageList[indexPath.row], index : indexPath.row)
        }
        return cell
    }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        
        if mImageList[indexPath.row].orderSeq != -1 {
             imvDetal.kf.setImage(with: URL.init(string: mImageList[indexPath.row].profilePictureUrl))
        } else {
            chooseOrTakeImageDelegate?.ChooseOrTakeImage(pIndexOfImage: indexPath.row)
        }
        
      
        
    }
    
}

extension MyInfoMainTopViewCell : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    } 
}

extension MyInfoMainTopViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.collectionView.frame.size.width)/5 , height: self.collectionView.frame.size.width/6)
    }
}



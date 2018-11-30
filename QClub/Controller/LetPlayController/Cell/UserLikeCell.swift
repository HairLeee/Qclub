//
//  UserLikeCell.swift
//  QClub
//
//  Created by TuanNM on 10/27/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class UserLikeCell: UITableViewCell {

    weak var delegate:GroundFoodDetailCellDelegate?
    let itemsSize = (SCREEN_WIDTH - 50)/3
    @IBOutlet weak var collectionView: UICollectionView!
    var users = [ItItemLikeUser]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setData(users: [ItItemLikeUser]?) {
        if let usersUnwap = users {
            self.users = usersUnwap
            self.collectionView.reloadData()
        }
    }
    
}

extension UserLikeCell:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let userCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikeUserCell", for: indexPath) as! LikeUserCell
        userCell.avatar.layer.cornerRadius = itemsSize/2 - 10
        userCell.avatar.clipsToBounds = true
        userCell.avatar.kf.setImage(with: URL.init(string: self.users[indexPath.row].profilePicture))
        return userCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemsSize, height: itemsSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.willShowUserDetail(userId: indexPath.row)
    }
    
}


extension UserLikeCell : UICollectionViewDelegateFlowLayout{
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

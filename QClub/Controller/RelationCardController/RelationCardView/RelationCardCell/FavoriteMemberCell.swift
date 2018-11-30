//
//  FavoriteMemberCell.swift
//  QClub
//
//  Created by SMR on 10/16/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class FavoriteMemberCell: UITableViewCell {

    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var btnShowMore: UIButton!
    @IBOutlet weak var btnShowMoreHeight: NSLayoutConstraint!
    @IBOutlet weak var btnShowMoreTop: NSLayoutConstraint!
    @IBOutlet weak var btnShowMoreBottom: NSLayoutConstraint!
    
    var favoriteMembers:[UserMatchInfo] = []
    var showMoreAction : (() -> ())?
    var selectMember : ((_ member: UserMatchInfo) -> ())?
    var deleteMember : ((_ indexPathRow: Int) -> ())?
    var isShowMore = false
    var letterAction: ((_ status : MessageStatus, _ index: Int) ->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        setupTableview()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
    override func layoutSubviews() {
        
    }
    
    @IBAction func showMoreTUI(_ sender: Any) {
        showMoreAction?()
        isShowMore = true
    }
    
    func setupData(members: [UserMatchInfo], isFromMe: Bool) {
        self.favoriteMembers = members
        lbTitle.text = isFromMe ? "내가 호감 있는 인연" : "내게 호감 있는 인연"
        hideBtnShowMore(isShow: self.favoriteMembers.count > 6 && !isShowMore)
        self.collectionView.reloadData()
    }
    
    func setupTableview() {
        collectionView.register(UINib.init(nibName: "MemberFavoriteCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MemberFavoriteCollectionCell")
        collectionView.isScrollEnabled = false
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        collectionView.addGestureRecognizer(lpgr)
    }
    
    func hideBtnShowMore(isShow: Bool) {
        if isShow {
            btnShowMore.isHidden = false
            btnShowMoreHeight.constant = 40
            btnShowMoreTop.constant = 15
            btnShowMoreBottom.constant = 20
        } else {
            btnShowMore.isHidden = true
            btnShowMoreHeight.constant = 0
            btnShowMoreTop.constant = 0
            btnShowMoreBottom.constant = 0
        }
    }
    
    @objc func handleLongPress(gesture : UILongPressGestureRecognizer!) {
        let p = gesture.location(in: self.collectionView)
        
        if let indexPath = self.collectionView.indexPathForItem(at: p) {
            deleteMember?(indexPath.row)
            
        } else {
            print("couldn't find index path")
        }
    }

}
extension FavoriteMemberCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteMembers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemberFavoriteCollectionCell", for: indexPath) as! MemberFavoriteCollectionCell
        cell.setup(data: favoriteMembers[indexPath.row])
        cell.letterAction = {
            [weak self] status in
            guard let _self = self else { return  }
            _self.letterAction?(status,indexPath.row)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.collectionView.frame.size.width - 20)/3 , height: (self.collectionView.frame.size.width - 20)/3*1.8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectMember?(favoriteMembers[indexPath.row])
    }
    
}

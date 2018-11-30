//
//  GroundMyItemViewController.swift
//  QClub
//
//  Created by TuanNM on 10/26/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class GroundMyItemViewController: BaseViewController {

    enum TAB_TYPE {
        case RECENTLY_ITEM
        case MY_ITEM
    }
    
    @IBOutlet weak var navigationBar: NavigationBarQClub!
    @IBOutlet weak var recentItemBtn: GroundTab!
    @IBOutlet weak var myItemBtn: GroundTab!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let itemsSize = (SCREEN_WIDTH - 20)/3
    var tabType:TAB_TYPE = .RECENTLY_ITEM
    var arrRecentItems:[ItemObject] = []
    var arrMyItems:[ItemObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.config(title: "My 잇아이템", image: "ic_myItem.png")
        navigationBar.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        getItemRecent()
        getMyItem()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getItemRecent() {
        self.showLoading()
        ItemService.getItemRecent(offset: arrRecentItems.count, completion: { (response) in
            self.stopLoading()
            if let items = response.data as? [ItemObject] {
                if self.arrRecentItems.count == 0 {
                    self.arrRecentItems = items
                } else {
                    self.arrRecentItems.append(contentsOf: items)
                }
                self.collectionView.reloadData()
            }
        }) { (error) in
            self.stopLoading()
        }
    }
    
    func getMyItem() {
        self.showLoading()
        ItemService.getMyItems(offset: 0, completion: { (response) in
            self.stopLoading()
            if let items = response.data as? [ItemObject] {
                self.arrMyItems = items
                self.collectionView.reloadData()
            }
        }) { (error) in
            self.stopLoading()
        }
    }
    
    @IBAction func recentItemAction(_ sender: Any) {
        recentItemBtn.setSelected(isSelect: true)
        myItemBtn.setSelected(isSelect: false)
        if tabType != .RECENTLY_ITEM{
            tabType = .RECENTLY_ITEM
            collectionView.reloadData()
        }
    }
    
    @IBAction func myItemAction(_ sender: Any) {
        recentItemBtn.setSelected(isSelect: false)
        myItemBtn.setSelected(isSelect: true)
        if tabType != .MY_ITEM{
            tabType = .MY_ITEM
            collectionView.reloadData()
        }
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if tabType == .MY_ITEM {
            return true
        }
        return false
    }
    
}

extension GroundMyItemViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.tabType == .MY_ITEM {
            return arrMyItems.count + 1
        } else {
            return arrRecentItems.count + 1
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (indexPath.row == arrMyItems.count && self.tabType == .MY_ITEM) || (indexPath.row == arrRecentItems.count && self.tabType == .RECENTLY_ITEM) {
            let postCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostItemCell", for: indexPath) as! PostItemCell
            postCell.actionMoreItem = {
                [weak self] in
                guard let _self = self else {return}
                if _self.tabType == .RECENTLY_ITEM {
                    _self.getItemRecent()
                }
            }
            
            return postCell
        }
        
        let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroundItemCell", for: indexPath) as! GroundItemCell
            itemCell.setData(item: (self.tabType == .MY_ITEM ? arrMyItems[indexPath.row] : arrRecentItems[indexPath.row]))
        return itemCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (indexPath.row == arrMyItems.count && self.tabType == .MY_ITEM) || (indexPath.row == arrRecentItems.count && self.tabType == .RECENTLY_ITEM) {
            return CGSize(width: SCREEN_WIDTH - 10, height: 100)
        }
        return CGSize(width: itemsSize, height: itemsSize + 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row < self.arrRecentItems.count {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "GroundItemDetailViewController") as! GroundItemDetailViewController
            vc.item = self.arrRecentItems[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension GroundMyItemViewController : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets{
        return UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
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


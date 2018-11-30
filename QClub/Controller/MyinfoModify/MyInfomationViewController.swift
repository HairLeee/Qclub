//
//  MyInfomationViewController.swift
//  QClub
//
//  Created by Dreamup on 10/24/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class MyInfomationViewController: BaseViewController {
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var navigationView: NavigationBarQClub!
    
    var isMan = false
    
    let dataMan = ["듬직하다", "남자지만 섹시하다", "애교가 많아 보인다", "귀엽다", "애교가 많아 보인다", "귀엽다", "애교가 많아 보인다", "귀엽다"]
    
    let dataWoman = ["섹시하다", "애교가 많아 보인다", "귀엽다", "지적이다", "애교가 많아 보인다", "귀엽다", "애교가 많아 보인다", "귀엽다"]
    
    struct cellID {
        static let MyInfoCellID = "MyInfoCellID"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        
    //        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(self.showAvatarDetail(sender:)))
    //        imvAvar1.isUserInteractionEnabled = true
    //        imvAvar1.tag = 1
    //        imvAvar1?.addGestureRecognizer(gesture)
        
    }
    
    func showAvatarDetail (sender:Any){
        
//        if let gesture = sender as? UIGestureRecognizer{
//
//            print("\(gesture.view?.tag)")
//
//        }
        
        
    }
    
    func setupUI(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "MyInfomationCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: cellID.MyInfoCellID)
        
    }
    
    
    override func configNavigationBar() {
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
            //            self.dismiss(animated: true, completion: nil)
        }
        navigationView.config(title: "내 정보 수정", image: "myinfo2_header_icon")
    }


    @IBAction func btnMyInfo1Action(_ sender: Any) {
        
        
        
//        self.navigationController?.pushViewController(MyInfModifyOne1ViewController.init(nibName:"MyInfModifyOne1ViewController", bundle: nil), animated: true)
    }
    
    
    
    @IBOutlet weak var btnMyInfo2Action: UIButton!
    
    
    @IBAction func btnMyInfo2Action(_ sender: Any) {
        let infoView2VC = MyinfoModifyTwoViewController.init(nibName: "MyinfoModifyTwoViewController", bundle: nil)
        self.navigationController?.pushViewController(infoView2VC, animated: true)
        
    }
    
    @IBOutlet weak var btnMyInfo3Action: UIButton!
    
    @IBAction func btnMyInfo3Action(_ sender: Any) {
        let infoViewVc3 = MyinfoModifyThreeViewController.init(nibName: "MyinfoModifyThreeViewController", bundle: nil)
        self.navigationController?.pushViewController(infoViewVc3, animated: true)
    }
    
    @IBAction func btnCommentAction(_ sender: Any) {
        
        let commentViewVC = MyInfoCommentViewController.init(nibName: "MyInfoCommentViewController", bundle: nil)
        self.navigationController?.pushViewController(commentViewVC, animated: true)
        
    }
    
    
    
}

extension MyInfomationViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID.MyInfoCellID, for: indexPath) as! MyInfomationCollectionViewCell
        //        cell.lbTitle.text =  isMan ? dataMan[indexPath.row] : dataWoman[indexPath.row]
//        cell.configBackgroundForSelected(isSelected: selectedCells.contains(indexPath.row))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if selectedCells.count >= 3 {
//            collectionView.deselectItem(at: indexPath, animated: false)
//            return
//        }
//        let cell = collectionView.cellForItem(at: indexPath) as! Join3CollectionViewCell
//        cell.configBackgroundForSelected(isSelected: true)
//        selectedCells.insert(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath) as! Join3CollectionViewCell
//        cell.configBackgroundForSelected(isSelected: false)
//        selectedCells.remove(indexPath.row)
    }
    
}

extension MyInfomationViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isMan ? dataMan.count : dataWoman.count
    }
}

extension MyInfomationViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.collectionView.frame.size.width)/4 , height: self.collectionView.frame.size.width/6)
    }
}





//
//  LetterViewController.swift
//  QClub
//
//  Created by SMR on 10/17/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import SendBirdSDK

/*
 Letter, Page 52 in StoryBoard
 */
class LetterViewController: BaseViewController {

    @IBOutlet weak var navigationView: NavigationBarQClub!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var members = [LetterUserObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableview()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func configNavigationBar() {
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        navigationView.config(title: "관심편지 목록", image: "ic_navigation_user_letter")
    }
    
    func setupTableview() {
        collectionView.register(UINib.init(nibName: "MemberFavoriteCollectionCell", bundle: nil), forCellWithReuseIdentifier: "MemberFavoriteCollectionCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        collectionView.addGestureRecognizer(lpgr)
    }
    
    @objc func handleLongPress(gesture : UILongPressGestureRecognizer!) {
        if gesture.state != UIGestureRecognizerState.began {
            return
        }
        let p = gesture.location(in: self.collectionView)
        
        if let indexPath = self.collectionView.indexPathForItem(at: p) {
            self.deleteMember(index: indexPath.row)
            
        } else {
            print("couldn't find index path")
        }
    }
    
    func deleteMember(index: Int) {
        let deletePopup = Main3PopupDelete.instanceFromNib(deleteSide: .outSideChat)
        deletePopup.actionOk = {
            [weak self] in
            guard let _self = self else { return  }
            _self.showLoading()
            MessageService.deleteLetter(messageSeq: _self.members[index].interestMessageSeq ?? 0, completion: { (response) in
                _self.stopLoading()
                _self.collectionView.performBatchUpdates({
                    _self.members.remove(at: index)
                    _self.collectionView.deleteItems(at: [IndexPath.init(row: index, section: 0)])
                }) { (finish) in
                    
                }
            }) { (error) in
                _self.stopLoading()
            }
        }
        deletePopup.show()
    }
    
    func getData(){
        self.showLoading()
        MessageService.getAllLetter(completion: { (response) in
            if let data = response.data as? [LetterUserObject] {
                let dataValid = data.filter {$0.user != nil}
                self.members = dataValid
            }
            self.stopLoading()
            self.collectionView.reloadData()
        }) { (error) in
            self.stopLoading()
        }
    }
}
extension LetterViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return members.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemberFavoriteCollectionCell", for: indexPath) as! MemberFavoriteCollectionCell
        cell.setupLetter(user: self.members[indexPath.row])
        cell.letterAction = {
            [weak self] status in
            guard let _self = self else {return}
            Utils.messageAction(user: _self.members[indexPath.row].user!, viewController: _self, messageSeq: _self.members[indexPath.row].interestMessageSeq)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.collectionView.frame.size.width - 50)/3 , height: 15 + (self.collectionView.frame.size.width - 50)/3 + 70)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        Utils.gotoUserVC(viewController: self, userSeq: members[indexPath.row].userSeq ?? 0, userSpecialPopupType: .other, isHideSpecialRegist: true)
    }
}

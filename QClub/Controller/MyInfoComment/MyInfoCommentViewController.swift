//
//  MyInfoCommentViewController.swift
//  QClub
//
//  Created by Dreamup on 10/12/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper
class MyInfoCommentViewController: BaseViewController, CommentPrl {
    
    
    
    
    
    
    @IBOutlet weak var navigationView: NavigationBarQClub!
    
    @IBOutlet weak var tbView: UITableView!
    
    
    @IBOutlet var tbNumberOfMessages: UILabel!
    
    
    
    struct cellIdentifier {
        static let cellId = "COMMENT_CELL"
        static let cellId2 = "COMMENT_CELL2"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView ()
        getData()
    }
    
    func doOKAction(index: Int) {
        
        print("Tag == \(mMyInfoComments[index].adviceSeq)")
        
        //        let row = [IndexPath.init(row: index, section: 0)]
        //        tbView.reloadRows(at: row, with: .fade)
        //        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
        //            self.tbView.scrollToRow(at: row[0], at: .middle, animated: true)
        //        }
        
        
        self.showLoading()
        MenuService.readMyinfoComment(adviceSeq: mMyInfoComments[index].adviceSeq , completion: { (response) in
            self.stopLoading()
            
            if response.code == 0 {
                self.mMyInfoComments.removeAll()
                self.getData()
            } else {
                Utils.gotoStore(viewController: self)
                
            }
        }) { (error) in
            self.stopLoading()
            
            
        }
        
        
        
    }
    
    
    func setupView (){
        tbView.delegate = self
        tbView.dataSource = self
        tbView.register(UINib.init(nibName: "CommentViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier.cellId)
        tbView.register(UINib.init(nibName: "CommentViewCellWithoutCm", bundle: nil), forCellReuseIdentifier: cellIdentifier.cellId2)
        tbView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    var mMyInfoComments = [MyInfoComment]()
    func getData()  {
        
        MenuService.getMyinfoComment(completion: { (response) in
            
            if let comments = response.data as? [MyInfoComment] {
                
                self.mMyInfoComments = comments
                self.tbNumberOfMessages.text = "미확인 조언 총 \(comments.count)건"
                self.tbView.reloadData()
                
            }
            
            
            
        }) { (error) in
            
            
            
            
            
        }
        
        
    }
    
    override func configNavigationBar() {
        
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
            
        }
        navigationView.config(title: "프로필 조언 확인하기", image: "myinfo_comment_icon_small2")
        
    }
    
}

extension MyInfoCommentViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mMyInfoComments.count
    }
    
}

extension MyInfoCommentViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell
        
        if (mMyInfoComments[indexPath.row].paidDate != nil) {
            cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.cellId, for: indexPath) as! CommentViewCell
            (cell as! CommentViewCell).bidingData(data: mMyInfoComments[indexPath.row], isOpened: true)
            
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.cellId2, for: indexPath) as! CommentViewCellWithoutCm
            (cell as! CommentViewCellWithoutCm).doOKAction = self
            (cell as! CommentViewCellWithoutCm).tag = indexPath.row
            (cell as! CommentViewCellWithoutCm).bidingData(data: mMyInfoComments[indexPath.row], isOpened: true)
            
        }
        
        
        return cell
    }
    
}





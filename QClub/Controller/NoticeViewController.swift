//
//  NoticeViewController.swift
//  QClub
//
//  Created by Dreamup on 10/5/17.
//  Copyright © 2017 Dream. All rights reserved.
//
//Page 138 in the Storyboard
import UIKit

class NoticeViewController: BaseViewController, noticeCellDelegate {
    
    @IBOutlet weak var navigationView: NavigationBarQClub!
    @IBOutlet weak var tableview: UITableView!
    var cellExplains = Set<Int>()
    struct cellIdentifier {
        static let heartCellId = "NOTICE_CELL"
    }
    
    func setupUI (){
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib.init(nibName: "NoticeCell", bundle: nil), forCellReuseIdentifier: cellIdentifier.heartCellId)
        tableview.rowHeight = UITableViewAutomaticDimension
        
    }
    
    var noticeList = [Notice]()
    
    func getData(){
        self.showLoading()
        MenuService.getNotices(offset: 1, completion: { (response) in
            
            self.noticeList = response.data as! [Notice]
            self.tableview.reloadData()
            self.stopLoading()
        }) { (error) in
            self.stopLoading()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI ()
        getData()
        
    }
    
    var previousIndex:Int? = 0
    func cellExpand(index: Int, isExpand: Bool) {
        
      
        
        if isExpand {
            cellExplains.removeAll()
            cellExplains.insert(index)
        } else {
            cellExplains.remove(index)
        }
        
//        self.tableview.reloadData()
        self.tableview.reloadRows(at: [IndexPath.init(row: previousIndex!, section: 0)], with: .fade)
        self.tableview.reloadRows(at: [IndexPath.init(row: index, section: 0)], with: .fade)
        previousIndex = index
    }
    
    override  func configNavigationBar() {
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
            
        }
        navigationView.config(title: "공지사항", image: "setting_header_icon")
    }
    
}



extension NoticeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return noticeList.count
    }
    
}



extension NoticeViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.heartCellId, for: indexPath) as! NoticeCell
        
        cell.noticeCell = self
        cell.tag = indexPath.row
        cell.bidingData(isExpand: cellExplains.contains(indexPath.row), noticeList:noticeList, index:indexPath.row)
        
        
        return cell
    }
    
}

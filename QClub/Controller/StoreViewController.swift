//
//  StoreViewController.swift
//  QClub
//
//  Created by Dreamup on 9/29/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class StoreViewController: BaseViewController {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var navigationView: NavigationBarQClub!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getData()
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    struct cellIdentifier {
        static let heartCellId = "STORE_CELL"
    }
    
    var storeList = [Store]()
    func getData(){
        self.showLoading()
        MenuService.getStore(offset: 1, completion: { (response) in
            
            
            self.storeList = response.data as! [Store]
            self.tableview.reloadData()
            self.stopLoading()
        }) { (error) in
            
            
            
        }
        
        
        
    }
    
    func setupUI() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib.init(nibName: "StoreCell", bundle: nil), forCellReuseIdentifier: cellIdentifier.heartCellId)
    }
    
    override func configNavigationBar() {
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        navigationView.config(title: "스토어", image: "store_header_icon")
    }
    
    
}

extension StoreViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.heartCellId, for: indexPath) as! StoreCell
        cell.bindingData(storeList:storeList, index:indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

extension StoreViewController:UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storeList.count
    }
    
    
}


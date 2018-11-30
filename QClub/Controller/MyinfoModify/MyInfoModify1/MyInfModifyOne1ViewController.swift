//
//  MyInfModifyOne1ViewController.swift
//  QClub
//
//  Created by Dreamup on 10/24/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class MyInfModifyOne1ViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var tbView: UITableView!
    var arrCell:[UITableViewCell] = []
    
    
    @IBOutlet weak var navigationView: NavigationBarQClub!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        tbView.delegate = self
        tbView.dataSource = self
        
        let topCell = tbView.dequeueReusableCell(withIdentifier: "TopCell") as! TopCell
        
        let midCell = tbView.dequeueReusableCell(withIdentifier: "MidCell") as! MidCell
        
        let bottomCell = tbView.dequeueReusableCell(withIdentifier: "BottomCell") as! BottomCell
        
        arrCell = [topCell,midCell,bottomCell]
        
        tbView.estimatedRowHeight = 100
        tbView.rowHeight = UITableViewAutomaticDimension
        tbView.allowsSelection = false
        
    }
    
    func configNavigationBar() {
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
            //            self.dismiss(animated: true, completion: nil)
        }
        navigationView.config(title: "공지사항", image: "setting_header_icon")
    }
    
    
    
}

extension MyInfModifyOne1ViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = arrCell[indexPath.row] as! TopCell
            cell.bidingData()
            
        case 1:
            let cell = arrCell[indexPath.row] as! MidCell
            cell.bidingData()
            
            
            
        default:
            
            print("Default")
            
        }
        
        return arrCell[indexPath.row]
    }
    
}


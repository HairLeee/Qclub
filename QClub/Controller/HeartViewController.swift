//
//  HeartViewController.swift
//  QClub
//
//  Created by Dreamup on 9/29/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class HeartViewController: UIViewController {
    
    @IBOutlet weak var navigationView: NavigationBarQClub!
    @IBOutlet weak var tableview: UITableView!
    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    struct cellIdentifier {
        static let heartCellId = "HEART_CELL"
    }
    
    var chooseNumbers = [1,2,3,4,5,6,7,8,9,10]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        setupUI()
        getData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func configNavigationBar() {
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
        navigationView.config(title: "나의 하트", image: "heart_header_icon")
    }
    
    func setupUI() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib.init(nibName: "HeartCell", bundle: nil), forCellReuseIdentifier: cellIdentifier.heartCellId)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib.init(nibName: "HeartCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "heartCollectionViewCell")
        
        
    }
    
    var index:Int = 1
    var hearts = [Heart]()
    func getData(){
        self.showLoading()
        MenuService.getHeart(offset: index, completion: { (response) in
            
            //            if let pHearts =  response.data as [Heart] {
            self.hearts = response.data as! [Heart]
            self.tableview.reloadData()
            self.stopLoading()
            //            }
            
            
            
            
        }) { (error) in
            
            
            
            
        }
        
        
        
    }
    
    
    
    
    @IBAction func btnNext(_ sender: Any) {
        if index < 10 {
            index = index + 1
            hearts.removeAll()
            getData()
        }
        
    }
    
    
    @IBAction func btnPre(_ sender: Any) {
        if index > 0 {
            index = index - 1
            hearts.removeAll()
            getData()
        }
        
    }
}

extension HeartViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hearts.count
    }
}

extension HeartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.heartCellId, for: indexPath) as! HeartCell
        cell.bindingData(pHeart:hearts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}



extension HeartViewController:UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeartCollectionViewCell", for: indexPath) as! HeartCollectionViewCell
        cell.bidingData(position:chooseNumbers[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chooseNumbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: (self.collectionView.frame.size.width)/10 , height: self.collectionView.frame.size.width/10)
    }
    
    
}




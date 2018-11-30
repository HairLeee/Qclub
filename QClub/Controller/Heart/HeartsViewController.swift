//
//  HeartsViewController.swift
//  QClub
//
//  Created by Dreamup on 10/30/17.
//  Copyright © 2017 Dream. All rights reserved.
//
//Page 137 in the Storyboard
import UIKit

class HeartsViewController: BaseViewController {
    
    @IBOutlet weak var navigationView: NavigationBarQClub!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!

    struct cellIdentifier {
        static let heartCellId = "HEART_CELL"
    }
    
    var chooseNumbers = [1,2,3,4,5,6,7,8,9,10]
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupUI()
        getData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
   override func configNavigationBar() {
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
        
        collectionView.register(UINib.init(nibName: "HeartCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HeartCollectionViewCell")
        
   
    }
    
    var index:Int = 1
    var isFirstTimeComeHere = true
    var hearts = [Heart]()
    func getData(){
        count = 0
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
    
    
    @IBAction func btnStoreAction(_ sender: Any) {
        
        let storeVC = StoreAfterPromotionViewController.init(nibName: "StoreAfterPromotionViewController", bundle: nil)
        navigationController?.pushViewController(storeVC, animated: true)
       
        
        
//        let storyBoard = UIStoryboard.init(name: "Store", bundle: nil)
//        let vc = storyboard?.instantiateViewController(withIdentifier: "StoreViewController") as! StoreViewController
//
////        self.present(vc!, animated: true, completion: nil)
//
//        navigationController?.pushViewController(vc, animated: true)
        
        
        
    }
    
    
    @IBAction func btnNext(_ sender: Any) {
        if index < 10 {
            index = index + 1
            hearts.removeAll()
            getData()
            self.collectionView.reloadData()
        }
        
    }
    
    
    @IBAction func btnPre(_ sender: Any) {
        if index > 1 {
            index = index - 1
            hearts.removeAll()
            getData()
            self.collectionView.reloadData()
        }
        
    }
}

extension HeartsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hearts.count
    }
}

extension HeartsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.heartCellId, for: indexPath) as! HeartCell
        cell.bindingData(pHeart:hearts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}



extension HeartsViewController:UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeartCollectionViewCell", for: indexPath) as! HeartCollectionViewCell
        
        print("Come here")
        
        if chooseNumbers[indexPath.row] == index, count == 0 {
            cell.lbPosition.textColor = UIColor.orange
            count = 1
            
            
        } else {
            cell.lbPosition.textColor = UIColor.black
            
        }
        
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

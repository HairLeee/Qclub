//
//  OurStoryController.swift
//  QClub
//
//  Created by Dream on 9/13/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class OurStoryController: BaseViewController {
    
    
    
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var tbView: UITableView!
    
    @IBOutlet weak var navigationView: NavigationBarQClub!
    struct cellIdentifier {
        static let ourStoryCell = "ourStoryCell"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        getData()
    }
    
    func setupUI(){
        tbView.delegate = self
        tbView.dataSource = self
        tbView.register(UINib.init(nibName: "OurStoryTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier.ourStoryCell)
    }
    
    var boardList = [OurStoryModel]()
    func getData(){
        
        let ourStoryModel1 = OurStoryModel(title: "10대 후반 ~ 20대 소소한 일상이야기", nameOfIcon: "outstory_gender1_icon")
        let ourStoryModel2 = OurStoryModel(title: "30~40대 소소한 일상이야기", nameOfIcon: "outstory_gender2_icon")
        let ourStoryModel3 = OurStoryModel(title: "50대 소소한 일상이야기", nameOfIcon: "outstory_gender3_icon")
        let ourStoryModel4 = OurStoryModel(title: "다솔 속마음", nameOfIcon: "outstory_gender4_icon")
        let ourStoryModel5 = OurStoryModel(title: "Q클럽 속마음", nameOfIcon: "outstory_gender5_icon")
    
        boardList.append(ourStoryModel1)
        boardList.append(ourStoryModel2)
        boardList.append(ourStoryModel3)
        boardList.append(ourStoryModel4)
        boardList.append(ourStoryModel5)
        tbView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func configNavigationBar() {
        
        //        navigationView.backAction = {
        //            self.navigationController?.popViewController(animated: true)
        //
        //        }
        //        navigationView.config(title: "공지사항", image: "setting_header_icon")
        
    }
    
    func updateLayoutAferGettingDataFinished(){
        
        
        
        
    }
    
    
    
    
}

extension OurStoryController:UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boardList.count
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.ourStoryCell, for: indexPath) as! OurStoryTableViewCell
        cell.bidingData(OurStoryModel:boardList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      print("Item == \(boardList[indexPath.row].mTitle)")
        
        let board1VC = Board1ViewController.init(nibName: "Board1ViewController", bundle: nil) as! Board1ViewController
        board1VC.mStoryDetail = indexPath.row + 1
        board1VC.boardName = boardList[indexPath.row].mTitle
        self.navigationController?.pushViewController(board1VC, animated: true)
            
            
 
       
    }
    
    
    
}


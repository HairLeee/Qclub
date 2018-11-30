//
//  FqaViewController.swift
//  QClub
//
//  Created by Dreamup on 10/2/17.
//  Copyright © 2017 Dream. All rights reserved.
//
//Page 144 in the Storyboard
import UIKit
import ObjectMapper

class FqaViewController: UIViewController, FaqCellDelegate {


    @IBOutlet weak var tableview: UITableView!
    
    var cellExplains = Set<Int>()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        getData()
        
    }
    
    struct cellIdentifier {
        static let heartCellId = "FAQ_CELL"
    }
    
    func setupUI() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(UINib.init(nibName: "FaqCell", bundle: nil), forCellReuseIdentifier: cellIdentifier.heartCellId)
//        tableview.rowHeight = UITableViewAutomaticDimension
    }
    
    
    func cellExplain(index: Int, isExplain: Bool) {
  
        if isExplain {
            cellExplains.removeAll()
//            self.tableview.reloadRows(at: [IndexPath.init(row: index, section: 0)], with: .fade)
            cellExplains.insert(index)
        } else {
            cellExplains.remove(index)
        }
      
//        self.tableview.reloadRows(at: [IndexPath.init(row: index, section: 0)], with: .fade)
        self.tableview.reloadData()
        
    }
    
    
    var result = [Fqa]()
    func getData()  {
      
        self.showLoading()
        MenuService.getFqaList(offset: 0, completion: { (faqList) in
            self.stopLoading()
            self.result = faqList
            print("Oh Yeah  \(self.result.count)")
            self.tableview.reloadData()
          
            
        }) { (error) in
            
        }
        
    }
        
}

extension FqaViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result.count
    }
}

extension FqaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier.heartCellId, for: indexPath) as! FaqCell
        cell.delegate = self
        cell.tag = indexPath.row
        cell.bindingData(data:result, index:indexPath.row ,isExplain: cellExplains.contains(indexPath.row))
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(indexPath.row)
        
    }
    

}


//
//  SubmitViewController.swift
//  QClub
//
//  Created by Dreamup on 11/7/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class SubmitViewController: UIViewController {

    
    struct cellID {
        static let bottomCell = "bottomCell"
    }
    
    @IBOutlet var tbView: UITableView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

         setupUI()
    }
    
    var arrCell:[UITableViewCell] = []
    func setupUI(){
        
        tbView.delegate = self
        tbView.dataSource = self
        
        
        tbView.register(UINib.init(nibName: "SubmitTopTableViewCell", bundle: nil), forCellReuseIdentifier: cellID.bottomCell)
        
        let bottomCell = tbView.dequeueReusableCell(withIdentifier: cellID.bottomCell) as! SubmitTopTableViewCell
        
        
        
        arrCell = [bottomCell]
        
    }

    
    

}

extension SubmitViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return arrCell[indexPath.row]
    }

    
}







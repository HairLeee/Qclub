//
//  AboutQclubViewController.swift
//  QClub
//
//  Created by Dreamup on 11/8/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit


protocol changeTabDelegate {
    func changeTab()
}

class AboutQclubViewController: UIViewController {
    
    
    
    @IBOutlet var tbView: UITableView!
    var mChangeTabDelegate:changeTabDelegate?
    
    struct cellID {
        static let topCell = "topCell"
        static let midCell = "midCell"
        static let bottomCell = "bottomCell"
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    var arrCell:[UITableViewCell] = []
    
    func setupUI(){
        tbView.delegate = self
        tbView.dataSource = self
        
        tbView.register(UINib.init(nibName: "TopTableViewCell", bundle: nil), forCellReuseIdentifier: cellID.topCell)
        tbView.register(UINib.init(nibName: "MidAboutClubTableViewCell", bundle: nil), forCellReuseIdentifier: cellID.midCell)
        
         tbView.register(UINib.init(nibName: "BottomAboutClubTableViewCell", bundle: nil), forCellReuseIdentifier: cellID.bottomCell)
        
        
        
        let cellTop = tbView.dequeueReusableCell(withIdentifier: cellID.topCell) as! TopTableViewCell
        
        let cellMid = tbView.dequeueReusableCell(withIdentifier: cellID.midCell) as!MidAboutClubTableViewCell
        
         let cellBottom = tbView.dequeueReusableCell(withIdentifier: cellID.bottomCell) as!BottomAboutClubTableViewCell
        
        cellBottom.goToContact = {
            let charmVC = UIStoryboard.init(name: "Fqa", bundle: nil).instantiateViewController(withIdentifier: "FaqContactViewController") as! FaqContactViewController
            charmVC.isGoToContactViewController = true
            self.navigationController?.pushViewController(charmVC, animated: true)
        }
        
        arrCell = [cellTop,cellMid,cellBottom]
    }
    
    @IBAction func btnQclubAction(_ sender: Any) {
        
        mChangeTabDelegate?.changeTab()
        
        
        
    }
    
    
    @IBAction func btnFqaAction(_ sender: Any) {
        
//        let fqaVC = FqaViewController.init(nibName: "FqaViewController", bundle: nil)
        
    
        
    }
    
}

extension AboutQclubViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  arrCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        return arrCell[indexPath.row]
    }
    
    
    
}


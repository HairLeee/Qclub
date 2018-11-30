//
//  MyInfoModifyOneViewController.swift
//  QClub
//
//  Created by Dreamup on 10/25/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class MyInfoModifyOneViewController: UIViewController, protocolTextFieldChang, protocolCollectionViewChang {
    
    
    
    var modify1 = Modify1()
    var bottomCell:ModifyThreeTableViewCell? = nil
    func whenActionChange(typeOfTextField: Int, contentOfTextField: String) {
        
        print(" father value == \(typeOfTextField) \(contentOfTextField)")
        
        switch typeOfTextField {
        case 1:
            modify1.nickname = contentOfTextField
        case 2:
            modify1.gender = contentOfTextField
        case 3:
            modify1.locationDetail = Int(contentOfTextField)!
        case 4:
            modify1.locationEtc = contentOfTextField
        case 5:
            modify1.bloodDetail = Int(contentOfTextField)!
        case 6:
            modify1.height = Int(contentOfTextField)!
        case 7:
            modify1.bodyDetail = Int(contentOfTextField)!
        case 8:
            modify1.affiliatedSchool = contentOfTextField
        case 9:
            modify1.affiliatedCompany = contentOfTextField
        case 10:
            modify1.job = contentOfTextField
        case 11:
            modify1.relegionDetail = Int(contentOfTextField)!
            modify1.relegionEtc = "12"
        case 12:
            modify1.maritalStatus = contentOfTextField
        case 13:
            modify1.maritalStatus = contentOfTextField
        case 14:
            modify1.matchingTarget = contentOfTextField
        case 15:
            modify1.matchingTarget = contentOfTextField
        case 16:
            modify1.drinkingDetail = Int(contentOfTextField)!
        case 17:
            modify1.smokingDetail = Int(contentOfTextField)!
        case 100:
           updateModify()
            
        default:
            break
        }
        
        checkValidate()
    }
    
    func whenActionChange(styles: [Int]) {
        // 17
        modify1.styleDetails = styles
        print("~~~> \(styles)")
        checkValidate()
        
    }
    
    
    func checkValidate(){
        
        if modify1.nickname.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0  {
            bottomCell?.enableOkButtonOrNot(isEnable: false)
            return
        }
        
        if modify1.gender.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0  {
            bottomCell?.enableOkButtonOrNot(isEnable: false)
            return
        }
        
        if modify1.locationDetail == -1  {
            bottomCell?.enableOkButtonOrNot(isEnable: false)
            return
        }
        
        if modify1.bloodDetail == -1  {
            bottomCell?.enableOkButtonOrNot(isEnable: false)
            return
        }
        
        if modify1.height  == 0  {
            bottomCell?.enableOkButtonOrNot(isEnable: false)
            return
        }
        
        if modify1.bodyDetail  == -1  {
            bottomCell?.enableOkButtonOrNot(isEnable: false)
            return
        }
        
        if modify1.affiliatedSchool.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0  {
            bottomCell?.enableOkButtonOrNot(isEnable: false)
            return
        }
        
        if modify1.affiliatedCompany.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0  {
            bottomCell?.enableOkButtonOrNot(isEnable: false)
            return
        }
        
        if modify1.job.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0  {
            bottomCell?.enableOkButtonOrNot(isEnable: false)
            return
        }
        
        if modify1.relegionDetail  == -1 || modify1.relegionEtc.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0 {
            bottomCell?.enableOkButtonOrNot(isEnable: false)
            return
        }
        
        if modify1.maritalStatus.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0  {
            bottomCell?.enableOkButtonOrNot(isEnable: false)
            return
        }
        
        if modify1.maritalStatus == "R" && modify1.matchingTarget == "" {
            bottomCell?.enableOkButtonOrNot(isEnable: false)
            return
        }
        
        if modify1.drinkingDetail  == -1  {
            bottomCell?.enableOkButtonOrNot(isEnable: false)
            return
        }
        
        if modify1.smokingDetail  == -1  {
            bottomCell?.enableOkButtonOrNot(isEnable: false)
            return
        }
        
        if modify1.styleDetails?.count == 0 {
            bottomCell?.enableOkButtonOrNot(isEnable: false)
            return
        }
        
        
        bottomCell?.enableOkButtonOrNot(isEnable: true)
        
        
    }
    
    func updateModify(){
        self.showLoading()
        MenuService.putModify1Update(pModify1: modify1, completion: { (response) in
           self.stopLoading()
            self.navigationController?.popViewController(animated: true)
            
        }) { (error) in
          
             self.stopLoading()
            
        }

        
    }
    
    
    
    
    struct cellID {
        static let topCell = "topModifyCell"
        static let midCell = "midModifyCell"
        static let bottomCell = "bottomModifyCell"
    }
    
    @IBOutlet weak var tbView: UITableView!
    var arrCell:[UITableViewCell] = []
    
    
    @IBOutlet weak var navigationView: NavigationBarQClub!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        tbView.delegate = self
        tbView.dataSource = self
        
        tbView.register(UINib.init(nibName: "ModifyOne", bundle: nil), forCellReuseIdentifier: cellID.topCell)
        
        tbView.register(UINib.init(nibName: "ModifyTwoTableViewCell", bundle: nil), forCellReuseIdentifier: cellID.midCell)
        
        tbView.register(UINib.init(nibName: "ModifyThreeTableViewCell", bundle: nil), forCellReuseIdentifier: cellID.bottomCell)
        
        
        let topCell = tbView.dequeueReusableCell(withIdentifier: cellID.topCell) as! ModifyOne
        topCell.delegate = self
        
        let midCell = tbView.dequeueReusableCell(withIdentifier: cellID.midCell) as! ModifyTwoTableViewCell
        midCell.delegate = self
        
        
        
        bottomCell = tbView.dequeueReusableCell(withIdentifier: cellID.bottomCell) as! ModifyThreeTableViewCell
        bottomCell?.delegate = self
        
        arrCell = [topCell,midCell,bottomCell!]
        
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

extension MyInfoModifyOneViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = arrCell[indexPath.row] as! ModifyOne
            //            cell.bidingData()
            
        case 1:
            let cell = arrCell[indexPath.row] as! ModifyTwoTableViewCell
            //            cell.bidingData()
            
            
            
        default:
            
            print("Default")
            
        }
        
        return arrCell[indexPath.row]
    }
    
}

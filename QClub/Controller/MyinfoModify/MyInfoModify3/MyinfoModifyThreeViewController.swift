//
//  MyinfoModifyThreeViewController.swift
//  QClub
//
//  Created by Dreamup on 10/11/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class MyinfoModifyThreeViewController: BaseViewController, OnButtonClickListener, protocolTextFieldChang {
    
    
    
    
    
    @IBOutlet weak var navigationView: NavigationBarQClub!
    
    @IBOutlet weak var tbView: UITableView!
    var arrCell:[UITableViewCell] = []
    var words:String = ""
    var appearance:String = ""
    var inHoliday:String = ""
    var lookFor:String = ""
    
    struct cellIdentifier {
        static let MyInfor1CellId = "MyInfor3CellId"
        static let MyInfor2CellId = "MyInfor4CellId"
    }
    
    func OnButtonClickListener() {
        print("kakaka ~~ ")
        doUpdate()
    }
    
    func whenActionChange(typeOfTextField: Int, contentOfTextField: String) {
        
        print(" typeOfTextField \(typeOfTextField) \(contentOfTextField)")
        
        switch typeOfTextField {
            
        case 1:
            words = contentOfTextField
        case 2:
            appearance = contentOfTextField
        case 3:
            inHoliday = contentOfTextField
        case 4:
            lookFor = contentOfTextField
            
            
        default:
            break
        }
        
    }
    
    func doUpdate(){
        self.showLoading()
        MenuService.getModify3(words: words, appearance: appearance, inHoliday: inHoliday, lookFor: lookFor, completion: { (response) in
            
            let message = response.message as! String
            
            print(" Message == \(message)")
            self.stopLoading()
  
            let dialog = HoldingPopup.instanceFromNib(content: "수정이 완료되었습니다.", image: "ic_done.png")
            dialog.show()
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                dialog.hide()
                self.navigationController?.popViewController(animated: true)
                
            }
            
            
        }) { (error) in
            
            
            
            
        }
        
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbView.delegate = self
        tbView.dataSource = self
        
        //        tbView.register(UINib.init(nibName: "TopCell3", bundle: nil), forCellReuseIdentifier: cellIdentifier.MyInfor1CellId) // For xib
        tbView.register(UINib.init(nibName: "BottomCell3", bundle: nil), forCellReuseIdentifier: cellIdentifier.MyInfor2CellId) // For xib
        
        //        let topCell = tbView.dequeueReusableCell(withIdentifier: cellIdentifier.MyInfor1CellId) as! TopCellModify3  // Try to find .swift from .xib
        
        
        let bottomCell = tbView.dequeueReusableCell(withIdentifier: cellIdentifier.MyInfor2CellId) as! BottomCellModify3 // Try to find .swift from .xib
        bottomCell.onButtomClickListener = self
        bottomCell.delegate = self
        arrCell = [bottomCell]
        
        
        
        tbView.estimatedRowHeight = 100
        tbView.rowHeight = UITableViewAutomaticDimension
        tbView.allowsSelection = false
        tbView.reloadData()
    }
    
    override func configNavigationBar() {
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
            //            self.dismiss(animated: true, completion: nil)
        }
        navigationView.config(title: "내 정보 수정", image: "myinfo2_header_icon")
    }
    
    
    
}


extension MyinfoModifyThreeViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return arrCell[indexPath.row]
    }
    
    
}

extension MyinfoModifyThreeViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCell.count
    }
}


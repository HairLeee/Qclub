//
//  MyinfoModifyTwoViewController.swift
//  QClub
//
//  Created by Dreamup on 10/11/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit


protocol protocolTextFieldChang {
    func whenActionChange(typeOfTextField:Int, contentOfTextField:String)
}

protocol protocolCollectionViewChang {
    func whenActionChange(styles:[Int])
}

class MyinfoModifyTwoViewController: UIViewController, OnClickListener, protocolTextFieldChang {
    

    @IBOutlet weak var navigationView: NavigationBarQClub!
    
    @IBOutlet weak var tbView: UITableView!
    var arrCell:[UITableViewCell] = []
    var modify2 = Modify2()
    var mMember:Member?
    
    struct cellIdentifier {
        static let MyInfor1CellId = "MyInfor1CellId"
        static let MyInfor2CellId = "MyInfor2CellId"
    }
    
    
    func clickOkAction(){
        
        print("On Click Ok ACtion \(String(describing: modify2.annualIncome))")
        updateModify2()
        let alertQ = AlertQClub.instanceFromNib(content: "abc", image: "ic_store_popup")
        //        alertQ.show()
        alertQ.action1 = {
            
            
            
            //            [weak self] in
            //            guard let _self = self else{return}
            //            let modify2 =  _self.tbView.cellForRow(at: IndexPath.init(row: 0, section: 0)) as! TopCellModify2
            //            modify2.getData()
            
        }
        
    }
    
    func whenActionChange(typeOfTextField: Int, contentOfTextField: String) {
        // 7 Types
        print("Type = \(typeOfTextField) Content = \(contentOfTextField)")
        
       
        
        
        switch typeOfTextField {
        case 1:
            if contentOfTextField != "" {
                modify2.annualIncome = Int(contentOfTextField)!
            }
            
        case 2:
            modify2.propertyFlag = contentOfTextField
        case 3:
            modify2.carFlag = contentOfTextField
        case 4:
            modify2.personality = String(contentOfTextField)
        case 5:
            modify2.carModel = String(contentOfTextField) 
        case 6:
            modify2.travel = String(contentOfTextField)
        case 7:
            modify2.hobby = String(contentOfTextField)
            modify2.wishes = "Default"
        default:
            break
        }
        
        
         let currentBottomCell = tbView.cellForRow(at: IndexPath.init(row: 1, section: 0)) as! BottomCellModify2
        
        currentBottomCell.checkValidate(pMember: modify2)
        
    }
    
    func updateModify2(){
        
        
        self.showLoading()
        MenuService.getModify2(modify2: modify2, completion: { (response) in
            self.stopLoading()
        
            
            
            let dialog = HoldingPopup.instanceFromNib(content: "수정이 완료되었습니다.", image: "ic_done.png")
            dialog.show()
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                dialog.hide()
                self.navigationController?.popViewController(animated: true)
                
            }
            
            
            
            
            
        }) { (error) in
            self.stopLoading()
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("MyInfoModify2 Data = \(mMember?.carFlag) \(mMember?.propertyFlag)")
        
//        modify2.carFlag = (mMember?.carFlag)!
//        modify2.propertyFlag = (mMember?.propertyFlag)!
//        modify2.annualIncome = (mMember?.annualIncome)!
        
        
        configNavigationBar() 
        tbView.delegate = self
        tbView.dataSource = self
        
        tbView.register(UINib.init(nibName: "TopCellModify2", bundle: nil), forCellReuseIdentifier: cellIdentifier.MyInfor1CellId) // For xib
        tbView.register(UINib.init(nibName: "BottomCellModify2", bundle: nil), forCellReuseIdentifier: cellIdentifier.MyInfor2CellId) // For xib
        
        let topCell = tbView.dequeueReusableCell(withIdentifier: cellIdentifier.MyInfor1CellId) as! TopCellModify2  // Try to find .swift from .xib
        topCell.bidingData(pMember:mMember!)
        topCell.delegate = self
        
        
        let bottomCell = tbView.dequeueReusableCell(withIdentifier: cellIdentifier.MyInfor2CellId) as! BottomCellModify2 // Try to find .swift from .xib
        bottomCell.OnOkClickListener = self
        bottomCell.bidingData(pMember:mMember!)
        bottomCell.delegate = self
        
        arrCell = [topCell,bottomCell]
        
        
        
        tbView.estimatedRowHeight = 100
        tbView.rowHeight = UITableViewAutomaticDimension
        tbView.allowsSelection = false
    }
    
    func configNavigationBar() {
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
            //            self.dismiss(animated: true, completion: nil)
        }
        navigationView.config(title: "내 정보 수정", image: "myinfo2_header_icon")
    }
    
    
    
}


extension MyinfoModifyTwoViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        return arrCell[indexPath.row]
    }
    
    
}

extension MyinfoModifyTwoViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrCell.count
    }
}

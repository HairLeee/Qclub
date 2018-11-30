//
//  HoldingViewController.swift
//  QClub
//
//  Created by Dreamup on 9/29/17.
//  Copyright © 2017 Dream. All rights reserved.
//
//Page 143 in the Storyboard
import UIKit

class HoldingViewController: BaseViewController {
    
    
    
    
    @IBOutlet weak var lbDate: UILabel!
    
    @IBOutlet weak var navigationView: NavigationBarQClub!
    
    @IBOutlet var btnOk: UIButton!
    
    @IBOutlet var lbWarning: UILabel!
    var isRemoveOrRegis = false // false = Regis, true = Remove
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbWarning.isHidden = true
        getData()
    }
    
    func getData(){
        self.showLoading()
        MenuService.getHolding(completion: { (response) in
            
            let holding = response.data as! Holding
            
            self.lbDate.text = String("홀딩 신청 시 : ") + String(holding.holdingBeginDate) + String("~") + String(holding.holdingExpDate)
            self.stopLoading()
            
        }) { (error) in
            self.stopLoading()
            
        }
        
        
    }
    
    func updateLayout()  {
        
        
        
        
        
    }
    
    
    @IBAction func btnOk(_ sender: Any) {
        self.showLoading()
        
        if isRemoveOrRegis {
            
            MenuService.regisHolding(completion: { (resonse) in
               
                 self.btnOk.setTitle("홀딩 취소", for: .normal)
                self.stopLoading()
                self.isRemoveOrRegis = !self.isRemoveOrRegis
                
                let alertQ = HoldingPopup.instanceFromNib(content: "홀딩이 신청되었습니다", image: "holding_popup_icon.png")
                alertQ.show()
                
            }) { (error) in
                self.stopLoading()
            }
        } else {
            
            MenuService.removeHolding(completion: { (resonse) in
           
                self.btnOk.setTitle("홀딩 취소하기", for: .normal)
                self.stopLoading()
                self.isRemoveOrRegis = !self.isRemoveOrRegis
                
                let alertQ = HoldingPopup.instanceFromNib(content: "홀딩이 취소 되었습니다", image: "holding_popup_icon.png")
                        alertQ.show()
                
            }) { (error) in
                self.stopLoading()
            }
            
        }
        
        
        
        
        //        let alertQ = HoldingPopup.instanceFromNib(content: "~~", image: "holding_popup_icon.png")
        //        alertQ.show()
        
        
    }
    
    override func configNavigationBar() {
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
            //            self.dismiss(animated: true, completion: nil)
        }
        navigationView.config(title: "스토어", image: "store_header_icon")
    }
    
    
    
    
    
}

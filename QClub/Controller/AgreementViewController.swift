//
//  AgreementViewController.swift
//  QClub
//
//  Created by Dreamup on 10/3/17.
//  Copyright © 2017 Dream. All rights reserved.
//
//Page 146 in the Storyboard
import UIKit

class AgreementViewController: BaseViewController {
    
    
    
    
    @IBOutlet weak var navigationView: NavigationBarQClub!
    
    @IBOutlet weak var btnAgreementOutlet: UIButton!
    
    @IBOutlet weak var btnPrivacyOutlet: UIButton!
    
    @IBOutlet weak var wvAgreementAndPrivacy: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        getData(index: 1)
        
    }
    
    func getData(index:Int)  {
        self.showLoading()
        MenuService.getAgreementHtlm(inPrDetail: index, completion: { (response) in
            
            if let html:String = response.data as? String {
                print(html)
                self.setupDataForWebview(urlToLoad: html)
                self.stopLoading()
                
            }
            
        }) { (error) in
            
            self.stopLoading()
            
        }
        
    }
    
    
    
    
    @IBAction func btnAgreementAction(_ sender: Any) {
        
        changeColorOrTabBar(isAgreemtentOrPrivacy: true)
//        setupDataForWebview(urlToLoad: "https://ngoisao.net")
        getData(index:1)
    }
    
    @IBAction func btnPrivacyAction(_ sender: Any) {
        changeColorOrTabBar(isAgreemtentOrPrivacy: false)
//        setupDataForWebview(urlToLoad: "https://ngoisao.net")
        getData(index:2)
    }
    
    func  changeColorOrTabBar(isAgreemtentOrPrivacy: Bool) {
        if isAgreemtentOrPrivacy {
            btnAgreementOutlet.backgroundColor = UIColor.init(hexString: "#FFAA4F")
            btnAgreementOutlet.setTitleColor(UIColor.white, for: .normal)
            btnPrivacyOutlet.backgroundColor = UIColor.init(hexString: "#ebebeb")
            btnPrivacyOutlet.setTitleColor(UIColor.init(hexString: "#616060"), for: .normal)
            
        } else {
            btnPrivacyOutlet.backgroundColor = UIColor.init(hexString: "#FFAA4F")
            btnPrivacyOutlet.setTitleColor(UIColor.white, for: .normal)
            btnAgreementOutlet.backgroundColor = UIColor.init(hexString: "#ebebeb")
            btnAgreementOutlet.setTitleColor(UIColor.init(hexString: "#616060"), for: .normal)
            
        }
        
    }
    
    func setupDataForWebview(urlToLoad: String){
        
         wvAgreementAndPrivacy.loadHTMLString(urlToLoad, baseURL: nil)
        
//        if let url = URL(string:urlToLoad){
//            let request = URLRequest(url:url)
//            wvAgreementAndPrivacy.loadRequest(request)
//
//        }
        
    }
    
   override func configNavigationBar() {
        navigationView.backAction = {
            self.navigationController?.popViewController(animated: true)
            //            self.dismiss(animated: true, completion: nil)
        }
        navigationView.config(title: "이용약관/개인정보취급방침", image:"agreement_header_icon")
    }
    
}

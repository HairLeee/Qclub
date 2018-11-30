//
//  GroundChampionViewController.swift
//  QClub
//
//  Created by TuanNM on 10/17/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class GroundChampionViewController: BaseViewController{
    
    @IBOutlet weak var navigationBar: NavigationBarQClub!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBar.config(title: "이상형 챔피언배틀", image: "ic_cup.png")
        navigationBar.backAction = {
            self.navigationController?.popViewController(animated: true)
        }
    }

    var canChampion = false
    var championSegue = "championSegue"
    var battle:Battle!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return canChampion
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let groundStartVC = segue.destination as! GroundChampionStartViewController
        groundStartVC.battle = battle
    }
    
    @IBAction func championAction(_ sender: Any) {
        Utils.checkHeartIsEnough(viewController: self, numberOfHeartIsNeed: 20, completion: { (success, heart) in
            if success{
                self.showPaymentPopUp(mHeart: heart)
            }
        }) { (error) in
            print("checkHeartIsEnough error \(error)")
        }
    }
    
    func callServiceGetChampion(){
        GChampionService.getBattle(completion: { [weak self](response) in
            guard let _self = self else{return}
            guard let battle = response.data as? Battle else{return}
            _self.battle = battle
            _self.canChampion = true
            _self.performSegue(withIdentifier: _self.championSegue, sender: nil)
            _self.canChampion = false
        }) { (error) in
            self.view.makeToast("서버 오류", duration: 3, position: .center)
            print("getBattle error \(error)")
        }
    }
}

// popup
extension GroundChampionViewController{
    func showPaymentPopUp(mHeart:Int){
        let heartView = HeartView(nibName: "HeartView", bundle: nil)
        heartView.popupTitle = "이상형 챔피언배틀 시작"
        heartView.popupMessage = "이상형 챔피언배틀을 시작하기 위해서는\n하트 20개가 필요합니다. 계속하시겠습니까?"
        heartView.price = "20"
        heartView.myHeart = "\(mHeart)"
        heartView.buttonContent = "챔피언배틀 시작하기"
        
        self.addChildViewController(heartView)
        self.view.addSubview(heartView.view)
        
        heartView.callBackSelect = {
            [weak self] in
            guard let _self = self else{return}
            _self.callServiceGetChampion()
        }
    }
}

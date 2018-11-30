//
//  Join4ViewModel.swift
//  QClub
//
//  Created by SMR on 11/2/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class Join4ViewModel: NSObject {
    var userJoin : UserJoin?
    var relegionInfoList = [MasterDataObject]()
    var drinkInfoList = [MasterDataObject]()
    
    func getRelegionInfoList(complete : @escaping(_ data : [String]) -> ()) {
        AuthService.getMasterData(masterSeq: Constants.MasterCode.Relegion, completion: { (response) in
            if let data = response.data as? [MasterDataObject] {
                self.relegionInfoList = data
                complete(data.map{$0.detailName ?? ""})
            }
        }) { (error) in
        }
    }
    
    func getDrinkInfoList(complete : @escaping(_ data : [String]) -> ()) {
        AuthService.getMasterData(masterSeq: Constants.MasterCode.Drink, completion: { (response) in
            if let data = response.data as? [MasterDataObject] {
                self.drinkInfoList = data
                complete(data.map{$0.detailName ?? ""})
            }
        }) { (error) in
        }
    }
    
    func join5VC() -> Join5ViewController {
        return UIStoryboard.init(name: "Join", bundle: nil).instantiateViewController(withIdentifier: "Join5ViewController") as! Join5ViewController
    }
}

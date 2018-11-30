//
//  Join2ViewModel.swift
//  QClub
//
//  Created by SMR on 11/2/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class Join2ViewModel: NSObject {
    var userJoin : UserJoin?
    var locationInfoList = [MasterDataObject]()
    var bloodInfoList = [MasterDataObject]()
    var bodyInfoList = [MasterDataObject]()
    
    func setUserJoin(userJoin : UserJoin) {
        self.userJoin = userJoin
    }
    
    func getLocationInfoList(complete: @escaping(_ data: [String]) -> ()) {
        AuthService.getMasterData(masterSeq: Constants.MasterCode.Location, completion: { (response) in
            if let data = response.data as? [MasterDataObject] {
                self.locationInfoList = data
                complete(data.map{$0.detailName ?? ""})
            }
        }) { (error) in
            
        }
    }
    
    func getBloodInfoList(complete: @escaping(_ data: [String]) -> ()) {
        AuthService.getMasterData(masterSeq: Constants.MasterCode.Blood, completion: { (response) in
            if let data = response.data as? [MasterDataObject] {
                self.bloodInfoList = data
                 complete(data.map{$0.detailName ?? ""})
            }
        }) { (error) in
            
        }
    }
    
    func getBodyInfoList(complete: @escaping(_ data: [String]) -> ()) {
        AuthService.getMasterData(masterSeq: Constants.MasterCode.Body, completion: { (response) in
            if let data = response.data as? [MasterDataObject] {
                self.bodyInfoList = data
                 complete(data.map{$0.detailName ?? ""})
            }
        }) { (error) in
            
        }
    }
    
    func join3VC() -> Join3ViewController {
        return UIStoryboard.init(name: "Join", bundle: nil).instantiateViewController(withIdentifier: "Join3ViewController") as! Join3ViewController
    }
}

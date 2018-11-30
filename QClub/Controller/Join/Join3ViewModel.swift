//
//  Join3ViewModel.swift
//  QClub
//
//  Created by SMR on 11/2/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class Join3ViewModel: NSObject {

    var userJoin : UserJoin?
    
    var selectedCells = Set<Int>()
    
    var data = [MasterDataObject]()
    
    
    func getStylesInfoList(complete : @escaping() -> ()) {
        
        AuthService.getMasterData(masterSeq: Constants.MasterCode.Style, completion: { (response) in
            if let data = response.data as? [MasterDataObject] {
                self.data = data
                complete()
            }
        }) { (error) in
            complete()
        }
    }
    
    func join4VC() -> Join4ViewController {
        let join4 = UIStoryboard.init(name: "Join", bundle: nil).instantiateViewController(withIdentifier: "Join4ViewController") as! Join4ViewController
        makeDataForUserObject()
        join4.viewModel.userJoin = userJoin
        return join4
    }
    
    func makeDataForUserObject() {
        userJoin?.styles = self.selectedCells.map{self.data[$0].detailSeq!}
    }
    
    func titleForCell (indexPath: IndexPath) -> String {
        return data[indexPath.row].detailName ?? ""
    }
    
    func indexPathIsSelected(indexPath: IndexPath) -> Bool {
        return selectedCells.contains(indexPath.row)
    }
    
    func nuberOfItem() -> Int {
        return data.count
    }
}

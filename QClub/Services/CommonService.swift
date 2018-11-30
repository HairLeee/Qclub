//
//  CommonService.swift
//  QClub
//
//  Created by TuanNM on 11/10/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import Foundation
import ObjectMapper

class CommonService{
    
    /*
     Get battleSeq
     */
    class func getRoadAddress(keyword:String,completion : @escaping (_ response: AnyObject) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let params = ["keyword":keyword,"currentPage":0] as [String : Any]
        
        ServiceFactory.get(url: Constants.API.GetRoadAddress, parameters: params) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = response.result.value as? [String:AnyObject]{
                    if let address = serverResponse["addr"] as? [String]{
                        completion(address as AnyObject)
                        return
                    }
                }
                let error = NSError(domain: "", code: response.response?.statusCode ?? 0, userInfo: nil)
                fail(error)

            } else {
                if let error = response.result.error {
                    fail(error)
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: nil)
                    fail(error)
                }
            }
        }
    }
}

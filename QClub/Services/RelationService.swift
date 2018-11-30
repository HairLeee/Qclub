//
//  RelationService.swift
//  QClub
//
//  Created by SMR on 10/23/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class RelationService {
    class func getHeartCount(completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        ServiceFactory.get(url: Constants.API.GetHeartCount, parameters: nil) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        completion(serverResponse)
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: nil)
                        fail(error)
                    }
                }
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
    
    class func candySearch(locationIndex: Int, ageRange: Int, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "locationDetail": "\(locationIndex)",
            "ageRange": "\(ageRange)"
            ]
        
        ServiceFactory.get(url: Constants.API.CandySearch, parameters: parameters) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        if let dataJson = serverResponse.data as? [[String : Any]]  {
                            let masterObjects : [RelationMemberSearch] = Mapper<RelationMemberSearch>().mapArray(JSONArray: dataJson)
                            serverResponse.data = masterObjects as AnyObject
                            completion(serverResponse)
                        } else {
                            let error = NSError(domain: "", code: 0, userInfo: nil)
                            fail(error)
                        }
                    } else {
                        let error = NSError(domain: "", code: serverResponse.code ?? 0, userInfo: nil)
                        fail(error)
                    }
                }
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

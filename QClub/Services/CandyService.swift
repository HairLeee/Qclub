//
//  CandyService.swift
//  QClub
//
//  Created by SMR on 10/30/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class CandyService {
    class func getStatus(completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        ServiceFactory.get(url: Constants.API.GetCandyStatus, parameters: nil) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        if let status = Mapper<CandyStatusModel>().map(JSONObject: serverResponse.data) {
                            serverResponse.data = status
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
    
    class func candySearch(locationIndex: Int, ageRange: Int, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "locationDetail": "\(locationIndex)",
            "age": "\(ageRange*10)"
        ]
        
        ServiceFactory.get(url: Constants.API.GetCandySearch, parameters: parameters) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        if let dataJson = serverResponse.data as? [[String : Any]]  {
                            let candyObjects : [CandyMemberModel] = Mapper<CandyMemberModel>().mapArray(JSONArray: dataJson)
                            serverResponse.data = candyObjects as AnyObject
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
    
    class func candylist(completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        ServiceFactory.get(url: Constants.API.GetCandyList, parameters: nil) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        if let dataJson = serverResponse.data as? [[String : Any]]  {
                            let candyObjects : [CandyMemberModel] = Mapper<CandyMemberModel>().mapArray(JSONArray: dataJson)
                            serverResponse.data = candyObjects as AnyObject
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
    
    class func candyRequest(candyUserSeq: Int ,completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        let parameters = [
            "candyUserSeq": "\(candyUserSeq)"
        ]
        
        ServiceFactory.get(url: Constants.API.GetCandyRequest, parameters: parameters) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        completion(serverResponse)
                    } else {
                        let error = NSError(domain: serverResponse.message ?? "", code: serverResponse.code ?? 0, userInfo: nil)
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
    
    class func candyStatusWait(introduce: String ,completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        let parameters = [
            "introduce": introduce
        ]
        
        ServiceFactory.get(url: Constants.API.GetCandyStatusWait, parameters: parameters) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        completion(serverResponse)
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
    
    class func candyViewProfile(candyListSeq: Int ,completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        let parameters = [
            "candyListSeq": "\(candyListSeq)"
        ]
        
        ServiceFactory.get(url: Constants.API.GetCandyViewProfile, parameters: parameters) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    completion(serverResponse)
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
    
    class func candyResponse(candyListSeq: Int ,completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        let parameters = [
            "candyListSeq": "\(candyListSeq)"
        ]
        
        ServiceFactory.get(url: Constants.API.GetCandyResponse, parameters: parameters) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    completion(serverResponse)
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
    
    class func candyCancel(completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        ServiceFactory.get(url: Constants.API.GetCandyCancel, parameters: nil) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                            completion(serverResponse)
                        } else {
                            let error = NSError(domain: serverResponse.message ?? "", code:  serverResponse.code ?? 0, userInfo: nil)
                            fail(error)
                        }
                    } else {
                        let error = NSError(domain:  "", code:  0, userInfo: nil)
                        fail(error)
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


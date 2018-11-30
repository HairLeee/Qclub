//
//  ProfileService.swift
//  QClub
//
//  Created by SMR on 10/16/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class ProfileService {

    class func getProfileBasic(userSeq: Int, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "userSeq": userSeq
        ]
        
        ServiceFactory.get(url: Constants.API.GetProfileBasic, parameters: parameters) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        let member : Member = Mapper<Member>().map(JSON: serverResponse.data as! [String : Any])!
                        serverResponse.data = member as AnyObject
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
    
    class func getProfileAttractive(userSeq: Int, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "userSeq": userSeq
        ]
        
        ServiceFactory.get(url: Constants.API.ProfileAttractive, parameters: parameters) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        let member : AttractiveObject = Mapper<AttractiveObject>().map(JSON: serverResponse.data as! [String : Any])!
                        serverResponse.data = member as AnyObject
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
    
    class func getMyAttractive(completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        ServiceFactory.get(url: Constants.API.MyAttractive, parameters: nil) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        let member : AttractiveObject = Mapper<AttractiveObject>().map(JSON: serverResponse.data as! [String : Any])!
                        serverResponse.data = member as AnyObject
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
    
    class func getCompletionScore(userSeq: Int, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {

        let parameters = [
            "userSeq": userSeq
            ]
        
        ServiceFactory.get(url: Constants.API.ProfileCompletionScore, parameters: parameters) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        let cObject : CompletionObject = Mapper<CompletionObject>().map(JSON: serverResponse.data as! [String : Any])!
                        serverResponse.data = cObject as AnyObject
                        completion(serverResponse)
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: nil)
                        fail(error)
                    }
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: nil)
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
    
    class func postCompletionScore(userSeq: Int, score: Int, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "userSeq": userSeq,
            "score": score,
        ]
        
        ServiceFactory.post(url: Constants.API.ProfileCompletionScore, parameters: parameters) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    completion(serverResponse)
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: nil)
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
    
    class func getLikAbility(userSeq: Int, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "userSeq": userSeq
        ]
        
        ServiceFactory.get(url: Constants.API.ProfileLikAbility, parameters: parameters) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        let likability : LikabilityObject = Mapper<LikabilityObject>().map(JSON: serverResponse.data as! [String : Any])!
                        serverResponse.data = likability as AnyObject
                        completion(serverResponse)
                    } else {
                        let error = NSError(domain: "", code: 0, userInfo: nil)
                        fail(error)
                    }
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: nil)
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
    
    class func postLikAbility(userSeq: Int, likAbility: LikabilityObject, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        var url = Constants.API.ProfileLikAbility
        url += "?userSeq=\(userSeq)&score=\(likAbility.score!)&impressionMaster=\(likAbility.impression![0].impressionMaster!)"
        for impresion in likAbility.impression! {
            url += "&impressionDetails=\(impresion.impressionDetail!)"
        }
        
        ServiceFactory.post(url: url, parameters: nil) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    completion(serverResponse)
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: nil)
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
    
    class func postAdvice(userSeq: Int, adviceIndexs: [Int], completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        var url = Constants.API.ProfileAdvice
        url += "?userSeq=\(userSeq)"
        for adviceIndex in adviceIndexs {
            url += "&adviceDetails=\(adviceIndex + 1)"
        }
        
        ServiceFactory.post(url: url, parameters: nil) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    completion(serverResponse)
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: nil)
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
    
    class func getAdvice(userSeq: Int, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "userSeq": userSeq
        ]
        
        ServiceFactory.get(url: Constants.API.ProfileAdvice, parameters: parameters) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                        completion(serverResponse)
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: nil)
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

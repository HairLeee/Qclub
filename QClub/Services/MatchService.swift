//
//  MatchService.swift
//  QClub
//
//  Created by SMR on 10/16/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class MatchService {

    class func getTodayList(completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        ServiceFactory.get(url: Constants.API.GetMatchTodayList, parameters: nil) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        var result = [UserMatchInfo]()
                        if let tempArr = serverResponse.data as! Array<AnyObject>? {
                            for entry in tempArr {
                                let model : UserMatchInfo = Mapper<UserMatchInfo>().map(JSON: entry as! [String : Any])!
                                result.append(model)
                            }
                        }
                        serverResponse.data = result as AnyObject
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
    
    class func getCustomizedList(completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        ServiceFactory.get(url: Constants.API.GetMatchCustomizedList, parameters: nil) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        var result = [UserMatchInfo]()
                        if let tempArr = serverResponse.data as! Array<AnyObject>? {
                            for entry in tempArr {
                                let model : UserMatchInfo = Mapper<UserMatchInfo>().map(JSON: entry as! [String : Any])!
                                result.append(model)
                            }
                        }
                        serverResponse.data = result as AnyObject
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
    
    class func getTodayHistory(completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        ServiceFactory.get(url: Constants.API.GetMatchTodayHistory, parameters: nil) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        if let dataJson = serverResponse.data as? [[String : Any]]  {
                            let userMatchInfos : [UserMatchInfo] = Mapper<UserMatchInfo>().mapArray(JSONArray: dataJson)
                            serverResponse.data = userMatchInfos as AnyObject
                            completion(serverResponse)
                        } else {
                            let error = NSError(domain: "", code: 0, userInfo: nil)
                            fail(error)
                        }
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
    
    class func getTodayMore(completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        ServiceFactory.get(url: Constants.API.GetTodayMore, parameters: nil) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        var result = [UserMatchInfo]()
                        if let tempArr = serverResponse.data as! Array<AnyObject>? {
                            for entry in tempArr {
                                let model : UserMatchInfo = Mapper<UserMatchInfo>().map(JSON: entry as! [String : Any])!
                                result.append(model)
                            }
                        }
                        serverResponse.data = result as AnyObject
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
    
    class func getSpecialList(completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        ServiceFactory.get(url: Constants.API.GetMatchSpecialList, parameters: nil) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        if let dataJson = serverResponse.data as? [[String : Any]]  {
                            let objects : [SpecialMember] = Mapper<SpecialMember>().mapArray(JSONArray: dataJson)
                            serverResponse.data = objects as AnyObject
                            completion(serverResponse)
                        } else {
                            let error = NSError(domain: serverResponse.message ?? "", code: serverResponse.code ?? 0, userInfo: nil)
                            fail(error)
                        }
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
    
    class func getSpecialChoice(userSeq: Int , completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "matchSpecialSeq": userSeq
        ]
        
        ServiceFactory.get(url: Constants.API.GetMatchSpecialChoice, parameters: parameters) { response in
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
    
    class func getTodayChoice(userSeq: Int , completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "matchTodaySeq": userSeq
        ]
        
        ServiceFactory.get(url: Constants.API.GetMatchTodayChoice, parameters: parameters) { response in
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
    
    class func getTodayChoiceFree(userSeq: Int , completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "matchTodaySeq": userSeq
        ]
        
        ServiceFactory.get(url: Constants.API.GetMatchTodayChoiceFree, parameters: parameters) { response in
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
    

    class func getFromMe(completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        ServiceFactory.get(url: Constants.API.GetMatchFromMe, parameters: nil) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        var result = [UserMatchInfo]()
                        if let tempArr = serverResponse.data as! Array<AnyObject>? {
                            for entry in tempArr {
                                let model : UserMatchInfo = Mapper<UserMatchInfo>().map(JSON: entry as! [String : Any])!
                                result.append(model)
                            }
                        }
                        serverResponse.data = result as AnyObject
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
    
    class func getToMe(completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        ServiceFactory.get(url: Constants.API.GetMatchToMe, parameters: nil) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        var result = [UserMatchInfo]()
                        if let tempArr = serverResponse.data as! Array<AnyObject>? {
                            for entry in tempArr {
                                let model : UserMatchInfo = Mapper<UserMatchInfo>().map(JSON: entry as! [String : Any])!
                                result.append(model)
                            }
                        }
                        serverResponse.data = result as AnyObject
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
    
    class func deleteFavorite(interestMatchSeq: Int, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "interestMatchSeq": interestMatchSeq
        ]
        
        ServiceFactory.get(url: Constants.API.DeleteFavorite, parameters: parameters) { response in
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
    
    class func responseSpecial(matchSpecialSeq: Int, response: Bool, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "matchSpecialSeq": matchSpecialSeq,
            "response": response ? "Y" : "N",
            "pushSendYN": "Y"
            ] as [String : Any]
        
        ServiceFactory.get(url: Constants.API.ResponseRequestRelationShip, parameters: parameters) { response in
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
    
    class func registSpecialRelationship(specialMatchTargetUserSeq: Int, alreadyPaied: Bool, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "specialMatchTargetUserSeq": specialMatchTargetUserSeq,
            "alreadyPaied": alreadyPaied
            ] as [String : Any]
        
        ServiceFactory.get(url: Constants.API.GetMatchSpecialRegist, parameters: parameters) { response in
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
    
    class func getAboveQ1(completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        ServiceFactory.get(url: Constants.API.GetAboveQ1, parameters: nil) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        if let status = Mapper<Member>().map(JSONObject: serverResponse.data) {
                            serverResponse.data = status
                            completion(serverResponse)
                        } else {
                            let error = NSError(domain: serverResponse.message ?? "", code: 0, userInfo: nil)
                            fail(error)
                        }
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
    
    class func getAboveCharm20(completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        ServiceFactory.get(url: Constants.API.GetAboveCharm20, parameters: nil) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        if let status = Mapper<Member>().map(JSONObject: serverResponse.data) {
                            serverResponse.data = status
                            completion(serverResponse)
                        } else {
                            let error = NSError(domain: serverResponse.message ?? "", code: 0, userInfo: nil)
                            fail(error)
                        }
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
    
    class func getInterestChoice(interestMatchSeq: Int,completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "interestMatchSeq": interestMatchSeq
            ]
        
        ServiceFactory.get(url: Constants.API.InteresterChoice, parameters: parameters) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        completion(serverResponse)
                    } else {
                        let error = NSError(domain: serverResponse.message ?? "", code: serverResponse.code ?? 0, userInfo: nil)
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
    
    class func getTodayHistoryChoice(matchTodaySeq: Int,completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "matchTodaySeq": matchTodaySeq
        ]
        
        ServiceFactory.get(url: Constants.API.TodayHistoryChoice, parameters: parameters) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        completion(serverResponse)
                    } else {
                        let error = NSError(domain: serverResponse.message ?? "", code: serverResponse.code ?? 0, userInfo: nil)
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
}

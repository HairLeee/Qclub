//
//  GChampionService.swift
//  QClub
//
//  Created by TuanNM on 11/9/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import Foundation
import ObjectMapper

class GChampionService{
    
    /*
     Get battleSeq
     */
    class func getBattle(completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        ServiceFactory.get(url: Constants.API.GroundBattleStart, parameters: nil) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0, let data = serverResponse.data as? [String:Any]{
                        let battle : Battle = Mapper<Battle>().map(JSON: data)!
                        serverResponse.data = battle as AnyObject
                        completion(serverResponse)
                    } else {
                        let error = NSError(domain: "\(String(describing: serverResponse.message))", code: serverResponse.code ?? 0, userInfo: nil)
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
    
    class func getBattleNext(battleSeq:Int,winUserSeq:Int,loseUserSeq:Int,completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        var params : [String : AnyObject] = [:]
        params["battleSeq"] = battleSeq as AnyObject
        params["winUserSeq"] = winUserSeq as AnyObject
        params["loseUserSeq"] = loseUserSeq as AnyObject
        
        ServiceFactory.get(url: Constants.API.GroundBattleNext, parameters: params) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0, let data = serverResponse.data as? [String:Any]{
                        
                        var mapData :[String : Any] =  [:]
                        
                        if let battleInfo = data["status"] as? [String:Any]{
                            mapData = battleInfo
                        }
                        
                        if let user1 = data["user1"] as? [String:Any]{
                            mapData["user1"] = user1
                        }
                        
                        if let user2 = data["user2"] as? [String:Any]{
                            mapData["user2"] = user2
                        }
 
                        let battle : Battle = Mapper<Battle>().map(JSON: mapData)!
                        serverResponse.data = battle as AnyObject
                        completion(serverResponse)
                    } else {
                        completion(serverResponse)
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
    
    class func getBattlePayInfo(battleSeq:Int,rank:Int,completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        var params : [String : AnyObject] = [:]
        params["battleSeq"] = battleSeq as AnyObject
        params["rank"] = rank as AnyObject
        
        ServiceFactory.get(url: Constants.API.GroundBattlePayInfo, parameters: params) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0, let data = serverResponse.data as? [String:Any]{
                        let battle : Battle = Mapper<Battle>().map(JSON: data)!
                        serverResponse.data = battle as AnyObject
                        completion(serverResponse)
                    } else {
                        completion(serverResponse)
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
    
    class func getBattleInfo(completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        ServiceFactory.get(url: Constants.API.GroundBattleInfo, parameters: nil) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0, let data = serverResponse.data as? [String:Any]{
                        let battle : Battle = Mapper<Battle>().map(JSON: data)!
                        serverResponse.data = battle as AnyObject
                        completion(serverResponse)
                    } else {
                        let error = NSError(domain: "\(String(describing: serverResponse.message))", code: serverResponse.code ?? 0, userInfo: nil)
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

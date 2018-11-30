//
//  GIntroduceService.swift
//  QClub
//
//  Created by TuanNM on 11/7/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import Foundation
import ObjectMapper

class GIntroduceService{
    
    /*
     Get my information
     */
    class func getIntroduceMine(completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        ServiceFactory.get(url: Constants.API.GetIntroduceMine, parameters: nil) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        let member : GIMember = Mapper<GIMember>().map(JSON: serverResponse.data as! [String : Any])!
                        serverResponse.data = member as AnyObject
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
    
    /*
     Get new friend list
     */
    class func getIntroduceList(offset:Int,completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let params = ["offset":offset]
        
        ServiceFactory.get(url: Constants.API.GetIntroduceList, parameters: params) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        if let dataJson = serverResponse.data as? [[String : Any]]  {
                            let members : [GIMember] = Mapper<GIMember>().mapArray(JSONArray: dataJson)
                            serverResponse.data = members as AnyObject
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
    
    /*
     Post new comment to friend
     */
    class func postComment(content:String,introduceSeq:Int,completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let param = ["review":content,"introduceSeq":introduceSeq] as [String : Any]
        ServiceFactory.post(url: Constants.API.IntroduceComment, parameters: param) { (response) in
            if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                completion(serverResponse)
            }else{
                if let error =  response.result.error{
                    fail(error)
                }
            }
        }
    }
    
    /*
     Post yourself introduce
     */
    class func postIntroduce(content:String,completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (NSError) -> Void) -> Void {
        let param = ["introduce":content]
        
        ServiceFactory.post(url: Constants.API.PostIntroduceMine, parameters: param) { (response) in
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
                    fail(error as NSError)
                } else {
                    let error = NSError(domain: "", code: 0, userInfo: nil)
                    fail(error)
                }
            }
        }
    }
    
    /*
     Update yourself introduce
     */
    class func updateIntroduce(content:String,completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
  
        let url = Constants.API.PostIntroduceMine + "?introduce=\(content)"
        ServiceFactory.put(url: url, parameters: nil) { (response) in
            if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                completion(serverResponse)
            }else{
                if let error =  response.result.error{
                    fail(error)
                }
            }
        }
    }
    
    /*
     Get a list of friends who have commented
     */
    class func getFriendsComment(completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        ServiceFactory.get(url: Constants.API.IntroduceComment, parameters: nil) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        if let dataJson = serverResponse.data as? [[String : Any]]  {
                            let members : [GIMember] = Mapper<GIMember>().mapArray(JSONArray: dataJson)
                            serverResponse.data = members as AnyObject
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


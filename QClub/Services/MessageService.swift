//
//  MessageService.swift
//  QClub
//
//  Created by SMR on 11/8/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class MessageService {
    class func sendMessageUser(userSeq: Int,message: String, alreadyPaid: Bool, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "targetUserSeq": "\(userSeq)",
            "message": message,
            "alreadyPaid": alreadyPaid,
            ] as [String : Any]
        
        ServiceFactory.get(url: Constants.API.SendMessage, parameters: parameters) { response in
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
    
    class func getAllLetter(completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        ServiceFactory.get(url: Constants.API.GetAllMessage, parameters: nil) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if let dataJson = serverResponse.data as? [[String : Any]]  {
                        let letters : [LetterUserObject] = Mapper<LetterUserObject>().mapArray(JSONArray: dataJson)
                        serverResponse.data = letters as AnyObject
                        (UIApplication.shared.delegate as! AppDelegate).newLetters = letters
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
    
    class func deleteLetter(messageSeq: Int, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "messageSeq": "\(messageSeq)"
            ]
        
        ServiceFactory.get(url: Constants.API.DeleteMessage, parameters: parameters) { response in
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
    
    class func viewMessage(targetUserSeq: Int, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "targetUserSeq": "\(targetUserSeq)"
        ]
        
        ServiceFactory.get(url: Constants.API.ViewMessage, parameters: parameters) { response in
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
    
    
    class func getNewMessageStatus(completion : @escaping (_ isNewMessage: Bool,_ isNewNotification: Bool) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        ServiceFactory.get(url: Constants.API.GetNewMessageStatus, parameters: nil) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    
                    var isNewMessage = false
                    var isNewNotification = false
                    
                    if let data = serverResponse.data as? [String : Any]{
                        if let newMessage = data["newMessage"] as? String{
                            if newMessage == "NEW"{
                                isNewMessage = true
                            }
                        }
                        
                        if let notification = data["newNotification"] as? String{
                            if notification == "NEW"{
                                isNewNotification = true
                            }
                        }
                        
                    }
                    completion(isNewMessage,isNewNotification)
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
    
    
    class func getLetterStatus(targetUserSeq:Int,completion : @escaping (_ response: MessageStatus) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let param = ["targetUserSeq":targetUserSeq]
        
        ServiceFactory.get(url: Constants.API.GetMessageStatus, parameters: param) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        var status:MessageStatus = .none
                        if let data = serverResponse.data as? [String:Any]{
                            if let messageStatus = data["messageStatus"] as? String{
                                switch messageStatus.uppercased(){
                                case "R" :
                                    status = MessageStatus.receiveFavoriteLetter
                                    break
                                case "S" :
                                    status = MessageStatus.sendFavoriteLetter
                                    break
                                case "A" :
                                    status = MessageStatus.talk
                                    break
                                default:
                                    break
                                }
                                completion(status)
                            } else {
                                let error = NSError(domain: serverResponse.message ?? "", code: serverResponse.code ?? 1000, userInfo: nil)
                                fail(error)
                            }
                        } else {
                            completion(status)
                        }
                    }else{
                        let error = NSError(domain: serverResponse.message ?? "", code: serverResponse.code ?? 1000, userInfo: nil)
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
    
    class func getLastSentMessage(targetUserSeq:Int,completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let param = ["targetUserSeq":targetUserSeq]
        
        ServiceFactory.get(url: Constants.API.GetLastSentMessage, parameters: param) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        if let dataJson = serverResponse.data as? [String : Any]  {
                            let candyObjects : LetterUserObject = Mapper<LetterUserObject>().map(JSON: dataJson)!
                            serverResponse.data = candyObjects as AnyObject
                            completion(serverResponse)
                        } else {
                            let error = NSError(domain: serverResponse.message ?? "", code: 0, userInfo: nil)
                            fail(error)
                        }
                    }else{
                        let error = NSError(domain: serverResponse.message ?? "", code: serverResponse.code ?? 1000, userInfo: nil)
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

//
//  ItemService.swift
//  QClub
//
//  Created by SMR on 11/17/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper
import Alamofire

class ItemService {

    class func getItemRecent(offset:Int, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let param = ["offset":offset]
        
        ServiceFactory.get(url: Constants.API.GetItemRecent, parameters: param) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        if let dataJson = serverResponse.data as? [[String : Any]]  {
                            let items : [ItemObject] = Mapper<ItemObject>().mapArray(JSONArray: dataJson)
                            serverResponse.data = items as AnyObject
                            completion(serverResponse)
                        } else {
                            let error = NSError(domain: "\(String(describing: serverResponse.message))", code: serverResponse.code ?? 0, userInfo: nil)
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
    
    class func getMyItems(offset:Int, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let param = ["offset":offset]
        
        ServiceFactory.get(url: Constants.API.GetMyItem, parameters: param) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        if let dataJson = serverResponse.data as? [[String : Any]]  {
                            let items : [ItemObject] = Mapper<ItemObject>().mapArray(JSONArray: dataJson)
                            serverResponse.data = items as AnyObject
                            completion(serverResponse)
                        } else {
                            let error = NSError(domain: "\(String(describing: serverResponse.message))", code: serverResponse.code ?? 0, userInfo: nil)
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
    
    class func geItemDetail(itItemSeq:Int, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let param = ["itItemSeq":itItemSeq]
        
        ServiceFactory.get(url: Constants.API.GetItemDetail, parameters: param) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        if let dataJson = serverResponse.data as? [String : Any]  {
                            let items : ItemDetailObject = Mapper<ItemDetailObject>().map(JSONObject: dataJson)!
                            serverResponse.data = items as AnyObject
                            completion(serverResponse)
                        } else {
                            let error = NSError(domain: "\(String(describing: serverResponse.message))", code: serverResponse.code ?? 0, userInfo: nil)
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
    
    class func likeItem(itItemSeq:Int, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let param = ["itItemSeq":itItemSeq]
        
        ServiceFactory.post(url: Constants.API.LikeItem, parameters: param) { response in
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
    
    class func unLikeItem(itItemSeq:Int, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let param = ["itItemSeq":itItemSeq]
        
        ServiceFactory.delete(url: Constants.API.LikeItem, parameters: param) { response in
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
    
    class func uploadItem(title:String, items: [Item], completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        var url = Constants.API.PostItem + "?" + "title=\(title)"

        for item in items {
            url += "&descriptions=\(item.description ?? "")"
        }
        
        let header = [Constants.Parameter.Accept : Constants.Parameter.ApplicationJson,
                      Constants.Parameter.ContentType : Constants.Parameter.MultiPartFormData]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                for item in items {
                    if let data = item.data {
                        multipartFormData.append(UIImagePNGRepresentation(data)!, withName: "itItemPictures", fileName: "image\(String(describing: item.description)).jpg", mimeType: "image/jpeg")
                    }
                }
        },
            to: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
            method: .post,
            headers : header,
            encodingCompletion: { encodingResult in
                
                switch encodingResult {
                    
                case .success(let upload, _, _):
                    upload.responseJSON(completionHandler: { (response) in
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
                    })
                    upload.responseString(completionHandler: { (response) in
                        print(response)
                    })
                        .uploadProgress { progress in
                    }
                    return
                case .failure(let encodingError):
                    fail(encodingError)
                    debugPrint(encodingError)
                }
                
        })
        
        
    }
}

//
//  GFoodService.swift
//  QClub
//
//  Created by TuanNM on 11/9/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class GFoodService{
    
    class func unLikeRestaurantById(tastySeq:Int,completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let param = ["tastySeq":tastySeq]
        
        ServiceFactory.delete(url: Constants.API.GroundRestaurantLike, parameters: param) { response in
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
    
    class func likeRestaurantById(tastySeq:Int,completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let param = ["tastySeq":tastySeq]
        
        ServiceFactory.post(url: Constants.API.GroundRestaurantLike, parameters: param) { response in
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
    
    
    
    /*
     Get restaurant by id
     */
    class func getRestaurantById(tastySeq:Int,completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let param = ["tastySeq":tastySeq]
        
        ServiceFactory.get(url: Constants.API.GroundRestaurant, parameters: param) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        
                        let restaurant : GRestaurant = Mapper<GRestaurant>().map(JSON: serverResponse.data as! [String : Any])!
                        serverResponse.data = restaurant as AnyObject
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
     Get recent restaurant
     */
    class func getRestaurantCurrent(offset:Int,completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let param = ["offset":offset]
        
        ServiceFactory.get(url: Constants.API.GroundRestaurantCurrent, parameters: param) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        if let dataJson = serverResponse.data as? [[String : Any]]  {
                            let resturants : [GRestaurant] = Mapper<GRestaurant>().mapArray(JSONArray: dataJson)
                            serverResponse.data = resturants as AnyObject
                            completion(serverResponse)
                        } else {
                            let error = NSError(domain: "\(String(describing: serverResponse.message))", code: serverResponse.code ?? 0, userInfo: nil)
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
     Get my recent restaurant
     */
    class func getMyRestaurant(offset:Int,completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let param = ["offset":offset]
        
        ServiceFactory.get(url: Constants.API.GroundRestaurantMine, parameters: param) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        if let dataJson = serverResponse.data as? [[String : Any]]  {
                            let resturants : [GRestaurant] = Mapper<GRestaurant>().mapArray(JSONArray: dataJson)
                            serverResponse.data = resturants as AnyObject
                            completion(serverResponse)
                        } else {
                            let error = NSError(domain: "\(String(describing: serverResponse.message))", code: serverResponse.code ?? 0, userInfo: nil)
                            fail(error)
                        }
                    } else {
                        let error = NSError(domain: "\(String(describing: serverResponse.message))", code: serverResponse.code ?? 0, userInfo: nil)
                        fail(error)
                    }
                }
            } else {
                if let error = response.result.error {
                    fail(error)
                } else {
                    let error = NSError(domain: "\(String(describing: response.error?.localizedDescription))", code: 0, userInfo: nil)
                    fail(error)
                }
            }
        }
    }
    
    
    /*
     Get my recent restaurant
     */
    class func geRestaurantBy(area1:Int,area2:Int,offset:Int,completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let param = ["offset":offset,"tastyLocationDetail":area1]
        
        ServiceFactory.get(url: Constants.API.GroundRestaurantLocation, parameters: param) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        if let dataJson = serverResponse.data as? [[String : Any]]  {
                            let resturant : [GRestaurant] = Mapper<GRestaurant>().mapArray(JSONArray: dataJson)
                            serverResponse.data = resturant as AnyObject
                            completion(serverResponse)
                        } else {
                            let error = NSError(domain: "\(String(describing: serverResponse.message))", code: serverResponse.code ?? 0, userInfo: nil)
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
    
    class func createNewRestaurant(restaurant:GRestaurant,completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        var params :[String:AnyObject] = [:]
        params["tastyLocationDetail"] = restaurant.tastyLocation as AnyObject
        params["address"] = restaurant.address as AnyObject
        params["mainDish"] = restaurant.mainDish as AnyObject
        params["restaurant"] = restaurant.restaurant as AnyObject
        params["price"] = restaurant.price as AnyObject
        params["contact"] = restaurant.contact as AnyObject
        params["description"] = restaurant.description as AnyObject
        
        var arrParams:[String] = []
        for (key,value) in params{
            let param = "\(key)=\(value)"
            arrParams.append(param)
        }
        let path = arrParams.joined(separator: "&")
        let url = Constants.API.GroundRestaurant + "?\(path)"
        
        let header = [Constants.Parameter.Accept : Constants.Parameter.ApplicationJson,
                      Constants.Parameter.ContentType : Constants.Parameter.MultiPartFormData]
        
        //Constants.API.GroundRestaurant
        //formData
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                /*
                for (key,value) in params {
                    multipartFormData.append(value.data(using: String.Encoding.utf8.rawValue)!, withName: key)
                }
                */
                var index = 0
                for image in restaurant.tastyData {
                    index = index + 1
                    multipartFormData.append(UIImagePNGRepresentation(image)!, withName: "tastyPicture", fileName: "image\(index))", mimeType: "JPEG")
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

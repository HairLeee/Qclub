//
//  AuthService.swift
//  NetNews
//
//  Created by HungVo on 48/30/17.
//  Copyright © 2017 Vietel Media. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class AuthService {
    
    class func findId(_ name: String, mobile: String, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "name": name,
            "mobile": mobile
        ]
        
        ServiceFactory.get(url: Constants.API.FindId, parameters: parameters) { response in
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
    
    
    class func findPassword(_ id: String, name: String, mobile: String, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "id": id,
            "name": name,
            "mobile": mobile
        ]
        
        ServiceFactory.get(url: Constants.API.FindPassword, parameters: parameters) { response in
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
    
    class func checkDuplicateId(id: String, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "id": id
        ]
        
        ServiceFactory.get(url: Constants.API.CheckDuplicateId, parameters: parameters) { response in
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
    
    class func checkDuplicatePhone(phone: String, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "mobile": phone
        ]
        
        ServiceFactory.get(url: Constants.API.CheckDuplicateMobile, parameters: parameters) { response in
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
    
    class func checkDuplicateNickName(nickname: String, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "nickname": nickname
        ]
        
        ServiceFactory.get(url: Constants.API.CheckDuplicateNickname, parameters: parameters) { response in
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
    
    class func findRecommenderId(id: String, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "id": id
        ]
        
        ServiceFactory.get(url: Constants.API.FindRecommenderById, parameters: parameters) { response in
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
    
    class func login(id: String, password: String, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "id": id,
            "password": password
        ]
        
        ServiceFactory.post(url: Constants.API.Login, parameters: parameters) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        let userLogin : UserLogin = Mapper<UserLogin>().map(JSON: serverResponse.data as! [String : Any])!
                        userLogin.password = password
                        Context.saveUserLogin(userLogin: userLogin)
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
    
    class func register(user: UserJoin, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        var url = Constants.API.InsertUpdateUser + "?"
            + "affiliatedCompany=\(user.company!)"
            + "&affiliatedSchool=\(user.school!)"
            + "&birthDay=\(user.birthDay!)"
            + "&birthMonth=\(user.birthMonth!)"
            + "&birthYear=\(user.birthYear!)"
            + "&bloodDetail=\(user.bloodType!)"
            + "&bodyDetail=\(user.bodyType!)"
            + "&drinkingDetail=\(user.drinking!)"
            + "&gender=\(user.gender!)"
            + "&height=\(user.height!)"
            + "&id=\(user.id!)"
            + "&job=\(user.job!)"
            + "&locationDetail=\(user.local!)"
            + ((user.localEtc == nil || user.localEtc!.count == 0) ? "&locationEtc=" : "&locationEtc=\(user.localEtc!)")
            + "&maritalStatus=\(user.maritalStatus!)"
            + "&matchingTarget=\(user.matchingTarget!)"
            + "&mobile=\(user.mobile!)"
            + "&name=\(user.name!)"
            + "&nickname=\(user.nickName!)"
            + "&password=\(user.password!)"
            + "&relegionDetail=\(user.religion!)"
            + ((user.religionEtc == nil || user.religionEtc!.count == 0) ? "&relegionEtc=" : "&relegionEtc=\(user.religionEtc!)")
            + "&smokingDetail=\(user.smoking!)"
            + "&recommender=0"
            + "&inflowDetail=\(user.sourceInfo!)"
            + ((user.sourceInfoEtc == nil || user.sourceInfoEtc!.count == 0) ? "&inflowEtc=" : "&inflowEtc=\(user.sourceInfoEtc!)")
        
        for style in user.styles! {
            url += "&styleDetails=\(style)"
        }
        
        if let profilePicturesUnWrap = user.profilePictures {
            
            for profilePicture in profilePicturesUnWrap {
                url += "&orderSeqs=\(profilePicture.orderSeq!)"
            }
            
            for profilePicture in profilePicturesUnWrap {
                if let desString = profilePicture.descriptionString {
                    url += "&descriptions=\(desString)"
                } else {
                    url += "&descriptions="
                }
            }
        }
        let header = [Constants.Parameter.Accept : Constants.Parameter.ApplicationJson,
                      Constants.Parameter.ContentType : Constants.Parameter.MultiPartFormData]
        
        //        let encoding = URLEncoding.default
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                if let profilePicturesUnWrap = user.profilePictures {
                    for profilePicture in profilePicturesUnWrap {
                        let seq : Int = profilePicture.orderSeq ?? 0
                        multipartFormData.append(UIImagePNGRepresentation(profilePicture.profilePicture!)!, withName: "profilePictureFiles", fileName: "image\(seq).jpg", mimeType: "image/jpeg")
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
                            }else{
                                let error = NSError(domain: "", code: response.response?.statusCode ?? 0, userInfo: nil)
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
                    })
                    upload.responseString(completionHandler: { (response) in
                        print(response)
                    })
                        .uploadProgress { progress in
                            print("\(progress)")
                    }
                    return
                case .failure(let encodingError):
                    fail(encodingError)
                    debugPrint(encodingError)
                }
        })
    }
    
    class func getMasterData(masterSeq: Int, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        let parameters = [
            "masterSeq": masterSeq
        ]
        
        ServiceFactory.get(url: Constants.API.GetMasterData, parameters: parameters) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        if let dataJson = serverResponse.data as? [[String : Any]]  {
                            let masterObjects : [MasterDataObject] = Mapper<MasterDataObject>().mapArray(JSONArray: dataJson)
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
    
    class func postIdNotification(registrationId: String, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "registrationId": registrationId
        ]
        
        ServiceFactory.post(url: Constants.API.SendIdGCM, parameters: parameters) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                            completion(serverResponse)
                        } else {
                            let error = NSError(domain: "", code: serverResponse.code ?? 0, userInfo: nil)
                            fail(error)
                        }
                    } else {
                        let error = NSError(domain: "", code:  0, userInfo: nil)
                        fail(error)
                    }
                } else {
                    let error = NSError(domain: "", code: response.response?.statusCode ?? 0, userInfo: nil)
                    fail(error)
                }
            }
    }
    
}

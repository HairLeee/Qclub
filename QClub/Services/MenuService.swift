//
//  MenuService.swift
//  QClub
//
//  Created by Dreamup on 10/9/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class MenuService {
    
    
    var nickname:String = ""
    var gender:String = ""
    var locationDetail:Int = -1
    var locationEtc:String = ""
    var bloodDetail:Int = -1
    var height:Int = 0
    var bodyDetail:Int = -1
    var styleDetails:[Int]?
    var affiliatedSchool = ""
    var affiliatedCompany = ""
    var job:String = ""
    var relegionDetail:Int = -1
    var relegionEtc:String = ""
    var maritalStatus:String = ""
    var matchingTarget:String = ""
    var drinkingDetail:Int = -1
    var smokingDetail:Int = -1
    
    
    class func putModify1Update(pModify1:Modify1,completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        var url = Constants.API.GetModify1 + "?"
            + "nickname=\(pModify1.nickname)"
            + "&gender=\(pModify1.gender)"
            + "&locationDetail=\(pModify1.locationDetail)"
            + "&locationEtc=\(pModify1.relegionEtc)" //`
            + "&bloodDetail=\(pModify1.bloodDetail)"
            + "&height=\(pModify1.height)"
            + "&bodyDetail=\(pModify1.bodyDetail)"
            + "&styleDetails=1"
            + "&affiliatedSchool=\(pModify1.affiliatedSchool)"
            + "&affiliatedCompany=\(pModify1.affiliatedCompany)"
            + "&job=\(pModify1.job)"
            + "&relegionDetail=\(pModify1.relegionDetail)" //
            + "&relegionEtc=\(pModify1.relegionEtc)"
            + "&maritalStatus=\(pModify1.maritalStatus)"
            + "&matchingTarget=\(pModify1.matchingTarget)"
            + "&drinkingDetail=\(pModify1.drinkingDetail)"
            + "&smokingDetail=\(pModify1.smokingDetail)"
        
        
        url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!

        
        ServiceFactory.put(url: url, parameters: nil) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        
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
    
    class func postFavouriteUpdate(pFavourite:Favourite,completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
 
        let parameters = [
            "ageRange" : pFavourite.ageRange,
            "locationDetailChar": pFavourite.locationDetailChar,
            "styleDetailChar" : pFavourite.styleDetailChar,
            "heightDetailChar": pFavourite.heightDetailChar,
            "bodyDetailChar" : pFavourite.bodyDetailChar,
            "relegionMatch": pFavourite.relegionMatch,
            "drinkingDetailChar" : pFavourite.drinkingDetailChar,
            "smokingDetailChar": pFavourite.smokingDetailChar
            ] as [String : Any]
        
        
        ServiceFactory.post(url: Constants.API.GetFavouriteIdeal, parameters: parameters) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        
                        let message = serverResponse.message as! String
                        
                        
                    }
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
    
    class func putFavouriteUpdate(pFavourite:Favourite,completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
                var url = Constants.API.GetFavouriteIdeal + "?"
                    + "ageRange=\(pFavourite.ageRange)"
                    + "&locationDetailChar=\(pFavourite.locationDetailChar)"
                    + "&styleDetailChar=\(pFavourite.styleDetailChar)"
                    + "&heightDetailChar=\(pFavourite.heightDetailChar)" //
                    + "&bodyDetailChar=\(pFavourite.bodyDetailChar)"
                    + "&relegionMatch=\(pFavourite.relegionMatch)"
                    + "&drinkingDetailChar=\(pFavourite.drinkingDetailChar)"
                    + "&smokingDetailChar=\(pFavourite.smokingDetailChar)"
        
        
          url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        let parameters = [
            "ageRange" : pFavourite.ageRange,
            "locationDetailChar": pFavourite.locationDetailChar,
            "styleDetailChar" : pFavourite.styleDetailChar,
            "heightDetailChar": pFavourite.heightDetailChar,
            "bodyDetailChar" : pFavourite.bodyDetailChar,
            "relegionMatch": pFavourite.relegionMatch,
            "drinkingDetailChar" : pFavourite.drinkingDetailChar,
            "smokingDetailChar": pFavourite.smokingDetailChar
            ] as [String : Any]
        
        
        ServiceFactory.put(url: url, parameters: nil) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        
                        let message = serverResponse.message as! String
                        
                        
                    }
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
    
    
    class func getFavouriteIdeal(completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        
        ServiceFactory.get(url: Constants.API.GetFavouriteIdeal) { (response) in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        
                        completion(serverResponse)
                    } else {
                        
                         completion(serverResponse)
                    }}
            }
        }
        
    }
    
    
    class func removeHolding(completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        //        let url = Constants.API.GetModify3 + "?"
        //            + "words=\(words)"
        //            + "&appearance=\(appearance)"
        //            + "&inHoliday=\(inHoliday)"
        //            + "&lookFor=\(lookFor)"
        
        ServiceFactory.delete(url: Constants.API.GetHolding, parameters: nil) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        
                        let message = serverResponse.message as! String
                        
                        
                    }
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
    
    
    class func regisHolding(completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        //        let url = Constants.API.GetModify3 + "?"
        //            + "words=\(words)"
        //            + "&appearance=\(appearance)"
        //            + "&inHoliday=\(inHoliday)"
        //            + "&lookFor=\(lookFor)"
        
        ServiceFactory.put(url: Constants.API.GetHolding, parameters: nil) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        
                        let message = serverResponse.message as! String
                        
                        
                    }
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
    
    
    
    
    class func postContact(inPrDetail:Int, description: String, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "inPrDetail" : inPrDetail,
            "description": description
            ] as [String : Any]
        
        ServiceFactory.post(url: Constants.API.PostContact, parameters: parameters) { response in
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
    
    
    class func readMyinfoComment(adviceSeq:Int, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "adviceSeq" : adviceSeq
        ]
        var url = Constants.API.GetComment + "?"
            + "adviceSeq=\(adviceSeq)"
        
        
        url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        
        ServiceFactory.put(url: url, parameters: nil) { response in
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
    
    
    
    class func getMyinfoComment(completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        
        ServiceFactory.get(url: Constants.API.GetComment) { (response) in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        
                        if let dataJson = serverResponse.data as? [[String : Any]]  {
                            
                            let myinfoComment : [MyInfoComment] = Mapper<MyInfoComment>().mapArray(JSONArray: dataJson)
                            
                            //                            let myinfoComment : Comment = Mapper<Comment>().map(JSON: dataJson)!
                            
                            serverResponse.data = myinfoComment as AnyObject
                            completion(serverResponse)
                        } else {
                            
                            let error = NSError(domain: "", code: 0, userInfo: nil)
                            fail(error)
                        }
                        
                    }}
                
            }
        }
        
    }
    
    
    class func getQClubInfo(completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        
        ServiceFactory.get(url: Constants.API.GetQclubInfo) { (response) in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        
                        if let dataJson = serverResponse.data as? [String : Any]  {
                            
                            
                            let qclubInfo : QclubInfo = Mapper<QclubInfo>().map(JSON: dataJson)!
                            
                            serverResponse.data = qclubInfo as AnyObject
                            completion(serverResponse)
                        } else {
                            
                            let error = NSError(domain: "", code: 0, userInfo: nil)
                            fail(error)
                        }
                        
                    }}
                
            }
        }
        
    }
    
    
    class func removeBoard(ourStorySeq:Int, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "ourStorySeq" : ourStorySeq
        ]
        
        ServiceFactory.delete(url: Constants.API.PostOurStory, parameters: parameters) { response in
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
    
    class func postDetailBoardProfile(completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        
        ServiceFactory.get(url: Constants.API.PostOurStoryProfile,parameters: nil) { (response) in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        
                        completion(serverResponse)
                        
                    }}
                
            }
        }
        
    }
    
    
    class func getDetailBoard(pOurStorySeq:Int, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "ourStorySeq": pOurStorySeq
            ] as [String : Any]
        
        
        ServiceFactory.get(url: Constants.API.PostOurStory,parameters: parameters) { (response) in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        
                        if let dataJson = serverResponse.data as? [String : Any]  {
                            //                            let board : Board = Mapper<Board>().mapArray(JSONArray: dataJson)
                            
                            let board : Board = Mapper<Board>().map(JSON: dataJson)!
                            
                            serverResponse.data = board as AnyObject
                            completion(serverResponse)
                        } else {
                            
                            let error = NSError(domain: "", code: 0, userInfo: nil)
                            fail(error)
                        }
                        
                    }}
                
            }
        }
        
    }
    
    
    class func uploadBoardInfo(storyDetail:Int, user: BoardN, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        let url = Constants.API.PostOurStory + "?"
            + "storyDetail=\(storyDetail)"
            + "&title=\(user.title!)"
            + "&description=\(user.des!)"
        
        
        let header = [Constants.Parameter.Accept : Constants.Parameter.ApplicationJson,
                      Constants.Parameter.ContentType : Constants.Parameter.MultiPartFormData]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                if let profilePicturesUnWrap = user.storyPictures {
                    for profilePicture in profilePicturesUnWrap {
                        let seq : Int = profilePicture.orderSeq ?? 0
                        multipartFormData.append(UIImagePNGRepresentation(profilePicture.profilePicture!)!, withName: "storyPictures", fileName: "image\(seq).jpg)", mimeType: "image/jpeg")
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
    
    
    class func getOurStory(storyDetail:Int, title:String, offset:Int, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "storyDetail": storyDetail,
            "title": title,
            "offset": offset
            ] as [String : Any]
        
        
        ServiceFactory.get(url: Constants.API.GetOurStory,parameters: parameters) { (response) in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        
                        if let dataJson = serverResponse.data as? [[String : Any]]  {
                            let board : [Board] = Mapper<Board>().mapArray(JSONArray: dataJson)
                            serverResponse.data = board as AnyObject
                            completion(serverResponse)
                        } else {
                            let error = NSError(domain: "", code: 0, userInfo: nil)
                            fail(error)
                        }
                        
                    }}
                
            }
        }
        
    }
    
    class func getEmailFromChangingPw(completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        
        ServiceFactory.get(url: Constants.API.GetEmailFromPw) { (response) in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        
                        completion(serverResponse)
                    }}
                
            }
        }
        
    }
    
    class func getMyInfo(completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        ServiceFactory.get(url: Constants.API.GetMyInfo, parameters: nil) { response in
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
    
    
    class func getModify2(modify2:Modify2, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        var url = Constants.API.GetModify2 + "?"
            + "annualIncome=\(modify2.annualIncome)"
            + "&propertyFlag=\(modify2.propertyFlag)"
            + "&carFlag=\(modify2.carFlag)"
            + "&carModel=\(modify2.carModel)"
            + "&personality=\(modify2.personality)"
            + "&hobby=\(modify2.hobby)"
            + "&travel=\(modify2.travel)"
            + "&wishes=\(modify2.wishes)"
        
        url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        
        ServiceFactory.put(url: url, parameters: nil) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        
                        let message = serverResponse.message as! String
                        
                        print(message)
                        
                        
                    }
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
    
    class func getModify3(words:String, appearance:String, inHoliday:String, lookFor:String, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let url = Constants.API.GetModify3 + "?"
            + "words=\(words)"
            + "&appearance=\(appearance)"
            + "&inHoliday=\(inHoliday)"
            + "&lookFor=\(lookFor)"
        
        ServiceFactory.put(url: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!, parameters: nil) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        
                        let message = serverResponse.message as! String
                        
                        
                        
                    }
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
    
    
    
    
    class func getStore(offset: Int, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "offset": offset
        ]
        
        ServiceFactory.get(url: Constants.API.GetStore, parameters: parameters) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        if let dataJson = serverResponse.data as? [[String : Any]]  {
                            let notice : [Store] = Mapper<Store>().mapArray(JSONArray: dataJson)
                            serverResponse.data = notice as AnyObject
                            completion(serverResponse)
                        } else {
                            let error = NSError(domain: "", code: 0, userInfo: nil)
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
    
    
    class func getHolding(completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        
        ServiceFactory.get(url: Constants.API.GetHolding) { (response) in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        let model : Holding = Mapper<Holding>().map(JSON: serverResponse.data  as! [String : Any])!
                        serverResponse.data = model as AnyObject
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
    
    
    class func getNotices(offset: Int, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "offset": offset
        ]
        
        ServiceFactory.get(url: Constants.API.GetNotices, parameters: parameters) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        if let dataJson = serverResponse.data as? [[String : Any]]  {
                            let notice : [Notice] = Mapper<Notice>().mapArray(JSONArray: dataJson)
                            serverResponse.data = notice as AnyObject
                            completion(serverResponse)
                        } else {
                            let error = NSError(domain: "", code: 0, userInfo: nil)
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
    
    
    class func getFqaList(offset: Int, completion : @escaping (_ response: [Fqa]) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "offset": offset
        ]
        
        ServiceFactory.get(url: Constants.API.GetFqaList, parameters: parameters) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        var result = [Fqa]()
                        if let tempArr = serverResponse.data as! Array<AnyObject>? {
                            for entry in tempArr {
                                let model : Fqa = Mapper<Fqa>().map(JSON: entry as! [String : Any])!
                                result.append(model)
                            }
                        }
                        completion(result)
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
    
    class func getAgreementHtlm(inPrDetail: Int, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "inPrDetail": inPrDetail
        ]
        
        ServiceFactory.get(url: Constants.API.GetAgreement, parameters: parameters) { response in
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
    
    
    class func TEST(offset: Int, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "offset": offset
        ]
        
        ServiceFactory.get(url: Constants.API.GetNotices, parameters: parameters) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        
                        
                        
                        
                        
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
    
    class func getHeart(offset: Int, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "offset": offset
        ]
        
        ServiceFactory.get(url: Constants.API.GetHeart, parameters: parameters) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        if let dataJson = serverResponse.data as? [[String : Any]]  {
                            let heart : [Heart] = Mapper<Heart>().mapArray(JSONArray: dataJson)
                            serverResponse.data = heart as AnyObject
                            completion(serverResponse)
                        } else {
                            let error = NSError(domain: "", code: 0, userInfo: nil)
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
    
    class func changePw(oldPw:String, newPW:String, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        var url = Constants.API.GetEmailFromPw + "?"
            + "oldPassword=\(oldPw)"
            + "&newPassword=\(newPW)"
        
        
        url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        
        ServiceFactory.put(url: url, parameters: nil) { response in
            if response.result.isSuccess, response.response?.statusCode == 200 {
                if let serverResponse = Mapper<ServerResponse>().map(JSONObject: response.result.value) {
                    if serverResponse.code == 0 {
                        
                        let message = serverResponse.message as! String
                        
                        print(message)
                        
                        
                    }
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
    
    class func uploadProfile(image:UserImage, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        let des : String = image.descriptionString ?? ""
        let url = Constants.API.MenuProfile + "?"
            + "description=\(des)"
        
        
        let header = [Constants.Parameter.Accept : Constants.Parameter.ApplicationJson,
                      Constants.Parameter.ContentType : Constants.Parameter.MultiPartFormData]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                if let profilePicturesUnWrap = image.profilePicture {
                        let seq : Int = image.orderSeq ?? 0
                        multipartFormData.append(UIImagePNGRepresentation(profilePicturesUnWrap)!, withName: "profilePicture", fileName: "image\(seq).jpg)", mimeType: "image/jpeg")
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

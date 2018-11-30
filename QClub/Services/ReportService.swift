//
//  ReportService.swift
//  QClub
//
//  Created by SMR on 10/16/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class ReportService {

    class func sendReportUser(userSeq: Int,reportDetail: Int, reportDetailStr:String, reportEtc: String, completion : @escaping (_ response: ServerResponse) -> (), fail: @escaping (Error) -> Void) -> Void {
        
        let parameters = [
            "targetUserSeq": "\(userSeq)",
            "reportDetail": reportDetail,
            "reportEtc": reportEtc,
            ] as [String : Any]
        
        ServiceFactory.post(url: Constants.API.Report, parameters: parameters) { response in
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
}

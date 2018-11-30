//
//  KakaoTalkManager.swift
//  QClub
//
//  Created by TuanNM on 11/20/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class KakaoTalkManager: NSObject {

    func shareDownloadLink() -> Void {

        let appLink = "https://itunes.apple.com/us/app/let-letearthtalk/id1240646473?ls=1&mt=8"
        let imageURL = "https://lh5.googleusercontent.com/mRNfProxmmGGZXCy4Ko3ao7i7xZpyuR1GMIFIbRHisvkSx-kN0dsJv-rKZzQpFl4ImpV5KaBW75AJ4dBRxQ1=w1920-h935"
        
        let template = KLKFeedTemplate.init { (feedTemplateBuilder) in
            
            // 컨텐츠
            feedTemplateBuilder.content = KLKContentObject.init(builderBlock: { (contentBuilder) in
                contentBuilder.title = "Welcome to Q Club !"
                contentBuilder.desc = "#Qclub"
                contentBuilder.imageURL = URL.init(string: imageURL)!
                contentBuilder.link = KLKLinkObject.init(builderBlock: { (linkBuilder) in
                    linkBuilder.mobileWebURL = URL.init(string: appLink)
                })
            })
            
        }

        KLKTalkLinkCenter.shared().sendDefault(with: template, success: { (warningMsg, argumentMsg) in
            
        }, failure: { (error) in
            
        })
    }
    
}


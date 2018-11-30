//
//  OurStoryModel.swift
//  QClub
//
//  Created by Dreamup on 10/23/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper
class OurStoryModel: NSObject {
    
    
    var mTitle:String = ""
    var mNameOfIcon:String = ""
    
    init(title:String, nameOfIcon:String) {
        mTitle = title
        mNameOfIcon = nameOfIcon
    }
    
}

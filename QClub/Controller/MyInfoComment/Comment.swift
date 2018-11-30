//
//  Comment.swift
//  QClub
//
//  Created by Dreamup on 10/12/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit


class Comment {
    
    var title:String = ""
    var comment: String = ""
    var isOpened = false
    
    
    init(title: String, comment: String, isOpened: Bool) {
        self.title = title
        self.comment = comment
        self.isOpened = isOpened
    }
}

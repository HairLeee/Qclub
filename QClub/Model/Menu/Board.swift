//
//  Board.swift
//  QClub
//
//  Created by Dreamup on 11/8/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit
import ObjectMapper

class StoryPicture : Mappable {
    var storyPicture = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        storyPicture <- map["storyPicture"]
        storyPicture = "http://" + storyPicture
    }
}

class Board: Mappable {
    
    var ourStorySeq:Int = 0
    var userSeq: Int = 0
    var nickname:String = ""
    var title:String = ""
    var descriptionOurStory:String = ""
    var profilePicture: String = ""
    var adminReply:String = ""
    var replyDate:String = ""
    var createDate: String = ""
    var ourstoryPicture = [StoryPicture]()
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map)
    {
        ourStorySeq <- map["ourStorySeq"]
        userSeq <- map["userSeq"]
        nickname <- map["nickname"]
        title <- map["title"]
        descriptionOurStory <- map["description"]
        profilePicture <- map["profilePicture"]
        adminReply <- map["adminReply"]
        replyDate <- map["replyDate"]
        createDate <- map["createDate"]
        ourstoryPicture <- map["ourstoryPicture"]
        profilePicture = "http://" + profilePicture
    }
}

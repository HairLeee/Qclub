//
//  Constant.swift
//  QClub
//
//  Created by Dream on 9/14/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let buttonActiveColor = UIColor.init(hexString: "#e86a12")
let buttonInActiveColor = UIColor.init(hexString: "#bdbdbd")
let textHightLight = UIColor.init(hexString: "#e86a12")
let backgroundCellSelectedColor = UIColor.init(hexString: "#ffaa4f")

class Constants {
    struct Domain {
        static let Testing = "http://icue.iptime.org:9991/api/v1"
        static let Staging = "http://10.0.0.2:8080"
        static let Production = "http://10.0.0.2:8080"
    }
    
    struct API {
        
        #if QCLUB_PLATFORM_TESTING
        static let baseURL = Domain.Testing
        #elseif QCLUB_PLATFORM_STAGING
        static let baseURL = Domain.Staging
        #elseif QCLUB_PLATFORM_PRODUCTION
        static let baseURL = Domain.Production
        #endif
        
        static let GetMasterData = baseURL + "/codes"
        
        // authentication APIs
        static let InsertUpdateUser = baseURL + "/user"
        static let CheckDuplicateId = baseURL + "/duplication/id"
        static let CheckDuplicateMobile = baseURL + "/duplication/mobile"
        static let CheckDuplicateNickname = baseURL + "/duplication/nickname"
        static let FindId = baseURL + "/find/id"
        static let FindPassword = baseURL + "/find/password"
        static let Login = baseURL + "/login"
        static let ValidateIdBeforeLogin = baseURL + "/login/validate"
        static let FindRecommenderById = baseURL + "/recommender"
        static let SendIdGCM = baseURL + "/menu/execute"
        
        // Menu
        // Notice
        static let GetMyInfo = baseURL + "/menu/myinfo"
        static let MenuProfile = baseURL + "/menu/profile"
        
        
        static let GetNotices = baseURL + "/menu/notification"
        
        //Holding
        static let GetHolding = baseURL + "/menu/holding"
        
        //Password
        static let GetEmailFromPw = baseURL + "/menu/password"
        
        //Favourite
        static let GetFavouriteIdeal = baseURL + "/menu/ideal"
        
        
        //Store
        static let GetStore = baseURL + "/menu/store"
        
        //Heart
        static let GetHeart = baseURL + "/menu/heart"
        
        // Fqa api
        static let GetFqaList = baseURL + "/menu/faq"
         static let PostContact = baseURL + "/menu/inpr"
        
        // MyInfo Comment
        static let GetComment = baseURL + "/menu/advice"
  
        // Modify 1 api
        static let GetModify1 = baseURL + "/menu/modify1"
        
        // Modify 2 api
        static let GetModify2 = baseURL + "/menu/modify2"
        
        // Modify 3 api
        static let GetModify3 = baseURL + "/menu/modify3"
        
        //Our Story  - Board
        static let GetOurStory = baseURL + "/ourstory/list"
        static let PostOurStory = baseURL + "/ourstory/post"
           static let PostOurStoryProfile = baseURL + "/ourstory/post/profile"
        // Qclub
        static let GetQclubInfo = baseURL + "/qclub/request"
        
        
        // agreemment
        static let GetAgreement = baseURL + "/menu/agreement"
   
        
        // Match api
        static let GetMatchTodayList = baseURL + "/match/today/list"
        static let GetMatchTodayChoice = baseURL + "/match/today/choice"
        static let GetMatchTodayChoiceFree = baseURL + "/match/today/choice/free"
        static let GetMatchTodayHistory = baseURL + "/match/today/history"
        static let GetMatchSpecialRegist = baseURL + "/match/special/regist/test"
        static let GetMatchSpecialList = baseURL + "/match/special/list"
        static let GetMatchSpecialChoice = baseURL + "/match/special/choice"
        static let GetMatchCustomizedList = baseURL + "/match/customized/list"
        static let GetMatchFromMe = baseURL + "/match/interest/fromme"
        static let GetMatchToMe = baseURL + "/match/interest/tome"
        static let GetTodayMore = baseURL + "/match/today/more"
        static let ResponseRequestRelationShip = baseURL + "/match/special/response"
        static let GetAboveCharm20 = baseURL + "/match/today/aboveCharm20"
        static let GetAboveQ1 = baseURL + "/match/today/aboveQ1"
        static let DeleteFavorite = baseURL + "/match/interest/delete"
        static let InteresterChoice = baseURL + "/match/interest/choice"
        static let TodayHistoryChoice = baseURL + "/match/today/history/choice"
        
        
        // Profile api
        static let GetProfileBasic = baseURL + "/profile/basic"
        static let ProfileCompletionScore = baseURL + "/profile/completion"
        static let ProfileLikAbility = baseURL + "/profile/likability"
        static let ProfileAdvice = baseURL + "/profile/advice"
        static let ProfileAttractive = baseURL + "/profile/attractive"
        static let MyAttractive = baseURL + "/charm/"
        
        // Report api
        static let Report = baseURL + "/report/user"
        
        //Relation api
        static let GetHeartCount = baseURL + "/relation/heart"
        static let CandySearch = baseURL + "/relation/location"
        
        //Candy api
        static let GetCandyStatus = baseURL + "/candy/status"
        static let GetCandyList = baseURL + "/candy/list"
        static let GetCandyRequest = baseURL + "/candy/request"
        static let GetCandySearch = baseURL + "/candy/search"
        static let GetCandyStatusWait = baseURL + "/candy/status/wait"
        static let GetCandyViewProfile = baseURL + "/candy/viewprofile"
        static let GetCandyCancel = baseURL + "/candy/status/wait/cancel"
        static let GetCandyResponse = baseURL + "/candy/response"
        
        //Meeting
        static let GetMeetingRoom = baseURL + "/meeting/room"
        static let GetMeetingRoomDetail = baseURL + "/meeting/room/detail"
        static let GetMeetingViewUser = baseURL + "/meeting/viewUser"
        static let ChoiceMeetingUser = baseURL + "/meeting/choice"
        static let GetProfile = baseURL + "/meeting/profile"
        static let ModifyApeal = baseURL + "/meeting/modifyAppeal"
        
        //Ground Introduce
        static let GetIntroduceList = baseURL + "/introduce/list"
        static let GetIntroduceMine = baseURL + "/introduce/mine"
        static let PostIntroduceMine = baseURL + "/introduce/post"
        static let IntroduceComment = baseURL + "/introduce/review"
        
        //Ground Search
        static let GroundSearchingTheme = baseURL + "/relation/theme"
        static let GroundSearchingLocation = baseURL + "/relation/location"
        static let ViewProfileLocation = baseURL + "/relation/location/profile"
        static let ViewProfileTheme = baseURL + "/relation/theme/profile"


        //Ground Food
        static let GroundRestaurant = baseURL + "/tasty/restaurant"
        static let GroundRestaurantCurrent = baseURL + "/tasty/restaurants/current"
        static let GroundRestaurantLike = baseURL + "/tasty/restaurant/like"
        static let GroundRestaurantLocation = baseURL + "/tasty/restaurants/location"
        static let GroundRestaurantMine = baseURL + "/tasty/restaurants/mine"
        
        //Ground Battle
        static let GroundBattleStart = baseURL + "/battle/initBattle"
        static let GroundBattleNext = baseURL + "/battle/getNext"
        static let GroundBattlePayInfo = baseURL + "/battle/payProfile"
        static let GroundBattleInfo = baseURL + "/battle/info"

        //Common
         static let GetRoadAddress = baseURL + "/juso"
        
        
        //Message
        static let SendMessage = baseURL + "/message/send"
        static let GetAllMessage = baseURL + "/message/myAllList"
        static let DeleteMessage = baseURL + "/message/delete"
        static let GetNewMessageStatus = baseURL + "/menu/newFlag"
        static let ViewMessage = baseURL + "/message/view"
        static let GetMessageStatus = baseURL + "/message/status"
        static let GetLastSentMessage = baseURL + "/message/myRecentlySend"

        
        //Item
        static let GetItemRecent = baseURL + "/it/items/current"
        static let GetMyItem = baseURL + "/it/items/mine"
        static let GetItemDetail = baseURL + "/it/item"
        static let LikeItem = baseURL + "/it/item/like"
        static let PostItem = baseURL + "/it/item"
        
    }
    
    struct ChannelName {
        static let Letter = "channel_letter"
        static let Candy = "channel_candy"
    }
    
    struct SendBirdMetaData {
        static let ListSeq = "list_seq"
        static let ResponseDate = "response_date"
        static let CreateDate = "create_date"
        static let IsClose = "is_closed"
    }
    
    struct Parameter {
        // headers
        static let Accept = "Accept"
        static let ApplicationJson = "application/json"
        static let AccessTokenType = "access-token"
        static let ContentType = "Content-Type"
        static let FormUrlEncoded = "application/x-www-form-urlencoded"
        static let MultiPartFormData = "multipart/form-data"
        
        // params
        static let Name = "name"
        static let UserName = "username"
        static let Email = "email"
        static let Password = "password"
    }
    
    // UserDefaults Keys
    struct UserDefaultsKey {
        static let AccessToken = "AccessToken"
        static let UserLogin = "UserLogin"
        static let IndexIntro = "IndexIntro"
    }
    
    // Mastercode Keys
    struct MasterCode {
        static let Inflow = 1
        static let Location = 2
        static let Blood = 3
        static let Key = 4
        static let Body = 5
        static let Style = 6
        static let Relegion = 7
        static let Drink = 8
        static let MaleImpression = 10
        static let FemaleImpression = 11
        static let UserAdvice = 12
        static let Location1 = 13
        static let Location2 = 14
        static let ReportReason = 15
    }
    
    // Notification Keys
    struct Notifications {
        static let CandySelect = "CandySelect"
    }
    
    // SendBird
    static func navigationBarTitleColor() -> UIColor {
        return UIColor(red: 128.0/255.0, green: 90.0/255.0, blue: 255.0/255.0, alpha: 1)
    }
    
    static func navigationBarSubTitleColor() -> UIColor {
        return UIColor(red: 142.0/255.0, green: 142.0/255.0, blue: 142.0/255.0, alpha: 1)
    }
    
    static func navigationBarTitleFont() -> UIFont {
        return UIFont(name: "HelveticaNeue", size: 16.0)!
    }
    
    static func navigationBarSubTitleFont() -> UIFont {
        return UIFont(name: "HelveticaNeue-LightItalic", size: 10.0)!
    }
    
    static func textFieldLineColorNormal() -> UIColor {
        return UIColor(red: 217.0/255.0, green: 217.0/255.0, blue: 217.0/255.0, alpha: 1)
    }
    
    static func textFieldLineColorSelected() -> UIColor {
        return UIColor(red: 140.0/255.0, green: 109.0/255.0, blue: 238.0/255.0, alpha: 1)
    }
    
    static func nicknameFontInMessage() -> UIFont {
        return UIFont(name: "HelveticaNeue", size: 12.0)!
    }
    
    static func nicknameColorInMessageNo0() -> UIColor {
        return UIColor(red: 45.0/255.0, green: 27.0/255.0, blue: 225.0/255.0, alpha: 1)
    }
    
    static func nicknameColorInMessageNo1() -> UIColor {
        return UIColor(red: 53.0/255.0, green: 163.0/255.0, blue: 251.0/255.0, alpha: 1)
    }
    
    static func nicknameColorInMessageNo2() -> UIColor {
        return UIColor(red: 128.0/255.0, green: 90.0/255.0, blue: 255.0/255.0, alpha: 1)
    }
    
    static func nicknameColorInMessageNo3() -> UIColor {
        return UIColor(red: 207.0/255.0, green: 72.0/255.0, blue: 251.0/255.0, alpha: 1)
    }
    
    static func nicknameColorInMessageNo4() -> UIColor {
        return UIColor(red: 226.0/255.0, green: 27.0/255.0, blue: 225.0/255.0, alpha: 1)
    }
    
    static func messageDateFont() -> UIFont {
        return UIFont(name: "HelveticaNeue", size: 10.0)!
    }
    
    static func messageDateColor() -> UIColor {
        return UIColor(red: 191.0/255.0, green: 191.0/255.0, blue: 191.0/255.0, alpha: 1)
    }
    
    static func incomingFileImagePlaceholderColor() -> UIColor {
        return UIColor(red: 238.0/255.0, green: 241.0/255.0, blue: 246.0/255.0, alpha: 1)
    }
    
    static func messageFont() -> UIFont {
        return UIFont(name: "HelveticaNeue", size: 16.0)!
    }
    
    static func outgoingMessageColor() -> UIColor {
        return UIColor(red: 255.0/255.0, green: 255.0/255.0, blue: 255.0/255.0, alpha: 1)
    }
    
    static func incomingMessageColor() -> UIColor {
        return UIColor(red: 0.0/255.0, green: 0.0/255.0, blue: 0.0/255.0, alpha: 1)
    }
    
    static func outgoingFileImagePlaceholderColor() -> UIColor {
        return UIColor(red: 128.0/255.0, green: 90.0/255.0, blue: 255.0/255.0, alpha: 1)
    }
    
    static func openChannelLineColorNo0() -> UIColor {
        return UIColor(red: 45.0/255.0, green: 227.0/255.0, blue: 255.0/255.0, alpha: 1)
    }
    
    static func openChannelLineColorNo1() -> UIColor {
        return UIColor(red: 53.0/255.0, green: 163.0/255.0, blue: 251.0/255.0, alpha: 1)
    }
    
    static func openChannelLineColorNo2() -> UIColor {
        return UIColor(red: 128.0/255.0, green: 90.0/255.0, blue: 255.0/255.0, alpha: 1)
    }
    
    static func openChannelLineColorNo3() -> UIColor {
        return UIColor(red: 207.0/255.0, green: 72.0/255.0, blue: 251.0/255.0, alpha: 1)
    }
    
    static func openChannelLineColorNo4() -> UIColor {
        return UIColor(red: 226.0/255.0, green: 72.0/255.0, blue: 195.0/255.0, alpha: 1)
    }
    
    static func leaveButtonColor() -> UIColor {
        return UIColor.red
    }
    
    static func hideButtonColor() -> UIColor {
        return UIColor(red: 116.0/255.0, green: 127.0/255.0, blue: 145.0/255.0, alpha: 1)
    }
    
    static func leaveButtonFont() -> UIFont {
        return UIFont(name: "HelveticaNeue", size: 16.0)!
    }
    
    static func hideButtonFont() -> UIFont {
        return UIFont(name: "HelveticaNeue", size: 16.0)!
    }
    
    static func distinctButtonSelected() -> UIFont {
        return UIFont(name: "HelveticaNeue-Medium", size: 18.0)!
    }
    
    static func distinctButtonNormal() -> UIFont {
        return UIFont(name: "HelveticaNeue", size: 18.0)!
    }
    
    static func navigationBarButtonItemFont() -> UIFont {
        return UIFont(name: "HelveticaNeue", size: 16.0)!
    }
    
    static func memberOnlineTextColor() -> UIColor {
        return UIColor(red: 41.0/255.0, green: 197.0/255.0, blue: 25.0/255.0, alpha: 1)
    }
    
    static func memberOfflineDateTextColor() -> UIColor {
        return UIColor(red: 142.0/255.0, green: 142.0/255.0, blue: 142.0/255.0, alpha: 1)
    }
    
    static func connectButtonColor() -> UIColor {
        return UIColor(red: 123.0/255.0, green: 95.0/255.0, blue: 217.0/255.0, alpha: 1)
    }
    
    static func urlPreviewDescriptionFont() -> UIFont {
        return UIFont(name: "HelveticaNeue-Light", size: 12.0)!
    }
}


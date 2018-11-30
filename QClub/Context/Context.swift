//
//  Context.swift
//  QClub
//
//  Created by SMR on 10/4/17.
//  Copyright © 2017 Dream. All rights reserved.
//

import UIKit

class Context {
    
    
    struct settingPassword {
        static let PASSWORD_CODE_KEY = "PASSWORD_CODE_KEY"
    }
    
    static let AccessToken = "AccessToken"
    
    
    //AccessToken
    class func clearAccessToken() {
        saveAccessToken("")
    }
    
    class func saveAccessToken(_ token: String) -> Void {
        let preferences = UserDefaults.standard
        preferences.set(token,forKey: Constants.UserDefaultsKey.AccessToken)
        preferences.synchronize()
    }
    
    class func getAccessToken() -> String {
        let token = UserDefaults.standard.string(forKey: Constants.UserDefaultsKey.AccessToken)
        return token ?? ""
    }
    
    class func saveUserLogin(userLogin: UserLogin) -> Void {
        let preferences = UserDefaults.standard
        preferences.set(NSKeyedArchiver.archivedData(withRootObject: userLogin),forKey: Constants.UserDefaultsKey.UserLogin)
        preferences.synchronize()
    }
    
    class func getUserLogin() -> UserLogin? {
        if let data = UserDefaults.standard.object(forKey: Constants.UserDefaultsKey.UserLogin) {
            let user = NSKeyedUnarchiver.unarchiveObject(with: data as! Data)
            return user as? UserLogin
        }
        return nil
    }
    
    class func deleteUserLogin() {
        let preferences = UserDefaults.standard
        preferences.removeObject(forKey: Constants.UserDefaultsKey.UserLogin)
        preferences.synchronize()
    }
    
    
    class func setSettingPw(_ pw: String) -> Void {
        let preferences = UserDefaults.standard
        preferences.set(pw,forKey: settingPassword.PASSWORD_CODE_KEY)
        preferences.synchronize()
    }
    
    class func getSettingPw() -> String {
        let pw = UserDefaults.standard.string(forKey: settingPassword.PASSWORD_CODE_KEY)
        return pw ?? ""
    }
    
    class func deleteSettingPw() {
        let preferences = UserDefaults.standard
        preferences.removeObject(forKey: settingPassword.PASSWORD_CODE_KEY)
        preferences.synchronize()
    }
    
    class func setIndexIntro(_ index: Int) -> Void {
        let preferences = UserDefaults.standard
        preferences.set(index,forKey: Constants.UserDefaultsKey.IndexIntro)
        preferences.synchronize()
    }
    
    class func getIndexIntro() -> Int {
        let index = UserDefaults.standard.integer(forKey: Constants.UserDefaultsKey.IndexIntro)
        return index > 0 ? index : 1
    }
    
    
}

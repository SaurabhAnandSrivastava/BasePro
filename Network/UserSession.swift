//
//  UserSession.swift
//  FurEternity
//
//  Created by Saurabh Srivastav on 09/06/22.
//

import UIKit
struct UserProfil: Codable{
    
    var name: String?
    var email: String?
    var username: String?
    var money: String?
    var gametoken: String?
    var token: String?
}

let USER_DETAILS = "userDetails"
let USER_EMAIL = "useremail"
let USER_NAME = "username"
let USER_USERNAME = "userusername"
let USER_TOKEN = "usertoken"
let USER_MONEY = "usermoney"
let USER_GAME_TOKEN = "usergametoken"
class UserSession: NSObject {
    
    
    public static var session: UserProfil! {
        
        set {  let userDic = NSMutableDictionary()
            userDic[USER_USERNAME] = newValue.username
            userDic[USER_EMAIL] = newValue.email
            userDic[USER_NAME] = newValue.name
            userDic[USER_TOKEN] = newValue.token
            userDic[USER_MONEY] = newValue.money
            userDic[USER_GAME_TOKEN] = newValue.gametoken
            UserDefaults.standard.setValue(userDic, forKey: USER_DETAILS)
            
            
        }
        
        get {
            
            if  UserDefaults.standard.value(forKey: USER_DETAILS) == nil{
                UserDefaults.standard.setValue(NSDictionary(), forKey: USER_DETAILS)
                return UserProfil()
            }
            
            
            let userDic = UserDefaults.standard.value(forKey: USER_DETAILS) as! NSDictionary
            
            if userDic[USER_TOKEN] == nil {
                return UserProfil()
            }
            
            var dic = UserProfil()
            
            dic.username =  (userDic[USER_USERNAME] as! String)
            dic.email =  (userDic[USER_EMAIL] as! String)
            dic.name =  (userDic[USER_NAME] as! String)
            dic.money = (userDic[USER_MONEY] as! String)
            dic.gametoken = (userDic[USER_GAME_TOKEN] as! String)
            if userDic[USER_TOKEN] != nil {
                dic.token = (userDic[USER_TOKEN] as! String)
            }
            
            
            return dic }
    }
    
}

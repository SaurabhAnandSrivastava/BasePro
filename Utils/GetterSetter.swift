//
//  GetterSetter.swift
//  CFL
//
//  Created by Saurabh Srivastav on 09/08/21.
//

import UIKit

class GetterSetter: NSObject {
    
    
    
    
    static func set(value:Any! , key:String){
        UserDefaults.standard.setValue(value, forKey: key)
       
    }
    static func getString( key:String)-> String{
      
        
        if UserDefaults.standard.value(forKey: key) == nil{
            return ""
        }
        
       return UserDefaults.standard.value(forKey: key)! as! String
    }
    
    static func getValue( key:String)-> Any{
        return UserDefaults.standard.value(forKey: key) as Any
    }
    
    
    static func getBool( key:String)-> Bool{
        return UserDefaults.standard.bool(forKey: key)
    }
}

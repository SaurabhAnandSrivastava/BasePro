//
//  API.swift
//  Frameshop
//
//  Created by Saurabh Srivastav on 27/03/21.
//

import UIKit
import Foundation
//import KeychainSwift
class API: NSObject {
    
    static  func getRequest(url: String ,  completion: @escaping (NSDictionary) -> Void)  {
        
        let request = HttpRequestHeader.getHttpRequest(method: HTTPGET, url: url)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            
            if response == nil {
                let dic = NSMutableDictionary()
                dic["statusCode"] = STATUS_CODE_NO_CONNECTION
                completion(dic)
                return
            }
            
            
            let res = response as! HTTPURLResponse
            
            
            do {
                // make sure this JSON is in the format we expect
                if var json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    
                    
                    switch res.statusCode {
                    case 401:
                        
                        authenticateUser()
                          
                        break
                    default:
                        json["statusCode"] = res.statusCode
                        completion(json as NSDictionary)
                    }
                    
                    
                    
                    
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
            
            
            
        })
        
        task.resume()
    }
    
    
    static  func delRequest(url: String ,  completion: @escaping (NSDictionary) -> Void)  {
        
        let request = HttpRequestHeader.getHttpRequest(method: HTTPDELETE, url: url)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            
            if response == nil {
                let dic = NSMutableDictionary()
                dic["statusCode"] = STATUS_CODE_NO_CONNECTION
                completion(dic)
                return
            }
            
            
            let res = response as! HTTPURLResponse
            
            
            do {
                // make sure this JSON is in the format we expect
                if var json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    
                    
                    switch res.statusCode {
                    case 401:
                        
                        authenticateUser()
                        break
                    default:
                        json["statusCode"] = res.statusCode
                        completion(json as NSDictionary)
                    }
                    
                    
                    
                    
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
            
            
            
        })
        
        task.resume()
    }
    
    
    
    static func authenticateUser(){
        
        DispatchQueue.main.async {
//            OpenScreenScript.openAuthAsRoot()
        }
        

        
    }
    
    static  func postRequest(url: String , dataPacket: NSDictionary,  completion: @escaping (NSDictionary) -> Void)  {
        
        let request = HttpRequestHeader.getHttpRequest(method: HTTPPOST, url: url)
        
        
        do {
            
            let postData = try JSONSerialization.data(withJSONObject: dataPacket as NSDictionary, options: .prettyPrinted)
            
            request.httpBody = postData
            request.addValue("\(postData.count)", forHTTPHeaderField: "Content-Length")
            
        } catch let parsingError {
            print("Error", parsingError)
        }
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
            
            if response == nil {
                let dic = NSMutableDictionary()
                dic["statusCode"] = STATUS_CODE_NO_CONNECTION
                completion(dic)
                return
            }
            
            let res = response as! HTTPURLResponse
            
            
            do {
                // make sure this JSON is in the format we expect
                if var json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    
                    
                    switch res.statusCode {
                    case 401:
                        
                        authenticateUser()
                          
                        break
                    default:
                        json[STATUS_CODE] = res.statusCode
                        completion(json as NSDictionary)
                    }
                    
                    
                    
                    
                    
                    
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
            
            
            
        })
        
        task.resume()
        
    }
    
    
    static  func uploadImage(url: String , image:UIImage, imageId:String, type:String , completion: @escaping (NSDictionary) -> Void)  {
        
        let request = HttpRequestHeader.getHttpRequestForImageUpload(method: HTTPPOST, image: image, type: type, imageId: imageId, url: url)
        
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest,  completionHandler: { (data, response, error) in
            let res = response as! HTTPURLResponse
            
            
            do {
                // make sure this JSON is in the format we expect
                if var json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                    
                    switch res.statusCode {
                    case 401:
                        
                        authenticateUser()
                          
                        break
                    default:
                        json[STATUS_CODE] = res.statusCode
                        completion(json as NSDictionary)
                    }
                    
                    
                    
                }
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
            }
            
            
            
            
        })
       
        task.resume()
        
        
        
      
        
       
        
        
        
        
    }
    
//    static  func sugPostRequest(url: String , dataPacket: NSDictionary,  completion: @escaping (NSDictionary) -> Void)  {
//        
//        let request = HttpRequestHeader.getSugPostRequest(method: HTTPPOST, url: url)
//        
//        
//        do {
//            
//            let postData = try JSONSerialization.data(withJSONObject: dataPacket as NSDictionary, options: .prettyPrinted)
//            
//            request.httpBody = postData
//            request.addValue("\(postData.count)", forHTTPHeaderField: "Content-Length")
//            
//        } catch let parsingError {
//            print("Error", parsingError)
//        }
//        
//        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) in
//            let res = response as! HTTPURLResponse
//            
//            
//            do {
//                // make sure this JSON is in the format we expect
//                if var json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
//                    
//                    
//                    json[STATUS_CODE] = res.statusCode
//                    completion(json as NSDictionary)
//                    
//                    
//                }
//            } catch let error as NSError {
//                print("Failed to load: \(error.localizedDescription)")
//            }
//            
//            
//            
//            
//        })
//        
//        task.resume()
//        
//    }
    
    
//    static  func genrateUniqeId() -> String {
//        let keyChain = KeychainSwift()
//        let uuid: CFUUID = CFUUIDCreate(nil)
//        let cfStr: CFString = CFUUIDCreateString(nil, uuid)
//        
//        let swiftString: String = cfStr as String
//        
//        let appName = Bundle.main.bundleIdentifier
//        
//        if (keyChain.get(appName!)) != nil {
//            print("Contains a value!")
//        } else {
//            keyChain.set(swiftString, forKey: appName!)
//        }
//        
//        
//        
//        return keyChain.get(appName!)! as String
//        
//        
//        
//        
//    }
    
    static func getJsonString(json: Any, prettyPrinted: Bool = false) -> String {
        var options: JSONSerialization.WritingOptions = []
        if prettyPrinted {
            options = JSONSerialization.WritingOptions.prettyPrinted
        }
        
        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: options)
            if let string = String(data: data, encoding: String.Encoding.utf8) {
                return string
            }
        } catch {
            print(error)
        }
        
        return ""
    }
    
    
    
    
}

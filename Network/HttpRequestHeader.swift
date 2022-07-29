//
//  HttpRequestHeader.swift
//  Frameshop
//
//  Created by Saurabh Srivastav on 27/03/21.
//

import UIKit
//import KeychainSwift
class HttpRequestHeader: NSObject {
   static func getHttpRequest(method: String , url : String) -> NSMutableURLRequest {
        //let keychain = KeychainSwift()
        let api_url = URL(string: url)
        
   
    
        let customUserAgent = "FrameShopiOS/\(((Bundle.main.infoDictionary!) as NSDictionary)["CFBundleShortVersionString"] as! String).\((((Bundle.main.infoDictionary!) as NSDictionary)["CFBundleVersion"] as! String))"
        
        
        let request = NSMutableURLRequest(url: api_url!)
            request.httpMethod = method
        
       if GetterSetter.getString(key: TOKEN).isEmpty {
           GetterSetter.set(value: " ", key: TOKEN)
       }
       
       
       
        request.addValue(GetterSetter.getString(key: TOKEN), forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(customUserAgent, forHTTPHeaderField: "User-Agent")
        request.timeoutInterval = 60
        
     return request
        
        
    }
    
    static func getHttpRequestForImageUpload(method: String ,image:UIImage,type:String, imageId:String, url : String) -> NSMutableURLRequest {
        
         let api_url = URL(string: url)
         
    
     
         let customUserAgent = "FrameShopiOS/\(((Bundle.main.infoDictionary!) as NSDictionary)["CFBundleShortVersionString"] as! String).\((((Bundle.main.infoDictionary!) as NSDictionary)["CFBundleVersion"] as! String))"
         
         
         let request = NSMutableURLRequest(url: api_url!)
             request.httpMethod = method
         
        if GetterSetter.getString(key: TOKEN).isEmpty {
            GetterSetter.set(value: " ", key: TOKEN)
        }
        
        
        let imageData = image.pngData()
        
        
        var body = Data()
        let boundary = "---------------------------14737809831466499882746641449"
        
        
        let contentType = "multipart/form-data; boundary=\(boundary)"
               request.addValue(contentType, forHTTPHeaderField: "Content-Type")

        
        request.addValue(customUserAgent, forHTTPHeaderField: "User-Agent")
        
        
        if let data = "--\(boundary)\r\n".data(using: .utf8) {
            body.append(data)
        }
        
        
        
        
        
        if let data = "Content-Disposition: form-data; name=\"image\"; filename=\"\(imageId).png\"\r\n".data(using: .utf8) {
            body.append(data)
        }
        
        
        if let data = "Content-Type: application/octet-stream\r\n\r\n".data(using: .utf8) {
            body.append(data)
        }
        
        
        body.append(imageData!)
        
        
        
        if let data = "\r\n".data(using: .utf8) {
            body.append(data)
        }
        if let data = "--\(boundary)\r\n".data(using: .utf8) {
            body.append(data)
        }
        
        
        
        if let data = "Content-Disposition: form-data; name=\"order_id\"\r\n\r\n".data(using: .utf8) {
            body.append(data)
        }
        if let data = imageId.data(using: .utf8) {
            body.append(data)
        }
        if let data = "\r\n".data(using: .utf8) {
            body.append(data)
        }
        if let data = "--\(boundary)\r\n".data(using: .utf8) {
            body.append(data)
        }
        
        if let data = "Content-Disposition: form-data; name=\"media_type\"\r\n\r\n".data(using: .utf8) {
            body.append(data)
        }
        if let data = type.data(using: .utf8) {
            body.append(data)
        }
        if let data = "\r\n".data(using: .utf8) {
            body.append(data)
        }
        if let data = "--\(boundary)--\r\n".data(using: .utf8) {
            body.append(data)
        }
        
        
        
        request.httpBody = body
        request.addValue(GetterSetter.getString(key: TOKEN), forHTTPHeaderField: "Authorization")
        
        request.addValue(String(format: "%lu", UInt(body.count)), forHTTPHeaderField: "Content-Length")
        
        
        
        
        
        
//         request.addValue(keychain.get(TOKEN)!, forHTTPHeaderField: "Authorization")
//         request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//         request.addValue("application/json", forHTTPHeaderField: "Accept")
        
         request.timeoutInterval = 3600
         
      return request
         
         
     }
    
    
   
    
//    static func getSugPostRequest(method: String , url : String) -> NSMutableURLRequest {
//         //let keychain = KeychainSwift()
//         let api_url = URL(string: url)
//         
//         let request = NSMutableURLRequest(url: api_url!)
//             request.httpMethod = method
//
//       
//        let authString = "Basic \(encodeStringTo64("\(MASTERSOFT_API_USER):\(MASTERSOFT_API_PASSWORD)") ?? "")"
//         request.addValue(authString, forHTTPHeaderField: "Authorization")
//         request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//         request.addValue("application/json", forHTTPHeaderField: "Accept")
//         //request.addValue(customUserAgent, forHTTPHeaderField: "User-Agent")
//         request.timeoutInterval = 120
//         
//      return request
//         
//         
//     }
//    
    static func encodeStringTo64(_ fromString: String?) -> String? {
       
        return Data(fromString!.utf8).base64EncodedString()
       }
}

//
//  facebbokLoginScript.swift
//  fsNew
//
//  Created by Saif on 10/01/22.
//

//MARK: How to Use
/* install these pods before using this script
 pod 'FacebookCore'
 pod 'FacebookLogin'
 */
//import Foundation
//
//import FBSDKLoginKit
//import FBSDKCoreKit
//
//
//enum FbResult : String {
//    case success = "fbSuccess"
//    
//    case fail = "fbFail"
//}
//
//
//struct ImageData: Decodable {
//    let height: Double
//    let source: String?
//    let width: Double
//}
//struct PhotoData: Decodable {
//    let picture: String
//    let images: [ImageData]
//    let id: String?
//}
//struct FbAlbumData: Decodable {
//    let data: [PhotoData]
//    let paging: Paging
//    
//}
//
//struct Paging: Decodable {
//    let cursors: Cursors
//    let next: String?
//}
//struct Cursors: Decodable {
//    let before: String?
//    let after: String?
//}
//
//struct FbAlbum: Decodable {
//    let data: [AlbumData]
//    let paging: Paging
//    
//}
//struct FbUser: Decodable {
//    let name: String?
//    let id: String?
//    let email: String?
//}
//struct AlbumData: Decodable {
//    let name: String
//    let count:Int
//    let picture: PictureData
//    let id: String
//}
//struct PictureData: Decodable {
//    let data: ImgData
//    
//}
//
//struct ImgData: Decodable {
//    let is_silhouette: Bool
//    let url: String
//}
//
//class FacebookScript:NSObject{
//    
//    
//    typealias LoginHandler = (_ success:FbResult) -> Void
//    typealias AlbumPhotoHandler = (_ photos:FbAlbumData?,_ success:FbResult?) -> Void
//    typealias AlbumHandler = (_ albums:FbAlbum?,_ success:FbResult?) -> Void
//    
//    typealias UserHandler = (_ userInfo:FbUser?,_ success:FbResult?) -> Void
//    
//    
//    static func loginWithFb(completionHandler: @escaping(LoginHandler)){
//        Settings.appID = "708402420217169"
//        Settings.displayName = "Fur Eternity"
//        AccessToken.current = nil
//        if (AccessToken.current == nil){
//            let loginManager = LoginManager()
//            loginManager.logIn(permissions: ["public_profile","email" ], from: nil) { result, error in
//                
//                var status = FbResult.success
//                
//                if let error = error {
//                    print("FbError:\(error)")
//                    status = .fail
//                } else if let result = result, result.isCancelled {
//                    status = .fail
//                } else {
//                    status = .success
//                }
//                
//                
//                completionHandler(status)
//            }
//        }
//        else{
//            
//        }
//        
//        
//    }
//    
//    
//    static func getJsonString(json: Any, prettyPrinted: Bool = false) -> String {
//        var options: JSONSerialization.WritingOptions = []
//        if prettyPrinted {
//            options = JSONSerialization.WritingOptions.prettyPrinted
//        }
//        
//        do {
//            let data = try JSONSerialization.data(withJSONObject: json, options: options)
//            if let string = String(data: data, encoding: String.Encoding.utf8) {
//                return string
//            }
//        } catch {
//            print(error)
//        }
//        
//        return ""
//    }
//    
//    
//    static func getUserDetails(completionHandler:  @escaping(UserHandler)){
//        
//        let request = GraphRequest(graphPath: "me")
//        request.start { Cont, arrImg, err in
//            if let _ = arrImg{
//                
//                
//                let json = FacebookScript.json(from: arrImg as Any)
//                let jsonData = json!.data(using: .utf8)!
//                
//                
//                let blogPost: FbUser = try! JSONDecoder().decode(FbUser.self, from: jsonData)
//                
//                
//                completionHandler(blogPost,FbResult.success)
//                
//                
//                
//            }else{
//                completionHandler(nil,FbResult.fail)
//            }
//        }
//        
//        
//    }
//    
//    
//    
//    static func getFbAlbums(completionHandler:  @escaping(AlbumHandler)){
//        
//        let request = GraphRequest(graphPath: "me/albums", parameters: ["fields":"name,picture.type(album),count"])
//        request.start { Cont, arrImg, err in
//            if let _ = arrImg{
//                
//                
//                let json = FacebookScript.json(from: arrImg as Any)
//                let jsonData = json!.data(using: .utf8)!
//                let blogPost: FbAlbum = try! JSONDecoder().decode(FbAlbum.self, from: jsonData)
//                
//                
//                completionHandler(blogPost,FbResult.success)
//                
//                
//                
//            }else{
//                completionHandler(nil,FbResult.fail)
//            }
//        }
//        
//        
//    }
//    
//    
//    
//    static func isFbLoogedIn()->Bool{
//        if (AccessToken.current == nil){
//            return false
//        }
//        else{
//            return true
//        }
//    }
//    
//    
//    
//    
//    static  func json(from object:Any) -> String? {
//        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
//            return nil
//        }
//        return String(data: data, encoding: String.Encoding.utf8)
//    }
//    
//    
//    
//    
//    static func getPhotosFromAlbum(albumId:String,completionHandler:  @escaping(AlbumPhotoHandler)){
//        
//        let request = GraphRequest(graphPath: "\(albumId)/photos?limit=100&",parameters: ["fields":"picture,images"])
//        request.start { Cont, arrImg, err in
//            
//            if let error = err {
//                print("FbError:\(error)")
//                
//            }
//            else{
//                if let _ = arrImg{
//                    
//                    let json = FacebookScript.json(from: arrImg as Any)
//                    
//                    let jsonData = json!.data(using: .utf8)!
//                    let blogPost: FbAlbumData = try! JSONDecoder().decode(FbAlbumData.self, from: jsonData)
//                    
//                    
//                    completionHandler(blogPost,FbResult.success)
//                }else{
//                    completionHandler(nil,FbResult.fail)
//                }
//            }
//        }
//        
//        
//    }
//    
//    
//    static func getNextPhotosFromAlbum(albumId:String,nextCursor:String, completionHandler:  @escaping(AlbumPhotoHandler)){
//        
//        let request = GraphRequest(graphPath: "\(albumId)/photos?fields=images%2Cpicture&after=\(nextCursor)&limit=100")
//        request.start { Cont, arrImg, err in
//            
//            if let error = err {
//                print("FbError:\(error)")
//                
//            }
//            else{
//                if let _ = arrImg{
//                    
//                    
//                    
//                    let json = FacebookScript.json(from: arrImg as Any)
//                    
//                    let jsonData = json!.data(using: .utf8)!
//                    let blogPost: FbAlbumData = try! JSONDecoder().decode(FbAlbumData.self, from: jsonData)
//                    
//                    
//                    completionHandler(blogPost,FbResult.success)
//                }else{
//                    completionHandler(nil,FbResult.fail)
//                }
//            }
//        }
//        
//        
//    }
//    
//}
//
//

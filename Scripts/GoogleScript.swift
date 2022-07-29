//
//  GoogleScript.swift
//  CFL
//
//  Created by Saurabh Srivastav on 21/09/21.
//
/* ======================================= uncomment =============================*/
//import UIKit
//
//import GoogleSignIn
//private let GOOGLE_CLIENT_ID = "148205065060-i8hrs1mfmvafkpocrs54dgurrerbgjag.apps.googleusercontent.com"
//struct GoogleUser: Codable {
//
//    var name: String?
//    var email :String?
//
//
//}
//
//
//class GoogleScript: NSObject {
//    typealias CompletionHandler = (_ success:Bool,_ token:String,_ user:Any) -> Void
//
//  static  func googleSignCall(with viewCont: UIViewController ,completionHandler: @escaping( CompletionHandler)) {
//           // fooHandler?(integer)
//        let clientID = GOOGLE_CLIENT_ID
//
//        // Create Google Sign In configuration object.
//        let config = GIDConfiguration(clientID: clientID)
//
//        // Start the sign in flow!
//        GIDSignIn.sharedInstance.signIn(with: config, presenting: viewCont) { [unowned viewCont] user, error in
//
//            if error != nil {
//            // ...
//            completionHandler(false,"","")
//          //  return
//          }
//
//          guard
//            let authentication = user?.authentication,
//            let idToken = authentication.idToken
//          else {
//            completionHandler(false,"","")
//            return
//          }
//            var gUser = GoogleUser()
//            gUser.email = user?.profile?.email
//            gUser.name = user?.profile?.name
//
//            completionHandler(true, idToken, gUser as Any)
//        }
//  }
//}

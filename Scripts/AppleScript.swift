//
//  AppleScript.swift
//  FurEternity
//
//  Created by Saurabh on 30/05/22.
//

import UIKit
import AuthenticationServices
class AppleScript: NSObject {
    static var authorizationController : ASAuthorizationController!
    static func signInWithApple(baseViewController:UIViewController){
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        authorizationController = ASAuthorizationController(authorizationRequests: [request])
       // authorizationController.delegate = (baseViewController)
        authorizationController.performRequests()
       
    }
 
    //PUT THIS ON YOUR VIEW CONTROLLER
    
    
    
    
/*    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
    if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
    let userIdentifier = appleIDCredential.user
    let fullName = appleIDCredential.fullName
    let email = appleIDCredential.email
    print("User id is \(userIdentifier) \n Full Name is \(String(describing: fullName)) \n Email id is \(String(describing: email))") }
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    // Handle error.
        showLoader(shouldShow: false)
    }
    
}
*/
}

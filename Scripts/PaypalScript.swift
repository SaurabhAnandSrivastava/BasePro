//
//  PaypalScript.swift
//  fsNew



// MARK: - Use //
//PayPalScript.shared.showDropIn(clientTokenOrTokenizationKey: BRAINTREE_API_LIVE, viewController: self,amount:"40") { isSuccess, dataCollector, nonce in
//    if isSuccess{
//    print(dataCollector,nonce)
//    }
//}


//
//let PAY_PAL_CLIENT_ID = "ASGC51kdwj0UHNGbKX-zec8oqcWY8VxL13Uldprpa2CgSjaKXDmwSCbKeim1W6zmZduM7pi7rUYdjGEb"
//let BRAINTREE_API_LIVE = "sandbox_ktwwn7dv_vnf2487f6m4dx263"
//
//import Foundation
//import BraintreeDropIn
////import Alamofire
//
//class PayPalScript{
//    static let shared = PayPalScript()
//
//    func showDropIn(clientTokenOrTokenizationKey: String,viewController:UIViewController,amount :String ,completion: @escaping (Bool,String?, String?)-> Void) {
//        let request =  BTDropInRequest()
//
//
//        let p = BTPayPalCheckoutRequest.init(amount: amount)
//        p.currencyCode = "AUD"
//        request.payPalRequest =  p
//        //let paypalRequest = BTPayPalRequest(amount: "\(26 + Int(str.replacingOccurrences(of: "$", with: "")) ?? 0)")
//        let dropIn = BTDropInController(authorization: clientTokenOrTokenizationKey, request: request)
//        { (controller, result, error) in
//            if (error != nil) {
//                print("ERROR")
//                completion(false,nil,nil)
//            } else if (result?.isCanceled == true) {
//                print("CANCELED")
//                completion(false,nil,nil)
//            } else if let _ = result {
//               // let apiCl = BTAPIClient.init(authorization: clientTokenOrTokenizationKey)
//                let dataCollector = PPDataCollector.collectPayPalDeviceData()
//                print(dataCollector )
//                //result?.paymentMethod?.nonce
//                completion( true,dataCollector, result?.paymentMethod?.nonce)
//
//                //dataCollector.collectPayPalDeviceData()
//            }
//            controller.dismiss(animated: true, completion: nil)
//        }
//        viewController.present(dropIn!, animated: true, completion: nil)
//    }
//}

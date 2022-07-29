//
//  APIConstant.swift
//  Frameshop
//
//  Created by Saurabh Srivastav on 27/03/21.
//

import Foundation

let HTTPGET = "GET"
let HTTPDELETE = "DELETE"
let HTTPPOST = "POST"
let API_TOKEN = "API_TOKEN"
let STATUS_CODE = "statusCode"
let STATUS_CODE_UNAUTHENTICATE = 203
let STATUS_CODE_WRONG_DATA = 201
let STATUS_CODE_DATA_NOT_FOUND = 404
let STATUS_CODE_SUCCESS = 200
let STATUS_CODE_NO_CONNECTION = 867
let STATUS_CODE_PARSING_ERROR = 967
let SERVER_ADDRESS = "https://fureternity.synchsoft.in/api/"
//let SERVER_ADDRESS  = "https://infinity.frameshop.com.au/api/"



let LOGIN_USER = "login"
let REGISTER_USER = "register"
let POPULAR_CHAR = "popular_character"
let OWN_CHAR = "owncharacters"
let FORGOT_PASS = "forgot"
let OTP_VERI = "verify"
let RESET_PASS = "updatepassword"
let MARKET_PLACE = "show_market"
let BUY_CHAR = "buychars"
let SELL_CHAR = "sellchars"
let REMOVE_CHAR = "removesell"


let USER_PROFILE = "getProfile"
let OPPONENT = "opponent"
let BATTLE = "arena"
let POWERUP_LIST = "powerup"
let RANDOM_CHAR_LIST = "generaterandomchar"
let COMBINE_CHAR = "combine"
let COST_CHAR = "charscost"

let TOKEN = "TOKEN"

let GET_FRAMES_OF_CATEGORY_API = "category"
let GET_METABOARDS_API = "matboards/all-matboards"
let PRODUCT_API = "products"
let FRAMES_CATEGORY_API = "frames/all-frames"
let GET_GIFTCARDS_API = "giftcard/gift-cards"
let SEARCH_FRAMES_API = "frame/search/"
let GET_PRICE_API = "price-calculator"
let ADD_PRODUCT_CART = "cart/add"
let UPLOAD_IMAGE  = "uploads/image-upload"
let GET_CART_ITEMS = "cart/list"
let CHANG_QUANTITY  = "cart/adjustments"
let DEL_CART_ITEMS  = "cart/delete/"
let GET_GIFTCARDS   = "giftcard/gift-cards"
let ADD_GIFTCARDS_CART = "cart/add"



let ADD_SHIPPING_ADDRESS = "address/shipping-address"
let GET_SHIPPING_ADDRESS = "address/get-shipping-address"
let DEL_SHIPPING_ADDRESS = "address/delete-shipping-address/"
let EDIT_SHIPPING_ADDRESS = "address/shipping-address"
let GET_SHIPPING_ADDRESS_ID = "address/shipping-address/"




let REQ_TRANSACTION_ID  = "order/request-transaction-identifier"
let CHECK_COUPON        = "promocode/apply-promocode"
let COMPLETE_PAYMENT    = "transaction/charge"
let REQUEST_INVOICE     = "order/request-invoice/"

let GET_ORDER_HOSTORY   = "order/history"

let ENV     = "production"
//let ENV     = "live"

struct User: Codable{
    var end_user:UserDetail?
    
    var name: String?
    var token: String?
    var access_token: String?
    //var completed: Bool
}

struct UserDetail: Codable{
    var id: Int?
    var email: String?
    var name: String?
    
    
    //var completed: Bool
}


struct LogInModel: Codable{
    var error: String?
    var statusCode: Int?
    var message: String?
    var email: String?
    var password: String?
    
    var data: User?
    var postDatadictionary: [String: Any] {
        return ["email": email as Any,
                "password": password as Any
        ]
    }
    var nsDictionary: NSDictionary {
        return postDatadictionary as NSDictionary
    }
    
}

struct SignUpModel: Codable{
    var error: String?
    var statusCode: Int?
    var message: String?
    var email: String?
    var password: String?
    var name: String?
    var c_password: String?
    
    var postDatadictionary: [String: Any] {
        return ["email": email as Any,
                "password": password as Any,
                "c_password": c_password as Any,
                "name": name as Any
        ]
    }
    var nsDictionary: NSDictionary {
        return postDatadictionary as NSDictionary
    }
    
}

extension Encodable {
  var dictionary: [String: Any]? {
    guard let data = try? JSONEncoder().encode(self) else { return nil }
    return (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)).flatMap { $0 as? [String: Any] }
  }
}

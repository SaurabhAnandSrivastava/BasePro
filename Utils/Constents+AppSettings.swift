//
//  Constents+AppSettings.swift
//  CFL
//
//  Created by synchsofthq on 18/07/21.
//

import Foundation
import UIKit





let APP_COLOR = "#800080"
let APP_TEXT_COLOR = "#315169"
let APP_PLACEHOLDER_COLOR = "#B9B9B9"
let APP_SEARCH_UNDERLINE_COLOR = "#315169"
let APP_UICOLOR = UIColor(hexaRGB: APP_COLOR)!

let FONT_BOLD = "Poppins-Bold"
let FONT_MEDIUM = "Poppins-Medium"
let FONT_REG = "Poppins-Regular"
let FONT_LIGHT = "Poppins-Light"
let FONT_SEMIBOLD = "Comfortaa-SemiBold"

let MAIN_SCREEN = UIScreen.main.bounds
let MEDIUM_FONT_SIZE = 22
let APP_GREEN_COLOR = UIColor(hexaRGB: "#27AE60")!
let INSTA_TOKEN = "instAccessToken"
let  INSTAGRAM_BASE_URL = "https://api.instagram.com/oauth/authorize"
let  INSTA_CLIENT_ID = "509472543333532"
let  INSTA_CALL_BACK = "https://www.frameshop.com.au/"
let  INSTAGRAM_SCOPE = "&scope=user_profile,user_media"
let  INSTAGRAM_RESPONSE = "&response_type="
let  INSTAGRAM_GET_MEDIA_URL  = "https://graph.instagram.com/%@?fields=id,username&access_token=%@"
let CLIENT_SECRET = "6d905a0625d3234205f93e3d03004843"

let OTP_NUMBER_FORMAT = "X"

let PLACEHOLDER_UICOLOR = UIColor(hexaRGB: APP_PLACEHOLDER_COLOR)!
let SEARCH_UNDERLINE_COLOR = UIColor(hexaRGB: APP_SEARCH_UNDERLINE_COLOR)!
let PHONE_NUMBER_FORMAT = "XXX-XXX-XXXX"
let PRODUCT_TYPE_FRAME = "product_frame"
let PRODUCT_TYPE_FRAME_SUMMARY = "product_frame_summary"
let PRODUCT_TYPE_ACR = "product_acr"
let PRODUCT_TYPE_CANV = "product_canv"

//MAIL SETTING
let TO_EMAIL = "support@frameshop.com.au"
let SUBJECT_EMAIL = "Query for Frameshop App"

let TEXT_APPEND_MORE = "More"

let HOME = "HomeViewController"
let MARKET = "MarketViewController"
let PROFILE = "ProfileViewController"




//MAT SETTING
let ALERT_TITLE = "Fur Eternity"
let TOPMAT_MIN_ALERT = "Mininum Top Mat Width is 2.5 cm or 1 inch"
let TOPMAT_MAX_ALERT = "Max Top Mat Width is 20 cm or 8 inch"
let DOUBLEMAT_MIN_ALERT  = "Mininum Double Mat Width is 0.5 cm or 0.2 inch"
let DOUBLEMAT_MAX_ALERT  = "Max Double Mat Width is 5 cm or 2 inch"
let FB_FAIL_ALERT  = "Could not connect to Facebook.\nPlease try again."
let LOW_RESOLUTION_IMAGE = "The image you have selected is of Low Resolution, please select another Image for better printing."
//CALL
let CALLING_NUMBER = "0297506055"

//PRODUCT
let PRODUCT_TYPE = "productType"

//PHOTOS
let TYPE_FB = "fb"
let TYPE_IG = "ig"
let TYPE_DV = "device"

// ADDRESS SCREEN
let FIRST_NAME_PLACEHOLDER = "Enter first name *"
let LAST_NAME_PLACEHOLDER = "Enter last name *"
let FIRST_NAME_TITLE = "First Name"
let LAST_NAME_TITLE = "Last Name"
let MOB_PLACEHOLDER = "Enter mobile number *"
let MOB_TITLE = "Mobile Name"
let COM_PLACEHOLDER = "Company name"
let COM_TITLE = "Company Name(optional)"
let STREET_PLACEHOLDER = "Street address *"
let STREET_TITLE = "Street Address"
let SUB_PLACEHOLDER = "Subrbs"
let SUB_TITLE = "Suburb,State,Postcode"


let CART_DETAIL = "CartDetailViewController"
let MENU_SCREEN = "MenuViewController"

let STORYBOARD_NAME = "Main"

//LOADERS
let WHITE_LOADER = "whiteLoader"
let GRAY_LOADER = "grayLoader"
let WIN = "win"
let LOST = "lose"

//Lotties
let EMPTY_LOTTIE = "empty"
let CLOSED = "closed"
let NO_NET = "nonet"
//URLS
let TERMS_AND_CONDITION_URL = "https://infinity.frameshop.com.au/term-conditions"
let PRIVACY_URL = "https://infinity.frameshop.com.au/privacy"

let TEXT_UICOLOR = UIColor(hexaRGB: APP_TEXT_COLOR)!
let TOGGLE_SPEED = 0.2



let EMAIL_REG_EX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{1,64}"
let ANY_TEXT_REG_EX = "[a-zA-Z0-9].*"

let ANY_NUMBER_REG_EX = "^([0-9]+)?(\\.([0-9]{1,2})?)?$"

let PHONE_REG_EX = "[0-9]+[0-9]+[0-9]+[-]+[0-9]+[0-9]+[0-9]+[-]+[0-9]+[0-9]+[0-9]+[0-9]"

// CANVAS VIEW
let MIRROR_TEXT = "Your image will be cloned/ mirrored along the edges of the canvas, this is great for landscapes or scenery shots to have it look like it continues over the edge."
let GALLERY_TEXT = "Your image will continue over the edge of the canvas, some of the content will be lost to the edge of the canvas but will create a flowing continuation of your image."
let COLOR_TEXT = "printed on the face of the canvas and will have a solid colour of your choice wrapped along the edges of the canvas."

//WARNING VIEW

let EMPTY_CART_TEXT = "Looks like your cart is currently empty"
let EMPTY_CART_SUB_TEXT = "Head to the home screen and start creating timeless memories"
let NO_INTERNET_TEXT = "Uh Oh! Looks like you have lost connection."
let NO_INTERNET_IMAGE = "NoInternet"
let EMPTY_CART_IMAGE = "EmptyCart"
let PULL_REFRESH_TEXT = "Pull to try again"

let OOPS_CLOUD_IMAGE = "OppsCloud"
let SERVER_MAINTEANCE_IMAGE = "Maintenance"
let SERVER_MAINTENANC_MSG = "The server is under maintenance, please visit again few moments later."

let WENT_WRONG_MSG = "Something went wrong. Please try again"

let MIN_ADD_CHAR_MSG = "Input must have between 3 and 140 characters"


let SHIPPING_EMAIL = "shipEmail"


//API ALERTS
let UNAUTHENTICATED_USER_TEXT = "The username or password is incorrect!"
let PASSWORD_NOT_MATCH_TEXT = "Password and confirm password does not match!"
let FILL_FIELD_TEXT = "Please fill required fields!"

//EMAIL
let SUPPORT_MAIL = "test@test.com"

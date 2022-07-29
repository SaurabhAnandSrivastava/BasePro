//
//  PopUpManager.swift
//  FurEternity
//
//  Created by Saurabh on 23/05/22.
//


import Foundation
enum PopUpType : String {
    case newCh = "newCh"
    case matchResult = "matchResult"
    case buy = "buy"
    case sell = "sell"
    case moneyConversion = "moneyConversion"
    case tokenConversion = "tokenConversion"
    case moneyWithdraw = "moneyWithdraw"
    case tokenPurchase = "tokenPurchase"
    case removeFromSell = "rsell"
}
class PopUpManager{
    static let shared = PopUpManager()
    private init(){}
    var popUpType : PopUpType?
//    var charInfo : Chars?
    public var refreshChar:(()->())?
    public var refreshWallet:(()->())?
    public var refreshMarket:(()->())?
    public var closePopUp:(()->())?
}

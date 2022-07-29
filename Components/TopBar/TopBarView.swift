//
//  TopBarView.swift
//  FurEternity
//
//  Created by Saurabh on 08/05/22.
//

import UIKit

class TopBarView: UIView {
    
    @IBOutlet weak var walletBtn: UIButton!
    @IBOutlet weak var money: CustomLbl!
    @IBOutlet weak var token: CustomLbl!
//    @IBOutlet weak var loaderView: LottieAnimation!
    @IBOutlet weak var tokenIcon: CustomUiimageView!
    @IBOutlet weak var userName: CustomLbl!
    @IBOutlet weak var titleText: CustomLbl!
    @IBOutlet weak var moneyIcon: CustomUiimageView!
    @IBOutlet weak var profilePic: CustomUiimageView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit(){
        var kCONTENT_XIB_NAME = NSStringFromClass(type(of: self))
        
        let target = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String ?? ""
        
        kCONTENT_XIB_NAME = kCONTENT_XIB_NAME.replacingOccurrences(of: "\(target).", with: "")
        
        let viewFromXib = Bundle.main.loadNibNamed(kCONTENT_XIB_NAME, owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
      //  loaderView.isHidden = true
    }
    
    public var showLoader: Bool! {
        
        set {
            if newValue{
               // loaderView.isHidden = false
                //loaderView.startLottie(lottieFile: GRAY_LOADER)
            }
            else{
               // loaderView.isHidden = true
                //loaderView.stopAnimation()
            }
            
            
        }
        
        get {
           // return loaderView.isHidden
            return true
        }
    }
    
    
}

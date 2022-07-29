//
//  TextFieldView.swift
//  FurEternity
//
//  Created by Saurabh on 17/05/22.
//

import UIKit

class TextFieldView: UIView {

   
    @IBOutlet weak var sideIcon: CustomUiimageView!
    @IBOutlet weak var forgetBtn: CustomBtn!
    @IBOutlet weak var textField: CustomTextField!
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
        forgetBtn.isHidden = true
        
    }

}

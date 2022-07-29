//
//  OtpTextView.swift
//  FurEternity
//
//  Created by Saurabh on 28/05/22.
//

import UIKit

class OtpTextView: UIView, UITextFieldDelegate {
    
    @IBOutlet weak var otp2: CustomTextField!
    @IBOutlet weak var otp3: CustomTextField!
    @IBOutlet weak var otp4: CustomTextField!
    @IBOutlet weak var otp1: CustomTextField!
    @IBOutlet var backView: UIView!
    @IBOutlet weak var otp5: CustomTextField!
    @IBOutlet weak var otp6: CustomTextField!
    
    @IBOutlet var underlineView1 : UIView!
    @IBOutlet var underlineView2 : UIView!
    @IBOutlet var underlineView3 : UIView!
    @IBOutlet var underlineView4 : UIView!
    @IBOutlet weak var underlineView5: UIView!
    
    @IBOutlet weak var underlineView6: UIView!
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
       textFieldSetting(textField: otp1)
        textFieldSetting(textField: otp2)
        textFieldSetting(textField: otp3)
        textFieldSetting(textField: otp4)
        textFieldSetting(textField: otp5)
        textFieldSetting(textField: otp6)
    }
    
    func deselectAll()  {
        underlineView1.backgroundColor = PLACEHOLDER_UICOLOR
        underlineView2.backgroundColor = PLACEHOLDER_UICOLOR
        underlineView3.backgroundColor = PLACEHOLDER_UICOLOR
        underlineView4.backgroundColor = PLACEHOLDER_UICOLOR
        underlineView5.backgroundColor = PLACEHOLDER_UICOLOR
        underlineView6.backgroundColor = PLACEHOLDER_UICOLOR
        
    }
    
    func textFieldSetting(textField:UITextField)  {

        textField.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        textField.delegate = self
        textField.keyboardType = .numberPad
        
    }
    // MARK: -Textfield delegate
    
    
    public func textFieldDidBeginEditing(_ textField: UITextField){
        
        textField.text = ""
        deselectAll()
        switch textField {
        case otp1:
            underlineView1.backgroundColor = APP_UICOLOR
            break
        case otp2:
            underlineView2.backgroundColor = APP_UICOLOR
            break
        case otp3:
            underlineView3.backgroundColor = APP_UICOLOR
            break
        case otp4:
            underlineView4.backgroundColor = APP_UICOLOR
            break
        case otp5:
            underlineView5.backgroundColor = APP_UICOLOR
            break
            case otp6:
                underlineView6.backgroundColor = APP_UICOLOR
                break
        default:
            underlineView4.backgroundColor = APP_UICOLOR
        }
        
        
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        return true
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        let text = textField.text
        if  text?.count == 1 {
            switch textField{
            case otp1:
                otp2.becomeFirstResponder()
            case otp2:
                otp3.becomeFirstResponder()
            case otp3:
                otp4.becomeFirstResponder()
            case otp4:
                otp5.becomeFirstResponder()
            case otp5:
                otp6.becomeFirstResponder()
            case otp6:
                otp6.resignFirstResponder()
            default:
                break
            }
        }
        if  text?.count == 0 {
            switch textField{
            case otp1:
                otp1.becomeFirstResponder()
            case otp2:
                otp1.becomeFirstResponder()
            case otp3:
                otp2.becomeFirstResponder()
            case otp4:
                otp3.becomeFirstResponder()
            case otp5:
                otp4.becomeFirstResponder()
            case otp6:
                otp5.becomeFirstResponder()
            default:
                break
            }
        }
        else{
            
        }
    }

}

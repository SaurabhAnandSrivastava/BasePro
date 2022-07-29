//
//  CustomTextField.swift
//  fsNew
//
//  Created by Saurabh Srivastav on 17/01/22.
//

import Foundation
import UIKit
@IBDesignable

public class CustomTextField: UITextField ,UITextFieldDelegate {
    var imageView = UIImageView()
    var regExpression = ""
    var isValid = Bool()
    @IBInspectable
    var cornerRadiusBtn: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            
            layer.cornerRadius = newValue
        }
    }
    @IBInspectable  var CustomBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var AppBorderColor:Bool {
        
        get {
           
            return false
        }
        set {
            
            layer.borderColor = UIColor.init(hexaRGB: APP_COLOR)?.cgColor
        }
                
    }
    
    @IBInspectable var BorderColor:UIColor {
        
        get {
           
            return .black
        }
        set {
            
            layer.borderColor = newValue.cgColor
        }
                
    }
    
    @IBInspectable var LeftPadding:CGFloat {
        
        get {
           
            return 0.0
        }
        set {
           
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: self.frame.size.height))
            self.leftView = paddingView
            self.leftViewMode = .always
            
        }
                
    }
    
    @IBInspectable var AppFontNameBoldRegularMedium:String {
        get {
            return self.font!.fontName
        }
        set( fontValue) {
            if  ( fontValue == "B"){
                self.font = UIFont(name: FONT_BOLD, size: self.font!.pointSize)
            }
            else if  ( fontValue == "R"){
                self.font = UIFont(name: FONT_REG, size: self.font!.pointSize)
            }
            else if  ( fontValue == "M"){
                self.font = UIFont(name: FONT_MEDIUM, size: self.font!.pointSize)
            }
            else if  ( fontValue == "L"){
                self.font = UIFont(name: FONT_LIGHT, size: self.font!.pointSize)
            }
            
        }
    }
    
    
    @IBInspectable var ValidRegExpression:String {
        get {
            return ""
        }
        set( value) {
            
            if value != "" {
                regExpression = value
                self.delegate = self

            }
            else{
                regExpression = ""
                self.delegate = nil
                
            }
        }
    }
    
    
    
    @IBInspectable var DoneAccessory: Bool{
           get{
               return false
           }
           set (hasDone) {
               if hasDone{
                   addDoneButtonOnKeyboard()
               }
           }
       }

       func addDoneButtonOnKeyboard()
       {
           let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
           doneToolbar.barStyle = .default

           let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
           let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

           let items = [flexSpace, done]
           doneToolbar.items = items
           doneToolbar.sizeToFit()

           self.inputAccessoryView = doneToolbar
       }

       @objc func doneButtonAction()
       {
           self.resignFirstResponder()
       }
    
    
    func addImageToRight(img: UIImage){
        
        self.rightViewMode = .always
        imageView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        let image = img
        imageView.image = image
        self.rightView = imageView
        
    }
    
    
    public func isValidText()-> Bool{
        let emailRegEx = regExpression
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self.text)
    }
    
    
   private func isValid(expression: String) -> Bool {
        let emailRegEx = expression
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self.text)
    }
    
  public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
      
      let result = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
     
      var img = #imageLiteral(resourceName: "ValidIcon")
      
      if (result.isEmpty)||(!isValidText()){
          img = #imageLiteral(resourceName: "InvalidIcon")
          addImageToRight(img: img)
      }
      else {
          img = #imageLiteral(resourceName: "ValidIcon")
          addImageToRight(img: img)
      }
      
      
      
      
    return true
    
    }

    public func textFieldDidEndEditing(_ textField: UITextField){
        
        if !(textField as! CustomTextField).isValidText() {
            let img = #imageLiteral(resourceName: "InvalidIcon")
            (textField as! CustomTextField).addImageToRight(img: img )
            
        }
        
    }
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.endEditing(true)
        return true
    }
    
}


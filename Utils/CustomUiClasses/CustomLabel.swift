//
//  CustomLabel.swift
//  CFL
//
//  Created by synchsofthq on 19/07/21.
//

import Foundation
import UIKit


@IBDesignable
public class CustomLbl: UILabel {
    
    
   
    var textInsets = UIEdgeInsets.zero {
           didSet { invalidateIntrinsicContentSize() }
       }

    public override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
           let textRect = super.textRect(forBounds: bounds, limitedToNumberOfLines: numberOfLines)
           let invertedInsets = UIEdgeInsets(top: -textInsets.top,
                                             left: -textInsets.left,
                                             bottom: -textInsets.bottom,
                                             right: -textInsets.right)
           return textRect.inset(by: invertedInsets)
       }

    public override func drawText(in rect: CGRect) {
           super.drawText(in: rect.inset(by: textInsets))
       } 
    
    
    @IBInspectable var BgAppColor:Bool {
        get {
            return false
        }
        set( value) {
            if value {
                self.backgroundColor = UIColor.init(hexaRGB: APP_COLOR)
            }
            else{
                self.backgroundColor = self.textColor
            }
        }
    }

    @IBInspectable var RoundCornerRadius:CGFloat {
        get {
            return 0.0
        }
        set( value) {
            layer.masksToBounds = true
            layer.cornerRadius = value
        }
    }
    
   
    
    @IBInspectable var RoundCorner:Bool {
        get {
            return false
        }
        set( value) {
            if value {
                layer.masksToBounds = true
                layer.cornerRadius = self.bounds.height/2
            }
            else{
                layer.cornerRadius = 0
            }
            
        }
    }
    
    
    
    @IBInspectable var PlacehoderTextColor:Bool {
        get {
            return false
        }
        set( value) {
            if value {
                self.textColor = PLACEHOLDER_UICOLOR
            }
            else{
                self.textColor = self.textColor
            }
        }
    }
    
    
    @IBInspectable var PlacehoderBgColor:Bool {
        get {
            return false
        }
        set( value) {
            if value {
                self.backgroundColor = PLACEHOLDER_UICOLOR
            }
            else{
                self.backgroundColor = self.backgroundColor
            }
        }
    }
    
    
    @IBInspectable var GlobalTextColor:Bool {
        get {
            return false
        }
        set( value) {
            if value {
                self.textColor = TEXT_UICOLOR
            }
            else{
                self.textColor = self.textColor
            }
        }
    }
    
    @IBInspectable var AppColorText:Bool {
        get {
            return false
        }
        set( value) {
            if value {
                self.textColor = APP_UICOLOR
            }
            else{
                self.textColor = self.textColor
            }
        }
    }

    
    
    @IBInspectable var AppFontNameBoldRegularMedium:String {
        get {
            return self.font.fontName
        }
        set( fontValue) {
            if  ( fontValue == "B"){
                self.font = UIFont(name: FONT_BOLD, size: self.font.pointSize)
            }
            else if  ( fontValue == "R"){
                self.font = UIFont(name: FONT_REG, size: self.font.pointSize)
               // print("=====>\(self.font.fontName)")
            }
            else if  ( fontValue == "M"){
                self.font = UIFont(name: FONT_MEDIUM, size: self.font.pointSize)
            }
            else if  ( fontValue == "L"){
                self.font = UIFont(name: FONT_LIGHT, size: self.font.pointSize)
            }
            else if  ( fontValue == "SB"){
                self.font = UIFont(name: FONT_SEMIBOLD, size: self.font.pointSize)
            }
            
        }
    }
    
    @IBInspectable
    var AppendMore : Bool {
        get {
            return false
        }
        set{
            if newValue {
                
        
                
                    self.addTrailing(with: "...", moreText: TEXT_APPEND_MORE, moreTextFont: self.font, moreTextColor: PLACEHOLDER_UICOLOR)
                
               

            }
            else{
                self.text = self.text
            }
            
            

            
        }
    }
    
    
    func addTrailing(with trailingText: String, moreText: String, moreTextFont: UIFont, moreTextColor: UIColor) {
        let readMoreText: String = trailingText + moreText

        let lengthForVisibleString: Int = self.vissibleTextLength
        let mutableString: String = self.text!
        let trimmedString: String? = (mutableString as NSString).replacingCharacters(in: NSRange(location: lengthForVisibleString, length: ((self.text?.count)! - lengthForVisibleString)), with: "")
        let readMoreLength: Int = (readMoreText.count)
        let trimmedForReadMore: String = (trimmedString! as NSString).replacingCharacters(in: NSRange(location: ((trimmedString?.count ?? 0) - readMoreLength), length: readMoreLength), with: "") + trailingText
        let answerAttributed = NSMutableAttributedString(string: trimmedForReadMore, attributes: [NSAttributedString.Key.font: self.font as Any])
        let readMoreAttributed = NSMutableAttributedString(string: moreText, attributes: [NSAttributedString.Key.font: moreTextFont, NSAttributedString.Key.foregroundColor: moreTextColor])
        answerAttributed.append(readMoreAttributed)
        self.attributedText = answerAttributed
    }

    var vissibleTextLength: Int {
        let font: UIFont = self.font
        let mode: NSLineBreakMode = self.lineBreakMode
        let labelWidth: CGFloat = self.frame.size.width
        let labelHeight: CGFloat = self.frame.size.height
        let sizeConstraint = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)

        let attributes: [AnyHashable: Any] = [NSAttributedString.Key.font: font]
        let attributedText = NSAttributedString(string: self.text!, attributes: attributes as? [NSAttributedString.Key : Any])
        let boundingRect: CGRect = attributedText.boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, context: nil)

        if boundingRect.size.height > labelHeight {
            var index: Int = 0
            var prev: Int = 0
            let characterSet = CharacterSet.whitespacesAndNewlines
            repeat {
                prev = index
                if mode == NSLineBreakMode.byCharWrapping {
                    index += 1
                } else {
                    index = (self.text! as NSString).rangeOfCharacter(from: characterSet, options: [], range: NSRange(location: index + 1, length: self.text!.count - index - 1)).location
                }
            } while index != NSNotFound && index < self.text!.count && (self.text! as NSString).substring(to: index).boundingRect(with: sizeConstraint, options: .usesLineFragmentOrigin, attributes: attributes as? [NSAttributedString.Key : Any], context: nil).size.height <= labelHeight
            return prev
        }
        return self.text!.count
    }
    
    
}

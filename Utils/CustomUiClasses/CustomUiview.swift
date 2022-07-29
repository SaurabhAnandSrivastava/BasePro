//
//  CustomUiview.swift
//  CFL
//
//  Created by synchsofthq on 19/07/21.
//

import Foundation
import UIKit
@IBDesignable
public class CustomViews: UIView {
    
    
    
    var shouldRoundCorner = false
    
    @IBInspectable var RoundCorner:Bool {
        get {
            return false
        }
        set( value) {
            shouldRoundCorner = value
        }
    }
    public override func layoutSubviews() {
        if shouldRoundCorner {
            layer.cornerRadius = self.bounds.height/2
        }
    }
    
    
    @IBInspectable var RoundCornerRadius:CGFloat {
        get {
            return 0.0
        }
        set( value) {
            layer.cornerRadius = value
        }
    }
    
    
    @IBInspectable var AppColorBg:Bool {
        get {
            return false
        }
        set( value) {
            if value {
                self.backgroundColor = APP_UICOLOR
            }
            else{
                self.backgroundColor = self.backgroundColor
            }
        }
    }
    
    @IBInspectable var GlobalTextColorBg:Bool {
        get {
            return false
        }
        set( value) {
            if value {
                self.backgroundColor = TEXT_UICOLOR
            }
            else{
                self.backgroundColor = self.backgroundColor
            }
        }
    }
    
    @IBInspectable var PlaceholderTextColorBg:Bool {
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
    
    @IBInspectable  var BorderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    
    
    
    
    
    
    @IBInspectable  var BorderColor: UIColor {
        get {
            return UIColor.clear
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var PlacehoderBorderColor:Bool {
        
        get {
            
            return false
        }
        set {
            
            self.layer.borderColor = PLACEHOLDER_UICOLOR.cgColor
        }
        
    }
    

    @IBInspectable
    var cornerRadiusBtn: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    
    
    
}





@IBDesignable class PortholeView: UIView {
    @IBInspectable var innerCornerRadius: CGFloat = 10.0
    @IBInspectable var inset: CGFloat = 20.0
    @IBInspectable var fillColor: UIColor = UIColor.gray
    @IBInspectable var strokeWidth: CGFloat = 5.0
    @IBInspectable var strokeColor: UIColor = UIColor.black
    
    
    override func draw(_ rect: CGRect) {
        // Prep constants
        let roundRectWidth = rect.width - (2 * inset)
        let roundRectHeight = rect.height - (2 * inset)
        
        // Use EvenOdd rule to subtract portalRect from outerFill
        // (See http://stackoverflow.com/questions/14141081/uiview-drawrect-draw-the-inverted-pixels-make-a-hole-a-window-negative-space)
        let outterFill = UIBezierPath(rect: rect)
        let portalRect = CGRect(
            x: rect.origin.x + inset,
            y: rect.origin.y + inset,
            width: roundRectWidth,
            height: roundRectHeight)
        fillColor.setFill()
        let portal = UIBezierPath(roundedRect: portalRect, cornerRadius: innerCornerRadius)
        outterFill.append(portal)
        outterFill.usesEvenOddFillRule = true
        outterFill.fill()
        strokeColor.setStroke()
        portal.lineWidth = strokeWidth
        portal.stroke()
    }
}












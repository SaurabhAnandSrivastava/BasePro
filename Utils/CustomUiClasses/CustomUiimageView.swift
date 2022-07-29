//
//  CustomUiimageView.swift
//  CFL
//
//  Created by synchsofthq on 19/07/21.
//

import Foundation
import UIKit
@IBDesignable
public class CustomUiimageView: UIImageView {
    
   var isRoundCorner = false
    
    
    
    @IBInspectable var RoundCorner:Bool {
        get {
            return false
        }
        set( value) {
            isRoundCorner = value
        }
    }
    public override func layoutSubviews() {
        if isRoundCorner {
            layer.cornerRadius = self.bounds.height/2
        }
       
    }
    
    
    
    @IBInspectable var RadiousCorner:CGFloat {
        get {
            return 0
        }
        set( value) {
            layer.cornerRadius = value
        }
    }
    
    @IBInspectable  var RotateAngle: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            let radians = newValue / 180.0 * CGFloat.pi
            let rotation = self.transform.rotated(by: radians)
                    self.transform = rotation
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
    
    @IBInspectable var BorderColor:UIColor {
        
        get {
           
            return .clear
        }
        set {
            
            self.layer.borderColor = newValue.cgColor
        }
                
    }
    
    @IBInspectable
    var imageTintColor: UIColor {
        get {
            return .clear
        }
        set {
            let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
            self.image = templateImage
            self.tintColor = newValue
        }
    }
    
    @IBInspectable
    var AppTintColor: Bool {
        get {
            return false
        }
        set {
            if newValue {
                let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
                self.image = templateImage
                self.tintColor = APP_UICOLOR
            }
            else{
                let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
                self.image = templateImage
                self.tintColor = self.tintColor
            }
           
        }
    }
    
    
    
    
    
  func setImageTintColor(color: UIColor) {
    let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
    self.image = templateImage
    self.tintColor = color
  }
}


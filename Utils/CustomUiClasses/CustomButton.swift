//
//  CustomButton.swift
//  CFL
//
//  Created by synchsofthq on 19/07/21.
//

import Foundation
import UIKit

@IBDesignable
public class CustomBtn: UIButton {
    
    var isRadio = false
    var groupId = Int(0)
    var btnId = Int(0)
    
    @IBInspectable var RoundCorner:Bool {
        get {
            return false
        }
        set( value) {
            
            if value {
                layer.cornerRadius = self.frame.height/2
            }
            else{
                layer.cornerRadius = 0
            }
        }
    }
    
    @IBInspectable var RadioBtn:Bool {
        get {
            return false
        }
        set( value) {
            
            
            isRadio = value
            self.addTarget(self, action: #selector(bottomAction( _ :)), for: .touchUpInside)
        }
    }
    
    
    @objc func bottomAction(_ sender: Any){
      
        print("half way done group id \(groupId) buttonId \(btnId)")
        
        self.isSelected = false
        
       
        
        
    }
    

    @IBInspectable
    var NormalImage: UIImage {
        get {
            return UIImage()
        }
        set {
            
            self.setImage(newValue, for: .normal)
            
        }
    }
    
    @IBInspectable
    var SelectedImage: UIImage {
        get {
            return UIImage()
        }
        set {
            
            self.setImage(newValue, for: .selected)
            
        }
    }
    
    
    @IBInspectable
    var GroupId: Int {
        get {
            return 0
        }
        set {
            
            groupId = newValue
            
        }
    }
    
    @IBInspectable
    var ButtonId: Int {
        get {
            return 0
        }
        set {
            
            btnId = newValue
            
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
    
    @IBInspectable var AppColorBg:Bool {
        get {
            return false
        }
        set( value) {
            if value {
                self.backgroundColor = UIColor.init(hexaRGB: APP_COLOR)
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
                self.setTitleColor(TEXT_UICOLOR, for: .normal)
                
            }
            else{
                self.setTitleColor( self.titleLabel?.textColor, for: .normal)
                
            }
        }
    }
    
    @IBInspectable var PlaceHolderTextColor:Bool {
        get {
            return false
        }
        set( value) {
            if value {
                self.setTitleColor(PLACEHOLDER_UICOLOR, for: .normal)
                
            }
            else{
                self.setTitleColor( self.titleLabel?.textColor, for: .normal)
                
            }
        }
    }
    
    
    @IBInspectable var ColorTint:UIColor {
        get {
            return self.tintColor
        }
        set( value) {
            
            
            let normalStateImage =  self.image(for: .normal)
            let selectStateImage =  self.image(for: .selected)
            
            
            
            self.setImage( normalStateImage?.maskWithColor(color:  value), for: .normal)
            self.setImage( selectStateImage?.maskWithColor(color:  value), for: .selected)
            
            
        }
        
    }
    
    
    
    
    @IBInspectable var AppColorTint:Bool {
        get {
            return false
        }
        set( value) {
            if value {
                
                let normalStateImage =  self.image(for: .normal)
                let selectStateImage =  self.image(for: .selected)
                
                
                
                self.setImage( normalStateImage?.maskWithColor(color:  UIColor.init(hexaRGB: APP_COLOR)!), for: .normal)
                self.setImage( selectStateImage?.maskWithColor(color:  UIColor.init(hexaRGB: APP_COLOR)!), for: .selected)
                
                
            }
            else{
                self.backgroundColor = self.backgroundColor
            }
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
    
    
    
    @IBInspectable  var CustomBorderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable  var BorderColor: UIColor {
        get {
            return .clear
        }
        set {
            layer.borderColor = newValue.cgColor
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
    
    
    
    @IBInspectable var TextUnderLine:Bool {
        
        get {
            
            return false
        }
        set {
            
            if newValue {
                let yourAttributes: [NSAttributedString.Key: Any] = [
                    .font: self.titleLabel?.font as Any,
                    .foregroundColor: self.titleLabel?.textColor as Any,
                    .underlineStyle: NSUnderlineStyle.single.rawValue
                ] // .double.rawValue, .thick.rawValue
                
                let attributeString = NSMutableAttributedString(
                    string: self.currentTitle!,
                    attributes: yourAttributes
                )
                self.setAttributedTitle(attributeString, for: .normal)
            }
            else{
                self.setTitle(self.titleLabel?.text, for: .normal)
            }
        }
        
    }
    
 
    
    @IBInspectable var AppTextColor:Bool {
        get {
            return false
        }
        set( value) {
            if value {
                self.setTitleColor(APP_UICOLOR, for: .normal)
                
            }
            else{
                self.setTitleColor( self.titleLabel?.textColor, for: .normal)
                
            }
        }
    }
    
    
    
    @IBInspectable var AppFontNameBoldRegularMedium:String {
        get {
            return self.titleLabel!.font.fontName
        }
        set( fontValue) {
            if  ( fontValue == "B"){
                self.titleLabel!.font = UIFont(name: FONT_BOLD, size: self.titleLabel!.font.pointSize)
            }
            else if  ( fontValue == "R"){
                self.titleLabel!.font = UIFont(name: FONT_REG, size: self.titleLabel!.font.pointSize)
            }
            else{
                self.titleLabel!.font = UIFont(name: FONT_MEDIUM, size: self.titleLabel!.font.pointSize)
            }
            
            
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

@IBDesignable
public class GoogleBtn: UIButton{
    @IBInspectable var RoundCorner:Bool {
        get {
            return false
        }
        set( value) {
            
            if value {
                layer.cornerRadius = self.frame.height/2
            }
            else{
                layer.cornerRadius = 0
            }
        }
    }
    
    @IBInspectable var GlobalTextColor:Bool {
        get {
            return false
        }
        set( value) {
            if value {
                self.setTitleColor(TEXT_UICOLOR, for: .normal)
                
            }
            else{
                self.setTitleColor( self.titleLabel?.textColor, for: .normal)
                
            }
        }
    }
    
    @IBInspectable var AppFontNameBoldRegularMedium:String {
        get {
            return self.titleLabel!.font.fontName
        }
        set( fontValue) {
            if  ( fontValue == "B"){
                self.titleLabel!.font = UIFont(name: FONT_BOLD, size: self.titleLabel!.font.pointSize)
            }
            else if  ( fontValue == "R"){
                self.titleLabel!.font = UIFont(name: FONT_REG, size: self.titleLabel!.font.pointSize)
            }
            else{
                self.titleLabel!.font = UIFont(name: FONT_MEDIUM, size: self.titleLabel!.font.pointSize)
            }
            
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

class PulsatingButton: UIButton {
    let pulseLayer: CAShapeLayer = {
        let shape = CAShapeLayer()
        shape.strokeColor = UIColor.clear.cgColor
        shape.lineWidth = 10
        shape.fillColor = UIColor.white.withAlphaComponent(0.3).cgColor
        shape.lineCap = .round
        return shape
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShapes()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupShapes()
    }
    
    fileprivate func setupShapes() {
        setNeedsLayout()
        layoutIfNeeded()
        
        let backgroundLayer = CAShapeLayer()
        
        let circularPath = UIBezierPath(arcCenter: self.center, radius: bounds.size.height/2, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        pulseLayer.frame = bounds
        pulseLayer.path = circularPath.cgPath
        pulseLayer.position = self.center
        self.layer.addSublayer(pulseLayer)
        
        backgroundLayer.path = circularPath.cgPath
        backgroundLayer.lineWidth = 10
        backgroundLayer.fillColor = UIColor.blue.cgColor
        backgroundLayer.lineCap = .round
        self.layer.addSublayer(backgroundLayer)
    }
    
    func pulse() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.2
        animation.duration = 1.0
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        animation.autoreverses = true
        animation.repeatCount = .infinity
        pulseLayer.add(animation, forKey: "pulsing")
    }
}



//
//  CustomSegment.swift
//  VibrationApp
//
//  Created by Saurabh Srivastav on 15/10/21.
//

import Foundation
import UIKit

@IBDesignable
public class CustomSegment: UISegmentedControl{
    let lockImage = CustomUiimageView()
    @IBInspectable var NormalTextColor:UIColor {
        get {
            return UIColor.gray
        }
        set( value) {
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: value]
              self.setTitleTextAttributes(titleTextAttributes, for: .normal)
            
        }
    }
    
    @IBInspectable var SelectedTextColor:UIColor {
        get {
            return UIColor.black
        }
        set( value) {
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: value]
              self.setTitleTextAttributes(titleTextAttributes, for: .selected)
            
        }
    }
    

    
   
 

}

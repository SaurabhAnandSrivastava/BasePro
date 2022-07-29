//
//  CustomSlider.swift
//  VibrationApp
//
//  Created by Saurabh Srivastav on 22/10/21.
//

import Foundation
import UIKit
class CustomSlide: UISlider {

     @IBInspectable var trackHeight: CGFloat = 2

    override func trackRect(forBounds bounds: CGRect) -> CGRect {
         //set your bounds here
        
         return CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: trackHeight))



       }
}

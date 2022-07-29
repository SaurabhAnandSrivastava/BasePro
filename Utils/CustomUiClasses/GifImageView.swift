//
//  GifImageView.swift
//  VibrationApp
//
//  Created by Saurabh Srivastav on 15/10/21.
//

import Foundation
import UIKit
@IBDesignable
public class GifImageView: UIImageView {

    
//    @IBInspectable var GifImagename:String {
//        get {
//            return ""
//        }
//        set( value) {
//            self.loadGif(name: value)
//           // fromGif(frame: self.frame, resourceName: value)
//        }
//    }
    
    
    
    
func fromGif(frame: CGRect, resourceName: String) -> UIImageView? {
       guard let path = Bundle.main.path(forResource: resourceName, ofType: "gif") else {
           print("Gif does not exist at that path")
           return nil
       }
       let url = URL(fileURLWithPath: path)
       guard let gifData = try? Data(contentsOf: url),
           let source =  CGImageSourceCreateWithData(gifData as CFData, nil) else { return nil }
       var images = [UIImage]()
       let imageCount = CGImageSourceGetCount(source)
       for i in 0 ..< imageCount-1 {
           if let image = CGImageSourceCreateImageAtIndex(source, i, nil) {
               
               
             
               
               images.append(UIImage(cgImage: image))
               
           }
       }
       
    var ig = [UIImage]()
    
    for img in images {
        let  imgs = img.scaleImage(toSize: CGSize(width: frame.width, height: frame.height))!
        
        ig.append(imgs)
    }
    
    
    
    self.animationDuration = 1
   // self.animationRepeatCount = .max
    
    
       self.animationImages = ig
   
    self.startAnimating()
       return self
   }
}

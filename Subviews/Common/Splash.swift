//
//  Splash.swift
//  Fur Eternity
//
//  Created by Saurabh on 07/05/22.
//

import UIKit
import Foundation

class Splash: UIView {
    
    @IBOutlet weak var testBtn: UIButton!
    @IBOutlet weak var lottieView: UIView!
    @IBOutlet weak var imageView: UIImageView!
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
        
        imageView.image = UIImage(named: "Logo")?.scaleImageToBaseView(imageView: imageView, multy: 2)
        
        
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [self] in
            startAnimation()
        }
    }
    
    func startAnimation(){
        
        
        //PlaySoundScript.playSound(soundName: "cut", soundExtension: "mp3", loop: 0)
       // SliceViewScript.sliceView(viewTobeSliced: lottieView)
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) { [self] in
            self.removeFromSuperview()
        }
    }
    
   
    


}
extension UIImage {
    
    
    
    func imageByApplyingMaskingBezierPath(_ path: UIBezierPath) -> UIImage {

                UIGraphicsBeginImageContext(self.size)
                let context = UIGraphicsGetCurrentContext()!

                context.addPath(path.cgPath)
                context.clip()
                draw(in: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))

                let maskedImage = UIGraphicsGetImageFromCurrentImageContext()!

                UIGraphicsEndImageContext()

                return maskedImage
            }
    
    public func diagonalCrop(_ points: (a: CGPoint, b: CGPoint), height: CGFloat) -> UIImage {

        let cPoints = computeRectPoints(points, height: height)
        let bounds = boundingRect(cPoints)
        let bboxCropImage = cropImage(self, toRect: bounds)

        let vec = CGPoint(x: points.b.x - points.a.x, y: points.b.y - points.a.y)
        let width = sqrt(vec.x*vec.x + vec.y*vec.y)
        let angle = atan2(vec.y, vec.x)

        let rotatedImage = rotate(bboxCropImage, angle: angle)

        let cropRect = CGRect(origin: CGPoint(x: (rotatedImage.size.width - width)/2,
                                              y: (rotatedImage.size.height - height)/2),
                              size: CGSize(width: width, height: height))

        return cropImage(rotatedImage, toRect: cropRect)
    }

    func cropImage(_ image: UIImage, toRect: CGRect) -> UIImage {

        let cgImage: CGImage = (image.cgImage?.cropping(to: toRect))!

        return UIImage(cgImage: cgImage)
    }

    func computeRectPoints(_ points: (a: CGPoint, b: CGPoint), height: CGFloat) -> (a: CGPoint, b: CGPoint, c: CGPoint, d:CGPoint) {
        let c = computePoint(points, height: height, clockwise: true)
        let d = computePoint(points, height: height, clockwise: false)

        return (a: points.a, b: points.b, c: c, d: d)
    }

    func computePoint(_ points: (a: CGPoint, b: CGPoint), height: CGFloat, clockwise: Bool) -> CGPoint {
        let x = clockwise ? points.b : points.a
        let y = clockwise ? points.a : points.b

        let mult: CGFloat = clockwise ? 1 : -1

        let len = sqrt(pow((x.x - y.x),2) + pow((x.y - y.y),2))

        let cx = x.x + ((height * (y.y - x.y))/len * mult)
        let cy = x.y + ((height * (x.x - y.x))/len * mult)

        return CGPoint(x: cx, y: cy)
    }

    func boundingRect(_ points: (a: CGPoint, b: CGPoint, c: CGPoint, d:CGPoint)) -> CGRect {
        let minX = min(min(points.a.x, points.b.x), min(points.c.x, points.d.x))
        let minY = min(min(points.a.y, points.b.y), min(points.c.y, points.d.y))

        let maxX = max(max(points.a.x, points.b.x), max(points.c.x, points.d.x))
        let maxY = max(max(points.a.y, points.b.y), max(points.c.y, points.d.y))

        return CGRect(x: minX, y: minY, width: maxX-minX, height: maxY-minY)
    }

    func rotate(_ image: UIImage, angle: CGFloat) -> UIImage {
        if let imgRef = image.cgImage {

            let width = imgRef.width
            let height = imgRef.height

            let imgRect = CGRect(x: 0, y: 0, width: width, height: height)
            let transform = CGAffineTransform(rotationAngle:angle)
            let rotatedRect = imgRect.applying(transform)

            if let colorSpace = imgRef.colorSpace {
                let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue).union(CGBitmapInfo.byteOrder32Big)
                if let bmContext = CGContext.init(data: nil,
                                                  width: Int(rotatedRect.size.width),
                                                  height: Int(rotatedRect.size.height),
                                                  bitsPerComponent: 8,
                                                  bytesPerRow: 0,
                                                  space: colorSpace,
                                                  bitmapInfo: bitmapInfo.rawValue) {

                    bmContext.setAllowsAntialiasing(true)
                    bmContext.interpolationQuality = .default
                    bmContext.translateBy(x: rotatedRect.size.width/2, y: rotatedRect.size.height/2)
                    bmContext.rotate(by: angle)
                    bmContext.translateBy(x: -rotatedRect.size.width/2, y: -rotatedRect.size.height/2)
                    bmContext.draw(imgRef, in: CGRect(origin: CGPoint(x: (rotatedRect.size.width - CGFloat(width))/2,
                                                                      y: (rotatedRect.size.height - CGFloat(height))/2),
                                                      size: CGSize(width: width, height: height)))

                    if let cgImage = bmContext.makeImage() {
                        return UIImage.init(cgImage: cgImage)
                    }

                    return image
                }
                return image
            }
            return image
        }
        return image
    }
}

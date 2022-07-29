//
//  UIExtensions.swift
//  CFL
//
//  Created by synchsofthq on 19/07/21.
//

import Foundation
import UIKit
extension UIImage {
    
    
    func fixedOrientation() -> UIImage? {
        guard imageOrientation != UIImage.Orientation.up else {
            // This is default orientation, don't need to do anything
            return self.copy() as? UIImage
        }
        
        guard let cgImage = self.cgImage else {
            // CGImage is not available
            return nil
        }
        
        guard let colorSpace = cgImage.colorSpace, let ctx = CGContext(data: nil, width: Int(size.width), height: Int(size.height), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: colorSpace, bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue) else {
            return nil // Not able to create CGContext
        }
        
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch imageOrientation {
        case .down, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: size.height)
            transform = transform.rotated(by: CGFloat.pi)
        case .left, .leftMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.rotated(by: CGFloat.pi / 2.0)
        case .right, .rightMirrored:
            transform = transform.translatedBy(x: 0, y: size.height)
            transform = transform.rotated(by: CGFloat.pi / -2.0)
        case .up, .upMirrored:
            break
        @unknown default:
            fatalError("Missing...")
            break
        }
        
        // Flip image one more time if needed to, this is to prevent flipped image
        switch imageOrientation {
        case .upMirrored, .downMirrored:
            transform = transform.translatedBy(x: size.width, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .leftMirrored, .rightMirrored:
            transform = transform.translatedBy(x: size.height, y: 0)
            transform = transform.scaledBy(x: -1, y: 1)
        case .up, .down, .left, .right:
            break
        @unknown default:
            fatalError("Missing...")
            break
        }
        
        ctx.concatenate(transform)
        
        switch imageOrientation {
        case .left, .leftMirrored, .right, .rightMirrored:
            ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
        default:
            ctx.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            break
        }
        
        guard let newCGImage = ctx.makeImage() else { return nil }
        return UIImage.init(cgImage: newCGImage, scale: 4, orientation: .up)
    }
    
    func trim() -> UIImage {
        let newRect = self.cropRect
        if let imageRef = self.cgImage!.cropping(to: newRect) {
            return UIImage(cgImage: imageRef)
        }
        return self
    }
    
    var cropRect: CGRect {
        let cgImage = self.cgImage
        let context = createARGBBitmapContextFromImage(inImage: cgImage!)
        if context == nil {
            return CGRect.zero
        }
        
        let height = CGFloat(cgImage!.height)
        let width = CGFloat(cgImage!.width)
        
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        context?.draw(cgImage!, in: rect)
        
        //let data = UnsafePointer<CUnsignedChar>(CGBitmapContextGetData(context))
        guard let data = context?.data?.assumingMemoryBound(to: UInt8.self) else {
            return CGRect.zero
        }
        
        var lowX = width
        var lowY = height
        var highX: CGFloat = 0
        var highY: CGFloat = 0
        
        let heightInt = Int(height)
        let widthInt = Int(width)
        //Filter through data and look for non-transparent pixels.
        for y in (0 ..< heightInt) {
            let y = CGFloat(y)
            for x in (0 ..< widthInt) {
                let x = CGFloat(x)
                let pixelIndex = (width * y + x) * 4 /* 4 for A, R, G, B */
                
                if data[Int(pixelIndex)] == 0  { continue } // crop transparent
                
                if data[Int(pixelIndex+1)] > 0xE0 && data[Int(pixelIndex+2)] > 0xE0 && data[Int(pixelIndex+3)] > 0xE0 { continue } // crop white
                
                if (x < lowX) {
                    lowX = x
                }
                if (x > highX) {
                    highX = x
                }
                if (y < lowY) {
                    lowY = y
                }
                if (y > highY) {
                    highY = y
                }
                
            }
        }
        
        return CGRect(x: lowX, y: lowY, width: highX - lowX, height: highY - lowY)
    }
    
    func createARGBBitmapContextFromImage(inImage: CGImage) -> CGContext? {
        
        let width = inImage.width
        let height = inImage.height
        
        let bitmapBytesPerRow = width * 4
        let bitmapByteCount = bitmapBytesPerRow * height
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let bitmapData = malloc(bitmapByteCount)
        if bitmapData == nil {
            return nil
        }
        
        let context = CGContext (data: bitmapData,
                                 width: width,
                                 height: height,
                                 bitsPerComponent: 8,      // bits per component
                                 bytesPerRow: bitmapBytesPerRow,
                                 space: colorSpace,
                                 bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)
        
        return context
    }
    
    
    
    func withLeftHalfOverlayColor( color: UIColor , widthRatio:CGFloat) -> UIImage
    {
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        
        
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        self.draw(in: rect)
        
        let context = UIGraphicsGetCurrentContext()!
        context.setBlendMode(CGBlendMode.sourceIn)
        
        context.setFillColor(color.cgColor)
        
        
        let rectToFill = CGRect(x: 0, y: 0, width: self.size.width*widthRatio, height: self.size.height)
        context.fill(rectToFill)
        
        let rectToFill2 = CGRect(x: rectToFill.width, y: 0, width: self.size.width-rectToFill.width, height: self.size.height)
        context.setFillColor(UIColor.systemGray6.cgColor)
        context.fill(rectToFill2)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    
    func scaleImageToBaseView(imageView: UIImageView , multy: CGFloat) -> UIImage? {
      
        let size = self.size
        let imageViewSize = imageView.frame.size
        let widthRatio  = imageViewSize.width*multy  / self.size.width
        let heightRatio = imageViewSize.height*multy / self.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        autoreleasepool {
        self.draw(in: rect)
        }
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
    
    
    
    
    
    
    func scaleImage(toSize newSize: CGSize) -> UIImage? {
        let size = self.size
        
        let widthRatio  = newSize.width  / self.size.width
        let heightRatio = newSize.height / self.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        autoreleasepool {
        self.draw(in: rect)
        }
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    func maskWithColor(color: UIColor) -> UIImage? {
        let maskImage = cgImage!
        
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage)
        context.setFillColor(color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return nil
        }
    }
    
    
    
    
    func removeExifData ()-> UIImage {
        let data = self.pngData()
        guard let source = CGImageSourceCreateWithData(data! as CFData, nil) else {
            return self
        }
        guard let type = CGImageSourceGetType(source) else {
            return self
        }
        let count = CGImageSourceGetCount(source)
        let mutableData = NSMutableData(data: data!)
        guard let destination = CGImageDestinationCreateWithData(mutableData, type, count, nil) else {
            return self
        }
        // Check the keys for what you need to remove
        // As per documentation, if you need a key removed, assign it kCFNull
        let removeExifProperties: CFDictionary = [String(kCGImagePropertyExifDictionary) : kCFNull, String(kCGImagePropertyOrientation): kCFNull] as CFDictionary
        
        for i in 0..<count {
            CGImageDestinationAddImageFromSource(destination, source, i, removeExifProperties)
        }
        
        guard CGImageDestinationFinalize(destination) else {
            return self
        }
        
        return UIImage(data: mutableData as Data)!
    }
    
    
    
}
extension UIImageView {
    
    func resizeImageView(baseSize:CGSize,margine:CGFloat,factor:CGFloat)->CGSize{
        
        let baseWidth = baseSize.width
        let baseHeight = baseSize.height
        var imageWidth = self.image!.size.width
        var imageHeight = self.image!.size.height
        let ratio = (self.image!.size.width/self.image!.size.height)
        
        if imageWidth>imageHeight {
            imageWidth = (baseWidth - margine) * factor
            imageHeight = imageWidth/ratio
            
            
        }
        else{
            imageHeight = ( baseHeight - margine) * factor
            imageWidth = imageHeight * ratio
        }
        
        if imageHeight > baseSize.height {
            imageHeight = ( baseHeight - margine) * 0.9
            imageWidth = imageHeight * ratio
        }
        else if(imageWidth > baseSize.width){
            imageWidth = (baseWidth - margine) * 0.9
            imageHeight = imageWidth/ratio
        }
        
        return CGSize(width: imageWidth, height: imageHeight)
        
        
    }
    
    
    
    // MARK: - Methods
    func realImageRect() -> CGRect {
        let imageViewSize = self.frame.size
        let imgSize = self.image?.size
        
        guard let imageSize = imgSize else {
            return CGRect.zero
        }
        
        let scaleWidth = imageViewSize.width / imageSize.width
        let scaleHeight = imageViewSize.height / imageSize.height
        let aspect = fmin(scaleWidth, scaleHeight)
        
        var imageRect = CGRect(x: 0, y: 0, width: imageSize.width * aspect, height: imageSize.height * aspect)
        
        // Center image
        imageRect.origin.x = (imageViewSize.width - imageRect.size.width) / 2
        imageRect.origin.y = (imageViewSize.height - imageRect.size.height) / 2
        
        // Add imageView offset
        imageRect.origin.x += self.frame.origin.x
        imageRect.origin.y += self.frame.origin.y
        
        return imageRect
    }
    
    func flipVertical(){
        self.transform = CGAffineTransform(scaleX: -1, y: 1)
    }
    func flipHorizontal(){
        self.transform = CGAffineTransform(scaleX: 1, y: -1)
    }
    

}
extension UIButton{
    
    func startLoaderWithHover(lottieName:String){
        
//        let lottie = LottieAnimation()
//        lottie.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
//        // lottie.center.y = self.center.y
//        
//        lottie.lottieName = lottieName
//        lottie.animationView.contentMode = .scaleToFill
//        lottie.isUserInteractionEnabled = false
//        self.addSubview(lottie)
//        lottie.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.47)
//        lottie.layer.cornerRadius = self.layer.cornerRadius
//        
//        self.isUserInteractionEnabled = false
    }
    
    func startLoader(lottieName:String){
        
//        let lottie = LottieAnimation()
//        lottie.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
//        // lottie.center.y = self.center.y
//
//        lottie.lottieName = lottieName
//        lottie.animationView.contentMode = .scaleToFill
//        lottie.isUserInteractionEnabled = false
//        self.addSubview(lottie)
//
//        let fontAttributes = [NSAttributedString.Key.font: self.titleLabel?.font]
//        let text = self.titleLabel?.text
//        if text == nil {
//            lottie.center = self.center
//            return
//        }
//        let size = (text! as String).size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])
//
//
//
//        lottie.center.x = (self.frame.width/2) +  size.width
//        //lottie.frame = CGRect(x: lottie.frame.origin.x, y: lottie.frame.origin.x, width: 100, height: 100)
//        //lottie.backgroundColor = .red
//        // print(self.titleLabel?.text?.count)
//
//        self.isUserInteractionEnabled = false
    }
    
    func stopLoader(){
//        let myViews = self.subviews.filter{$0 is LottieAnimation}
//        if myViews.count>0 {
//            ( myViews[0] as! LottieAnimation).removeFromSuperview()
//        }
//        self.isUserInteractionEnabled = true
    }
    
    
    func setImageToButton(normalImage : UIImage , selectedImage : UIImage!){
        
        let  normalImageT = normalImage.scaleImage(toSize: CGSize(width: self.frame.width*2, height: self.frame.height*2))!
        
        if selectedImage != nil{
            
            let selectedImageT = selectedImage.scaleImage(toSize: CGSize(width: self.frame.width*2, height: self.frame.height*2))!
            self.setImage(selectedImageT, for: .selected)
        }
        self.setImage(normalImageT, for: .normal)
        
        self.imageView?.contentMode = .scaleAspectFit
        
        
    }
    
    func desableBtn(shouldInteract:Bool){
        self.backgroundColor = .systemGray4
        
        self.setTitleColor(.systemGray2, for: .normal)
        // self.titleLabel?.textColor = .systemGray2
        self.isUserInteractionEnabled = shouldInteract
    }
    
    func enableBtn(textColor:UIColor , bgColor:UIColor){
        self.backgroundColor = bgColor
        self.titleLabel?.textColor = textColor
        self.setTitleColor(.white, for: .normal)
        self.isUserInteractionEnabled = true
    }
    
//    func startLoader(lottieName:String){
//        
//        let lottie = LottieAnimation()
//        lottie.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
//        // lottie.center.y = self.center.y
//        
//        lottie.lottieName = lottieName
//        lottie.animationView?.contentMode = .scaleToFill
//        lottie.isUserInteractionEnabled = false
//        self.addSubview(lottie)
//        
//        let fontAttributes = [NSAttributedString.Key.font: self.titleLabel?.font]
//        let text = self.titleLabel?.text
//        if text == nil {
//            lottie.center = self.center
//            return
//        }
//        let size = (text! as String).size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])
//        
//        
//        
//        lottie.center.x = (self.frame.width/2) +  size.width*0.8
//        //lottie.frame = CGRect(x: lottie.frame.origin.x, y: lottie.frame.origin.x, width: 100, height: 100)
//        //lottie.backgroundColor = .red
//        // print(self.titleLabel?.text?.count)
//        
//        self.isUserInteractionEnabled = false
//    }
//    
//    func stopLoader(){
//        let myViews = self.subviews.filter{$0 is LottieAnimation}
//        if myViews.count>0 {
//            ( myViews[0] as! LottieAnimation).removeFromSuperview()
//        }
//        self.isUserInteractionEnabled = true
//    }
    
    
}


extension UITableView {
    
   // var function: () -> ()
    
   
    
  
    

    func scrollToBottom(){
        
        DispatchQueue.main.async { [self] in
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1,
                section: self.numberOfSections - 1)
            if hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }
        }
    }
    
    func scrollToTop() {
        
        DispatchQueue.main.async { [self] in
            let indexPath = IndexPath(row: 0, section: 0)
            if hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .top, animated: false)
            }
        }
    }
    
    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
    
    func scrollTableToIndexPath(indexPath: IndexPath) {
        self.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    func registerNib(xibName:String){
        
        let nib = UINib.init(nibName: xibName, bundle: nil)
        self.register(nib, forCellReuseIdentifier: xibName)
        
        
    }
    
}





extension UIColor {
    convenience init?(hexaRGB: String, alpha: CGFloat = 1) {
        var chars = Array(hexaRGB.hasPrefix("#") ? hexaRGB.dropFirst() : hexaRGB[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }
        case 6: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                  green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                  blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                  alpha: alpha)
    }
    
    convenience init?(hexaRGBA: String) {
        var chars = Array(hexaRGBA.hasPrefix("#") ? hexaRGBA.dropFirst() : hexaRGBA[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }; fallthrough
        case 6: chars.append(contentsOf: ["F","F"])
        case 8: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[0...1]), nil, 16)) / 255,
                  green: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                  blue: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                  alpha: .init(strtoul(String(chars[6...7]), nil, 16)) / 255)
    }
    
    convenience init?(hexaARGB: String) {
        var chars = Array(hexaARGB.hasPrefix("#") ? hexaARGB.dropFirst() : hexaARGB[...])
        switch chars.count {
        case 3: chars = chars.flatMap { [$0, $0] }; fallthrough
        case 6: chars.append(contentsOf: ["F","F"])
        case 8: break
        default: return nil
        }
        self.init(red: .init(strtoul(String(chars[2...3]), nil, 16)) / 255,
                  green: .init(strtoul(String(chars[4...5]), nil, 16)) / 255,
                  blue: .init(strtoul(String(chars[6...7]), nil, 16)) / 255,
                  alpha: .init(strtoul(String(chars[0...1]), nil, 16)) / 255)
    }
    
    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }
    
    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }
    
    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
    
    func isLight(threshold: Float = 0.5) -> Bool? {
        let originalCGColor = self.cgColor
        let RGBCGColor = originalCGColor.converted(to: CGColorSpaceCreateDeviceRGB(), intent: .defaultIntent, options: nil)
        guard let components = RGBCGColor?.components else {
            return nil
        }
        guard components.count >= 3 else {
            return nil
        }
        
        let brightness = Float(((components[0] * 299) + (components[1] * 587) + (components[2] * 114)) / 1000)
        return (brightness > threshold)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return NSString(format:"#%06x", rgb) as String
    }
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    
}

extension UILabel{
    
    func attacheImage(image:UIImage) {
        
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = image
        // Set bound to reposition
        let imageOffsetY: CGFloat = -5.0
        imageAttachment.bounds = CGRect(x: 0, y: imageOffsetY, width: 20, height: 20)
        
        // Create string with attachment
        let attachmentString = NSAttributedString(attachment: imageAttachment)
        // Initialize mutable string
        let completeText = NSMutableAttributedString(string: "\(self.text!)" )
        // Add image to mutable string
        
        completeText.append(attachmentString)
        // Add your text to mutable string
                let textAfterIcon = NSAttributedString(string: "2.4k")
                completeText.append(textAfterIcon)
        self.textAlignment = .center
        self.attributedText = completeText
        
    }
    

    
    
}

extension String {
    
    
  
    
    
    func convertUTCToLocalDate(utcFormat: String! , localFormat:String) -> String{
       // let dateString = "2022-07-14T10:44:48.000000Z"
        let formatter = DateFormatter()
        formatter.dateFormat = utcFormat
        let date = formatter.date(from: self)
        if date == nil {
            return self
        }
        return (date?.getFormattedDate(format: localFormat))!
    }
    
    
    
    func capitalizingFirstLetter() -> String {
          return prefix(1).uppercased() + self.lowercased().dropFirst()
        }

        mutating func capitalizeFirstLetter() {
          self = self.capitalizingFirstLetter()
        }
    
    
    mutating func setFloatFormate(digits:Int)->String{
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = digits


       
        return "\(formatter.string(from: (self.floatValue())as NSNumber)!)"
        
   
    }
    
    
    func getStringInArray(separatedFrom:String)-> NSArray{
        
        let arr = self.components(separatedBy:separatedFrom)
        return arr as NSArray
    }
    
    
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        }
        
        guard let characterSpacing = characterSpacing else {return attributedString}
        
        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))
        
        return attributedString
    }
    
    
    func changeHashTagAppearence(hashTagColor: UIColor , normalColor:UIColor ) -> NSAttributedString{
        
        var arr_hasStrings:[String] = []
        let regex = try? NSRegularExpression(pattern: "(#[a-zA-Z0-9_\\p{Arabic}\\p{N}]*)", options: [])
        if let matches = regex?.matches(in: self, options:[], range:NSMakeRange(0, self.count)) {
            for match in matches {
                arr_hasStrings.append(NSString(string: self).substring(with: NSRange(location:match.range.location, length: match.range.length )))
            }
        }
        return convert(arr_hasStrings, string: self , hash: hashTagColor , normal: normalColor)
    }
    
    func convert(_ hashElements:[String], string: String ,hash: UIColor , normal:UIColor ) -> NSAttributedString {
        
        let hasAttribute = [NSAttributedString.Key.foregroundColor: hash ,NSAttributedString.Key.backgroundColor: normal ]
        
        let normalAttribute = [NSAttributedString.Key.foregroundColor: normal]
        
        let mainAttributedString = NSMutableAttributedString(string: string, attributes: normalAttribute)
        
        let txtViewReviewText = string as NSString
        
        hashElements.forEach { if string.contains($0) {
            mainAttributedString.addAttributes(hasAttribute, range: txtViewReviewText.range(of: $0))
        }
        }
        return mainAttributedString
    }
    
    
    func findMentionText() -> [String] {
        var arr_hasStrings:[String] = []
        let regex = try? NSRegularExpression(pattern: "(@[a-zA-Z0-9_\\p{Arabic}\\p{N}]*)", options: [])
        if let matches = regex?.matches(in: self, options:[], range:NSMakeRange(0, self.count)) {
            for match in matches {
                arr_hasStrings.append(NSString(string: self).substring(with: NSRange(location:match.range.location, length: match.range.length )))
            }
        }
        return arr_hasStrings
    }
    
    func floatValue() -> CGFloat {
        let numberFormatter = NumberFormatter()
        let number = numberFormatter.number(from:self)
        if number != nil {
            return CGFloat(number!)
        }
        else{
            return CGFloat(0.0)
        }
        
        
    }
    
    var isValidURL: Bool {
            let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
            if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.utf16.count)) {
                // it is a link, if the match covers the whole string
                return match.range.length == self.utf16.count
            } else {
                return false
            }
        }
    
}

extension UITapGestureRecognizer {
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        //let textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
        //(labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)
        
        //let locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
        // locationOfTouchInLabel.y - textContainerOffset.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}

extension UICollectionView {
    
    
    public func registerNib(xibName: String){
        let nib = UINib(nibName: xibName, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: xibName)
    }
    
    
    
    func scrollToNextItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x + self.bounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }
    
    func scrollToPreviousItem() {
        let contentOffset = CGFloat(floor(self.contentOffset.x - self.bounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }
    
    func moveToFrame(contentOffset : CGFloat) {
        self.setContentOffset(CGPoint(x: contentOffset, y: self.contentOffset.y), animated: true)
    }
    
    
}



extension UIView {
   
    func addWarningView(heading:String,subHeading:String,lottie:String){
        let view = WarningView()
        DispatchQueue.main.async {
            view.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        }
        view.isUserInteractionEnabled = false
        view.backgroundColor = self.backgroundColor
        view.tag = 6557
       // view.lottieView.startLottie(lottieFile: lottie)
        view.heading.text = heading
        view.subheading.text = subHeading
       
       // view.mainHeading.text = heading
       // view.subHeading.text = subHeading
       // view.warningIcon.image = image.scaleImageToBaseView(imageView:view.warningIcon , multy: 2)
        
        self.addSubview(view)
    }
 
    func hideKeyBoardOnThouching(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.addGestureRecognizer(tap)
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        self.endEditing(true)
    }
    
    func showSimpleAlert(title: String,msg:String){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        let vc = UIApplication.topViewController()
        DispatchQueue.main.async {
            vc!.present(alert, animated: true, completion: nil)

        }
        
    }
    
    func removeWarningView() {
        for item in self.subviews where item.tag == 6557 {
            item.removeFromSuperview()
        }
    }
    
    func setWarningViewFrame(viewFrame:CGRect){
        for item in self.subviews where item.tag == 6557 {
            item.frame = viewFrame
        }
    }
    
    func startShimmer() {
        let gradientColorOne : CGColor = UIColor.systemGray6.cgColor
        let gradientColorTwo : CGColor = UIColor.systemGray5.cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "shim"
        self.alpha = 0
        DispatchQueue.main.async {
            gradientLayer.frame = self.bounds
            // self.isHidden = false
            UIView.animate(withDuration: 0.5) {
                self.alpha = 1
                gradientLayer.cornerRadius = self.layer.cornerRadius
               
            }
            
        }
        
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
        gradientLayer.locations = [0.0, 0.5, 0.0]
        self.layer.addSublayer(gradientLayer)
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [-1.0, -0.5, 0.0]
        animation.toValue = [1.0, 1.5, 2.0]
        animation.repeatCount = .infinity
        animation.duration = 2
        gradientLayer.add(animation, forKey: animation.keyPath)
    }
    
    func stopShimmer(){
        
        for item in self.layer.sublayers ?? [] where item.name == "shim" {
            item.removeFromSuperlayer()
        }
        
    }
    
    
    func takeScreenshot() -> UIImage {

            // Begin context
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)

            // Draw view in that context
            drawHierarchy(in: self.bounds, afterScreenUpdates: true)

            // And finally, get image
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            if (image != nil)
            {
                return image!
            }
            return UIImage()
        }
    
    // Using CAMediaTimingFunction
    func shake(duration: TimeInterval = 0.5, values: [CGFloat]) {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        
        // Swift 4.2 and above
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = HUGE
        animation.duration = duration // You can set fix duration
        animation.values = values  // You can set fix values here also
        self.layer.add(animation, forKey: "shake")
    }
    
    
    
    var parentViewController: UIViewController? {
        // Starts from next (As we know self is not a UIViewController).
        var parentResponder: UIResponder? = self.next
        while parentResponder != nil {
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
            parentResponder = parentResponder?.next
        }
        return nil
    }
    
    
    func roundBottomCorner(cornerRadious:CGFloat){
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadious
        self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    func roundTopCorner(cornerRadious:CGFloat){
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadious
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    func roundLeftCorner(cornerRadious:CGFloat){
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadious
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    
    func roundRighrtCorner(cornerRadious:CGFloat){
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadious
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
    }
    
    func removeAllSubviews(){
        let subviews = self.allSubViewsOf(type: UIView.self)
        
        for item in subviews {
            if item != self {
                item.removeFromSuperview()
            }
            
        }
    }
    
    func removeAllSubViewsOf<T : UIView>(type : T.Type){
        
        func getSubview(view: UIView) {
            if let aView = view as? T{
                aView.removeFromSuperview()
            }
            guard view.subviews.count>0 else { return }
            view.subviews.forEach{ getSubview(view: $0) }
        }
        
        
    }
    
    
    func allSubViewsOf<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T{
                all.append(aView)
            }
            guard view.subviews.count>0 else { return }
            view.subviews.forEach{ getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }
    
    
    
    //      // Using SpringWithDamping
    //      func shake(duration: TimeInterval = 0.5, xValue: CGFloat = 12, yValue: CGFloat = 0) {
    //          self.transform = CGAffineTransform(translationX: xValue, y: yValue)
    //          UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
    //              self.transform = CGAffineTransform.identity
    //          }, completion: nil)
    //
    //      }
    //
    //
    //      // Using CABasicAnimation
    //      func shake(duration: TimeInterval = 0.05, shakeCount: Float = 6, xValue: CGFloat = 12, yValue: CGFloat = 0){
    //          let animation = CABasicAnimation(keyPath: "position")
    //          animation.duration = duration
    //          animation.repeatCount = shakeCount
    //          animation.autoreverses = true
    //          animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - xValue, y: self.center.y - yValue))
    //          animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + xValue, y: self.center.y - yValue))
    //          self.layer.add(animation, forKey: "shake")
    //      }
    
//    func showSimpleAlert(title: String,msg:String){
//        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//
//        let vc = UIApplication.topViewController()
//        DispatchQueue.main.async {
//            vc!.present(alert, animated: true, completion: nil)
//
//        }
//
//    }
    
}
extension UIViewController
{
    var topPadding: CGFloat {
        
        let window = Scene.getSceneDelegate().window
        let topPadding = window!.safeAreaInsets.top
        
        return topPadding
    }
    
    var bottomPadding: CGFloat {
        
        let window = Scene.getSceneDelegate().window
        let bottomPadding = window!.safeAreaInsets.bottom
        
        return bottomPadding
    }
    
    
    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
        (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
    func enableHideKeyboard() {
        //        self.view.addGestureRecognizer(UITapGestureRecognizer(target:self, action: #selector(hideKeyBoard(gesture:))))
        
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipe))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
        
    }
    

    
    
    @objc func dismissKeyboard()
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.view.endEditing(true)
        }
    }
    
    func setupToHideKeyboardOnTapOnView()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func respondToSwipe(gesture: UIGestureRecognizer) {
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            
            switch swipeGesture.direction {
                
            case .down:
                dismissKeyboard()
                break
                
            default:
                break
            }
        }
    }
    
    func dismissOnTap(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        dismiss(animated: false)
    }
    
    
    func addInputAccessoryForTextFields(textFields: [UITextField], dismissable: Bool = true, previousNextable: Bool = false) {
        for (index, textField) in textFields.enumerated() {
            let toolbar: UIToolbar = UIToolbar()
            toolbar.sizeToFit()
            
            var items = [UIBarButtonItem]()
            if previousNextable {
                let previousButton = UIBarButtonItem(image: UIImage(named: "previousArrow.png"), style: .plain, target: nil, action: nil)
                previousButton.width = 50
                if textField == textFields.first {
                    previousButton.isEnabled = false
                } else {
                    previousButton.target = textFields[index - 1]
                    previousButton.action = #selector(UITextField.becomeFirstResponder)
                }
                
                let nextButton = UIBarButtonItem(image: UIImage(named: "nextArrow.png"), style: .plain, target: nil, action: nil)
                nextButton.width = 50
                if textField == textFields.last {
                    nextButton.isEnabled = false
                } else {
                    nextButton.target = textFields[index + 1]
                    nextButton.action = #selector(UITextField.becomeFirstResponder)
                }
                items.append(contentsOf: [previousButton, nextButton])
                
            }
            
            let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: view, action: #selector(UIView.endEditing))
            items.append(contentsOf: [spacer, doneButton])
            
            
            toolbar.setItems(items, animated: false)
            textField.inputAccessoryView = toolbar
        }
    }
    

    
    
    public enum toastPlace {
      case top // default - plays the current animation in reverse
      case bottom // does not update the animation when canceled
    }
    
    func showToast(message : String, font: UIFont,place:toastPlace , duration:CGFloat) {

        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: self.view.frame.size.width-40, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.font = font
        toastLabel.textAlignment = .center;
        toastLabel.text = " " + message + " "
        toastLabel.alpha = 1.0
        toastLabel.numberOfLines = 0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        toastLabel.sizeToFit()
        
        self.view.addSubview(toastLabel)
        
        if place == .top {
            toastLabel.frame = CGRect(x: 0, y: 150, width: self.view.frame.size.width-40, height: toastLabel.frame.height+20)
        }
        else{
            toastLabel.frame = CGRect(x: 0, y: self.view.frame.size.height-150, width: self.view.frame.size.width-40, height: toastLabel.frame.height+20)
        }
        
        
      
        toastLabel.center.x = (toastLabel.superview?.center.x)!
        
        UIView.animate(withDuration: duration, delay: 0.1, options: .curveEaseOut, animations: {
             toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    
}

extension UIApplication {
    
    func deleteFiles(fromCacheWhichContain name: String?) {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).map(\.path)
        let documentsPath = paths[0]
        
        var _: Error?
        var directoryContents: [String]? = nil
        do {
            directoryContents = try FileManager.default.contentsOfDirectory(atPath: documentsPath)
        } catch {
        }
        
        for i in 0..<directoryContents!.count {
            let fileName = directoryContents![i]
            if (fileName as NSString?)?.range(of: name ?? "").location != NSNotFound {
                deleteFileFromDocument(withName: fileName)
            }
        }
        
        
        
    }
    
    func deleteFileFromDocument(withName name: String?) {
        let filePath = documentsPath(forFileName: "\(name ?? "")")
        
        if FileManager.default.fileExists(atPath: filePath!) {
            deleteItem(fromPath: filePath)
        }
        
    }
    
    func documentsPath(forFileName name: String?) -> String? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).map(\.path)
        let documentsPath = paths[0]
        print("Doc Path== \(documentsPath)")
        return URL(fileURLWithPath: documentsPath).appendingPathComponent(name ?? "").path
    }
    
    
    func deleteItem(fromPath imagePath: String?) {
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(atPath: imagePath ?? "")
        } catch {
        }
    }
   
    
    
    class func topViewController(_ viewController: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(presented)
        }
        return viewController
    }

    class func topNavigationController(_ viewController: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.rootViewController) -> UINavigationController? {

        if let nav = viewController as? UINavigationController {
            return nav
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return selected.navigationController
            }
        }
        return viewController?.navigationController
    }
}


extension CGFloat{
    
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> CGFloat {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
  var stringValue: String {
        return "\(self)"
    }
   func random(lower: CGFloat = 0, _ upper: CGFloat = 1) -> CGFloat {
           return CGFloat(Float(arc4random()) / Float(UINT32_MAX)) * (upper - lower) + lower
       }
    
}


extension UIControl {
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping()->()) {
        @objc class ClosureSleeve: NSObject {
            let closure:()->()
            init(_ closure: @escaping()->()) { self.closure = closure }
            @objc func invoke() { closure() }
        }
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: controlEvents)
        objc_setAssociatedObject(self, "\(UUID())", sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}

extension UINavigationController {
func pushToViewController(_ viewController: UIViewController, animated:Bool = true, completion: @escaping ()->()) {
    CATransaction.begin()
    CATransaction.setCompletionBlock(completion)
    self.pushViewController(viewController, animated: animated)
    CATransaction.commit()
}

func popViewController(animated:Bool = true, completion: @escaping ()->()) {
    CATransaction.begin()
    CATransaction.setCompletionBlock(completion)
    self.popViewController(animated: animated)
    CATransaction.commit()
}

func popToViewController(_ viewController: UIViewController, animated:Bool = true, completion: @escaping ()->()) {
    CATransaction.begin()
    CATransaction.setCompletionBlock(completion)
    self.popToViewController(viewController, animated: animated)
    CATransaction.commit()
}

func popToRootViewController(animated:Bool = true, completion: @escaping ()->()) {
    CATransaction.begin()
    CATransaction.setCompletionBlock(completion)
    self.popToRootViewController(animated: animated)
    CATransaction.commit()
}
}
extension Array {

    func filterDuplicates( includeElement: (_ lhs:Element, _ rhs:Element) -> Bool) -> [Element]{
        var results = [Element]()

        forEach { (element) in
            let existingElements = results.filter {
                return includeElement(element, $0)
            }
            if existingElements.count == 0 {
                results.append(element)
            }
        }

        return results
    }
}

extension Date {
    func dateStringWith(strFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
        dateFormatter.dateFormat = strFormat
        return dateFormatter.string(from: self)
    }
    
    
    
    func offsetFrom(date: Date) -> String {
        
        let dayHourMinuteSecond: Set<Calendar.Component> = [ .hour, .minute, .second]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: date, to: self)
        
        let seconds = Int(difference.second!)
        let minutes = Int(difference.minute!)
        let hours = Int(difference.hour!)
        // let days = "\(difference.day ?? 0)d" + " " + hours
        
        
        //        let formatter = NumberFormatter()
        //        formatter.minimumIntegerDigits = 2
        //
        //
        //        print("\(formatter.string(from: hours)):\(formatter.string(from: minutes)):\(formatter.string(from: seconds))")
        
        return String(format: "%02d:%02d:%02d",(hours),(minutes) ,(seconds) )
        
        //       // if let day = difference.day, day          > 0 { return days }
        //        if let hour = difference.hour, hour       > 0 { return hours }
        //        if let minute = difference.minute, minute > 0 { return minutes }
        //        if let second = difference.second, second > 0 { return seconds }
        //        return ""
    }
    
    func getHourDiffrence(date: Date)->Int{
        let dayHourMinuteSecond: Set<Calendar.Component> = [ .hour]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: date, to: self)
        
        
        let hours = (difference.hour ?? 0)
        // let days = "\(difference.day ?? 0)d" + " " + hours
        
        return hours
        
    }
    
    
    func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
    
    func localToUTC(dateStr: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        dateFormatter.calendar = Calendar.current
        dateFormatter.timeZone = TimeZone.current
        
        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            dateFormatter.dateFormat = "H:mm:ss"
        
            return dateFormatter.string(from: date)
        }
        return nil
    }

    func utcToLocal(dateStr: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "H:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: dateStr) {
            dateFormatter.timeZone = TimeZone.current
            dateFormatter.dateFormat = "h:mm a"
        
            return dateFormatter.string(from: date)
        }
        return nil
    }
    
    
    
    
}

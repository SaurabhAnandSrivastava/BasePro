//
//  LottieAnimation.swift
//  Tutorial
//
//  Created by Saurabh Srivastav on 12/02/22.
//


//import UIKit
//import Lottie
//@IBDesignable
//class LottieAnimation: UIView {
//    
//    
//    
//    
//   
//    public var animationView = AnimationView()
//    public var lottie: String!
//    public var lottieBehavious: LottieBackgroundBehavior = .pauseAndRestore
//    var isStopped = false
//    // MARK: - Config
//    @IBInspectable
//    var lottieName: String {
//        get {
//            return ""
//        }
//        set {
//            lottie = newValue
//           
//            
//        }
//    }
//    
//    
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        commonInit()
//        
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        commonInit()
//    }
//    
//    func commonInit(){
//        
//        
//    }
//    
//    
//    
//    
//    override func willMove(toWindow newWindow: UIWindow?) {
//        super.willMove(toWindow: newWindow)
//        
//        if newWindow == nil {
//            // UIView disappear
//            //stopAnimation()
//        } else {
//            // UIView appear
//            if !isStopped {
//                startAnimation()
//            }
//           
//            
//        }
//    }
//    
//    
//    public func changeAnimation(fileName:String){
//      
//        //animationView?.stop()
//        
//        
//        lottie = fileName
//        startLottieAnimation()
//        
//    }
//    
//    private func startAnimation(){
//        //print(lottie)
////        animationView?.removeFromSuperview()
////        animationView = .init(name: lottie)
////        animationView!.frame = self.bounds
////        animationView!.contentMode = .scaleAspectFit
////        animationView!.loopMode = .loop
////        animationView!.animationSpeed = 0.5
////        self.addSubview(animationView!)
////        animationView!.play()
////        animationView!.backgroundBehavior = .pauseAndRestore
//        startLottieAnimation()
//    }
//    
//    
//  
//    
//    public func stopAnimation(){
//        isStopped = true
//        animationView.stop()
//        
//    }
//    
//    private func startLottieAnimation(){
//        animationView.removeFromSuperview()
//        if lottie == nil {
//            return
//        }
//        animationView = .init(name: lottie)
//      
//        animationView.frame = self.bounds
//        animationView.contentMode = .scaleAspectFit
//        animationView.frame = self.bounds
//        animationView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        //animationView?.backgroundColor = .red
//        animationView.loopMode = .loop
//        animationView.animationSpeed = 0.5
//        self.addSubview(animationView)
//        animationView.play()
//        animationView.backgroundBehavior = lottieBehavious
//    }
//    public func startLottie(lottieFile:String){
//        lottie = lottieFile
//        startLottieAnimation()
//    }
// 
//    
//    private func startLottieWidthUrl(url:String){
//        
//       // animationView.animation =  Animation.filepath(url, animationCache: LRUAnimationCache.sharedCache)
//       
//        Animation.loadedFrom(url: URL(string: url)!, closure: { [self] res  in
//            animationView.animation = res
//        }, animationCache: LRUAnimationCache.sharedCache)
//        //animationView = .init(filePath: url)
//        animationView.frame = self.bounds
//        animationView.contentMode = .scaleAspectFit
//        animationView.frame = self.bounds
//        animationView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        animationView.backgroundColor = .clear
//        animationView.loopMode = .loop
//        animationView.animationSpeed = 0.5
//        self.addSubview(animationView)
//        animationView.play()
//        animationView.backgroundBehavior = lottieBehavious
//        
//        
//    }
//    
//    public  func startLottieFromUrl(url:String, fileId:String){
//        
//        startLottieWidthUrl(url: url)
//        
////        let filePath = getFilePath(fileName: fileId)
////
////        if filePath != nil {
////
////            startLottieWidthUrl(url: filePath!)
////
////
////
////        }
////        else {
////
////        DispatchQueue.global(qos: .userInitiated).async {
////           // let filedata = UIImage(data: NSData(contentsOf: URL(string: url)!)! as Data)
////
////            do {
////                let filedata = try Data(contentsOf: URL(string: url)!)
////                DispatchQueue.main.async { [self] in
////
////
////                       saveLottie(fileId: fileId, fileData: filedata)
////
////                }
////
////                } catch {
////                    print("Unable to load data: \(error)")
////                }
////
////
////
////        }
////        }
//        //self.image?.saveImages(imageId: documentId)
//        
//    }
//   
//    private   func saveLottie( fileId: String? , fileData:Data!) {
//        let pngData = fileData
//        let filePath = documentsPath(forFileName: "\(fileId ?? "").json")
//        if FileManager.default.fileExists(atPath: filePath!) {
//           deleteItem(fromPath: filePath)
//            
//        }
//        if let pngData = pngData {
//            NSData(data: pngData).write(toFile: filePath!, atomically: true)
//            startLottieWidthUrl(url: filePath!)
//        }
//        
//        
//    }
//    private  func documentsPath(forFileName name: String?) -> String? {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).map(\.path)
//        let documentsPath = paths[0]
//        print("Doc Path== \(documentsPath)")
//        return URL(fileURLWithPath: documentsPath).appendingPathComponent(name ?? "").path
//    }
//    private  func deleteItem(fromPath filePath: String?) {
//        let fileManager = FileManager.default
//        do {
//            try fileManager.removeItem(atPath: filePath ?? "")
//        } catch {
//        }
//    }
//    private  func getFileFromDoucument(withName fileName: String?) -> Data? {
//        
//        if fileName == nil {
//            return nil
//        }
//        let name = fileName?.replacingOccurrences(of: ".json", with: "")
//        
//        let pngData = NSData(contentsOfFile: documentsPath(forFileName: "\(name ?? "").json")!) as Data?
//       
//        return pngData
//        
////        var img: UIImage? = nil
////        if let pngData = pngData {
////            img = UIImage(data: pngData)
////        }
////        if img != nil {
////            return img
////        } else {
////            return nil
////        }
//        
//    }
//    private   func getFilePath(fileName:String) -> String?{
//        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
//          let url = NSURL(fileURLWithPath: path)
//          if let pathComponent = url.appendingPathComponent("\(fileName).json") {
//              let filePath = pathComponent.path
//              let fileManager = FileManager.default
//              if fileManager.fileExists(atPath: filePath) {
//                  return filePath
//              } else {
//                  return nil
//              }
//          } else {
//              return nil
//          }
//    }
//}

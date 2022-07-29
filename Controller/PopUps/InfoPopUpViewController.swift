//
//  InfoPopUpViewController.swift
//  FurEternity
//
//  Created by Saurabh on 21/05/22.
//

import UIKit

class InfoPopUpViewController: UIViewController {
    
//    @IBOutlet weak var lottieView: LottieAnimation!
    @IBOutlet weak var popupView: CustomViews!
    @IBOutlet weak var subheading: CustomLbl!
    @IBOutlet weak var heading: CustomLbl!
    public var lottieName: String!
    override func viewDidLoad() {
        super.viewDidLoad()
//        let popUpType = PopUpManager.shared.popUpType
//       
//        
//        switch popUpType {
//        case .newCh:
//            let pop = CombineSuccessView()
//            pop.frame = popupView.bounds
//            pop.autoresizingMask = [.flexibleWidth , .flexibleHeight]
//            pop.lottieView.startLottie(lottieFile:lottieName)
//            popupView.addSubview(pop)
//            break
//            
//        case .matchResult:
//            break
//        
//        case .none:
//            print("")
//        case .buy:
//            print("")
//        case .conversion:
//            print("")
//        case .sell:
//            print("")
//        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        popupView.transform = CGAffineTransform.identity.scaledBy(x: 0, y: 0)
        UIView.animate(withDuration: 0.5) { [self] in
            popupView.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
        }
    }
    
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: false)
        PopUpManager.shared.closePopUp?()
    }
    
}

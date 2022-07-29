//
//  SlidePopUpViewController.swift
//  FurEternity
//
//  Created by Saurabh on 28/05/22.
//

import UIKit
import WebKit
class SlidePopUpViewController: UIViewController {
    @IBOutlet weak var heightCon: NSLayoutConstraint!
    @IBOutlet weak var floationgBottomCon: NSLayoutConstraint!
    @IBOutlet weak var floatingPannel: CustomViews!
    var upthreshHold = 0.0
    var bottomthreshHold = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        switch  PopUpManager.shared.popUpType {
//        case .newCh:
//            
//            break
//            
//        case .matchResult:
//            break
//            
//        case .none:
//            print("")
//        case .buy:
//            heightCon.constant = 450
//            showBuyPopUp()
//            break
//        case .sell:
//            heightCon.constant = 450
//            showSellPopUp()
//            break
//        case .moneyConversion:
//            heightCon.constant = 300
//            showMoneyConversionPopUp()
//            break
//        case .tokenConversion:
//            heightCon.constant = 300
//            showTokenConversionPopUp()
//        case .moneyWithdraw:
//            heightCon.constant = 200
//            showWithdrawPopUp()
//        case .tokenPurchase:
//            heightCon.constant = 200
//            showPurchasePopUp()
//        case .removeFromSell:
//            heightCon.constant = 450
//            showRemovePopUp()
//            break
//        }
        
        
        floatingPanelConfig()
        self.dismissOnTap()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        floationgBottomCon.constant = -800
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {  [self] in
            
            floationgBottomCon.constant = 0
            UIView.animate(withDuration: 0.2, animations: { [self] in
                
                self.view.layoutIfNeeded()
                
            }, completion: {res in
                
                
            })
        }
        
        keyBoardSettings()
        
        
    }
    
    
    // MARK: -Keyboard Config
    
    private func keyBoardSettings(){
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Key board observers
    
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                
                floationgBottomCon.constant = keyboardSize.height
                
            }
        }
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        
        floationgBottomCon.constant = 0
        
    }
    
    
    
    // MARK: - Configs
    
    private func floatingPanelConfig(){
        floatingPannel.roundTopCorner(cornerRadious: 25)
        floatingPannel.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture)))
        upthreshHold = view.frame.height - heightCon.constant
        bottomthreshHold = upthreshHold + (heightCon.constant * 0.5)
    }
    
    
    
    // MARK: - Gesture
    
    @objc func handlePanGesture(sender: UIPanGestureRecognizer){
        
        
        let translation = sender.translation(in: self.view)
        sender.view?.center = CGPoint(x: (sender.view?.center.x ?? 0) + translation.x, y: (sender.view?.center.y ?? 0) + translation.y )
        sender.setTranslation(CGPoint(x: 0, y: 0), in: self.view)
        
        var y = (sender.view?.frame.origin.y)!
        
        if((sender.view?.frame.origin.y)! < upthreshHold){
            y = upthreshHold
        }
        
        sender.view?.frame = CGRect(x: 0, y: y, width: (sender.view?.frame.width)!, height: (sender.view?.frame.height)!)
        
        switch sender.state {
            
        case .ended:
            
            if y > bottomthreshHold  {
                UIView.animate(withDuration: 0.2,
                               delay: 0,
                               options: UIView.AnimationOptions.curveEaseOut,
                               animations: { [self] () -> Void in
                    
                    sender.view?.frame = CGRect(x: 0, y: self.view.frame.height, width: sender.view?.frame.size.width ?? 0, height: sender.view?.frame.size.height ?? 0)
                    
                    
                }, completion: { (finished) -> Void in
                    self.dismiss(animated: false, completion: nil)
                })
            }
            else{
                y = upthreshHold
                UIView.animate(withDuration: 0.2,
                               delay: 0,
                               options: UIView.AnimationOptions.curveEaseOut,
                               animations: {  () -> Void in
                    
                    sender.view?.frame = CGRect(x: 0, y: y , width: sender.view?.frame.size.width ?? 0, height: sender.view?.frame.size.height ?? 0)
                    
                    
                }, completion: { (finished) -> Void in
                    
                })
            }
            
            break
            
        default: break
        }
        
    }
    
    // MARK: - Class Methods
    
   
    
    
}

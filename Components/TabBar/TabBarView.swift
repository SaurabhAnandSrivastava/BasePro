//
//  TabBarView.swift
//  FasticSynch
//
//  Created by Saurabh Srivastav on 27/12/21.
//

import UIKit
private let XIB = "TabBarView"
class TabBarView: UIView {
    
    
    @IBOutlet weak var tabStack: UIStackView!

    
    public var tabBtnArray = NSMutableArray()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        let viewFromXib = Bundle.main.loadNibNamed(XIB, owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
        
        
        
    }
    
    
    public func addTabBtn(btnImage:UIImage , btnText:String, btnIndex:Int){
        
        let tabBtn = ButtonWithBadge()
        tabBtn.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        tabBtn.iconImage.image = btnImage
        tabBtn.optionLbl.text = btnText
        tabBtn.optionBtn.tag = btnIndex
        tabStack.addArrangedSubview(tabBtn)
        
        tabBtnArray.add(tabBtn as Any)
        
        tabBtn.optionBtn.addTarget(self, action: #selector(tabBtnAction( _ :)), for: .touchUpInside)
        
    }
    
    //    public func deSelectAll(){
    //
    //        for item in tabBtnArray {
    //
    //            let btnView = item as! ButtonWithBadge
    //            btnView.
    //
    //        }
    //    }
    
    @objc func tabBtnAction(_ sender: Any){
        
        for item in tabBtnArray {
            
            let btnView = item as! ButtonWithBadge
            
            if btnView.optionBtn.tag != (sender as! UIButton).tag {
                btnView.deSelect()
            }
            
        }
        
    }
    
}

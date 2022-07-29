//
//  ButtonWithBadge.swift
//  FasticSynch
//
//  Created by Saurabh Srivastav on 27/12/21.
//

import UIKit
private let XIB = "ButtonWithBadge"
class ButtonWithBadge: UIView {
    @IBOutlet weak var optionBtn: UIButton!
    @IBOutlet weak var badge: UILabel!
    @IBOutlet weak var optionLbl: UILabel!
    @IBOutlet weak var iconImage: CustomUiimageView!
    
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
        badge.isHidden = true
      
        
    }
    @IBAction func optionBtnAction(_ sender: Any) {
        
        optionBtn.isSelected = !optionBtn.isSelected
        
        if(optionBtn.isSelected){
           select()
        }
        else{
           deSelect()
        }
        
    }
    
    public func deSelect(){
        optionBtn.isSelected = false
        iconImage.imageTintColor = .black
        optionLbl.textColor = .black
    }
    
    public func select(){
        optionBtn.isSelected = true
        iconImage.imageTintColor = APP_UICOLOR
        optionLbl.textColor = APP_UICOLOR
    }
    
}

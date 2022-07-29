//
//  ProfileTableCell.swift
//  FurEternity
//
//  Created by Saurabh on 10/05/22.
//

import UIKit

class ProfileTableCell: UITableViewCell {

    @IBOutlet weak var topCon: NSLayoutConstraint!
    @IBOutlet weak var bottomcon: NSLayoutConstraint!
    @IBOutlet weak var bgview: CustomViews!
    @IBOutlet weak var icon: CustomUiimageView!
    @IBOutlet weak var optionText: CustomLbl!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

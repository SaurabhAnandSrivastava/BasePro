//
//  AuthOptionTableCell.swift
//  FurEternity
//
//  Created by Saurabh on 17/05/22.
//

import UIKit

class AuthOptionTableCell: UITableViewCell {

    @IBOutlet weak var titleText: CustomLbl!
    @IBOutlet weak var fbBtn: CustomBtn!
    @IBOutlet weak var googleBtn: CustomBtn!
    @IBOutlet weak var appleBtn: CustomBtn!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

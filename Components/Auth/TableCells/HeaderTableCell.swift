//
//  HeaderTableCell.swift
//  FurEternity
//
//  Created by Saurabh on 17/05/22.
//

import UIKit

class HeaderTableCell: UITableViewCell {

    @IBOutlet weak var heading: CustomLbl!
    @IBOutlet weak var subHeading: CustomLbl!
    @IBOutlet weak var segment: UISegmentedControl!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

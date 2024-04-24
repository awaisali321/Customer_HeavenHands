//
//  MenuVC_Cell.swift
//  HeavenlyHands-2
//
//  Created by Abdul Naffay on 10/01/2024.
//

import UIKit

class MenuVC_Cell: UITableViewCell {
    @IBOutlet weak var MenuItemsLbl:UILabel!
    @IBOutlet weak var MenuItemsIMGView:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

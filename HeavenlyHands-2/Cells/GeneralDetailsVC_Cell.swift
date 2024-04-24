//
//  GeneralDetailsVC_Cell.swift
//  HeavenlyHands-2
//
//  Created by Abdul Naffay on 11/01/2024.
//

import UIKit

class GeneralDetailsVC_Cell: UITableViewCell {
    @IBOutlet weak var CellView:UIView!
    @IBOutlet weak var DetailLbl:UILabel!
    @IBOutlet weak var DetailData:UILabel!
    @IBOutlet weak var DetailsFld:UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        CellView.layer.shadowOpacity = 0.1
        CellView.layer.shadowRadius = 1
                
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

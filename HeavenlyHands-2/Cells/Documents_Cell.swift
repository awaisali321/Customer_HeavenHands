//
//  Doeuments_Cell.swift
//  HeavenlyHands-2
//
//  Created by Abdul Naffay on 10/01/2024.
//

import UIKit

class Documents_Cell: UITableViewCell {
    @IBOutlet weak var DocumentNameLbl:UILabel!
    @IBOutlet weak var DateLbl:UILabel!
    @IBOutlet weak var TimeLbl:UILabel!
    @IBOutlet weak var ViewDocumentsBtn:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

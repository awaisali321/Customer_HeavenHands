//
//  AppointmentsVC_Cell.swift
//  HeavenlyHands-2
//
//  Created by Abdul Naffay on 11/01/2024.
//

import UIKit

class AppointmentsVC_Cell: UITableViewCell {
    @IBOutlet weak var appointmentNameLbl:UILabel!
    @IBOutlet weak var datesLbl:UILabel!
    @IBOutlet weak var TimeLbl:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

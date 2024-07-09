//
//  SeatCell.swift
//  FreshTrack
//
//  Created by Zain on 07/10/2022.
//  Copyright © 2022 Zain. All rights reserved.
//

import UIKit

class NotificationCell: UITableViewCell {
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var body: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

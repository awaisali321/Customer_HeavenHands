//
//  NotificationsVC_Cell.swift
//  HeavenlyHands-2
//
//  Created by Abdul Naffay on 16/01/2024.
//

import UIKit

class NotificationsVC_Cell: UITableViewCell {
    @IBOutlet weak var ProfileImage:UIImageView!
    @IBOutlet weak var NotificationLbl:UILabel!
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

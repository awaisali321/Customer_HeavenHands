//
//  TasksVC_Cell.swift
//  HeavenlyHands-2
//
//  Created by Abdul Naffay on 10/01/2024.
//

import UIKit

class TasksVC_Cell: UITableViewCell {
    @IBOutlet weak var ReportNameLbl:UILabel!
    @IBOutlet weak var timelbl:UILabel!
    @IBOutlet weak var AddSignatureBtn:UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

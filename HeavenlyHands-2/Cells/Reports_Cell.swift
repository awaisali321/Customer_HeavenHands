//
//  Reports_Cell.swift
//  HeavenlyHands-2
//
//  Created by Abdul Naffay on 10/01/2024.
//

import UIKit

class Reports_Cell: UITableViewCell {
    @IBOutlet weak var ReportNameLbl:UILabel!
    @IBOutlet weak var DateLbl:UILabel!
    @IBOutlet weak var TimeLbl:UILabel!
    @IBOutlet weak var PdfDownloadBtn:UIButton!
    @IBOutlet weak var ViewFileBtn:UIButton!
    @IBOutlet weak var signatureview: UIView!
    @IBOutlet weak var signatureviewbtn: UIButton!
    
    @IBOutlet weak var eyeview: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

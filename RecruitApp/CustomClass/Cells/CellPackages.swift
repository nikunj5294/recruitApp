//
//  CellPackages.swift
//  RecruitApp
//
//  Created by MAC on 13/04/21.
//

import UIKit

class CellPackages: UITableViewCell {

    @IBOutlet weak var lbltag_label: UILabel!
    @IBOutlet weak var lbltitle: UILabel!
    @IBOutlet weak var lblspecial_price: UILabel!
    @IBOutlet weak var lblprice: UILabel!
    @IBOutlet weak var lblnumber_of_jobs: UILabel!
    @IBOutlet weak var lblnumber_of_days: UILabel!
    @IBOutlet weak var lbldescription_text: UILabel!
    @IBOutlet weak var viewSpecialPrice: UIView!
    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var imgSelected: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

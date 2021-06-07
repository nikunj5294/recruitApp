//
//  JobEmployerCell.swift
//  RecruitApp
//
//  Created by MAC on 13/02/21.
//

import UIKit

class JobEmployerCell: UITableViewCell {

    @IBOutlet weak var lblTitleOBj: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgJobObj: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

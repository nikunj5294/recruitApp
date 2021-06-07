//
//  CellLocation.swift
//  RecruitApp
//
//  Created by MAC on 27/02/21.
//

import UIKit

class CellLocation: UITableViewCell {

    @IBOutlet weak var locationTickImage: UIImageView!
    @IBOutlet weak var lblLocationTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

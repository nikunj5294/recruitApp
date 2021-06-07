//
//  CellSeekerAppliedJobs.swift
//  RecruitApp
//
//  Created by MAC on 29/04/21.
//

import UIKit

class CellSeekerAppliedJobs: UITableViewCell {

    @IBOutlet weak var imgJob: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblOther: UILabel!
    @IBOutlet weak var lblNewJob: UILabel!

    @IBOutlet weak var btnFeatured: UIButton!
    @IBOutlet weak var btnExpiring: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

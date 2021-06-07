//
//  CellBrowseJobs.swift
//  RecruitApp
//
//  Created by MAC on 01/05/21.
//

import UIKit

class CellBrowseJobs: UITableViewCell {

    @IBOutlet weak var imgJob: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblOther: UILabel!
    @IBOutlet weak var lblNewJob: UILabel!
    @IBOutlet weak var lblFeaturedJob: UILabel!
    @IBOutlet weak var btnApplyObj: UIButton!
    
    // MARK: - Variables
    var applyJob : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func btnApplyJobClicked(_ sender: Any) {
        applyJob?()
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//
//  CellExpiredJobList.swift
//  RecruitApp
//
//  Created by MAC on 18/02/21.
//

import UIKit

class CellExpiredJobList: UITableViewCell {

    @IBOutlet weak var lblJobTitle: UILabel!
    @IBOutlet weak var imgJobObj: UIImageView!
    @IBOutlet weak var lblJobLocation: UILabel!
    @IBOutlet weak var lblJobCountry: UILabel!
    @IBOutlet weak var lblJobType: UILabel!
    @IBOutlet weak var lblJobStatus: UILabel!

    @IBOutlet weak var lblJobExpLevel: UILabel!
    @IBOutlet weak var lblJobDuration: UILabel!
    @IBOutlet weak var lblJobEmployer: UILabel!
    @IBOutlet weak var lblJobobViewed: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

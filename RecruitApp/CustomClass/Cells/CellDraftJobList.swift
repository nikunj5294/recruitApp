//
//  CellDraftJobList.swift
//  RecruitApp
//
//  Created by MAC on 17/02/21.
//

import UIKit

class CellDraftJobList: UITableViewCell {

    @IBOutlet weak var lblJobTitle: UILabel!
    
    @IBOutlet weak var imgJobObj: UIImageView!

    @IBOutlet weak var lblJobLocation: UILabel!
    @IBOutlet weak var lblJobCountry: UILabel!
    @IBOutlet weak var lblJobType: UILabel!
    @IBOutlet weak var lblJobStatus: UILabel!

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

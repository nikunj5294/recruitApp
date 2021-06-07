//
//  CellCandidateList.swift
//  RecruitApp
//
//  Created by MAC on 19/02/21.
//

import UIKit

class CellCandidateList: UITableViewCell {

    @IBOutlet weak var lblJobTitleObj: UILabel!
    
    @IBOutlet weak var lblSeekerEmailObj: UILabel!
    @IBOutlet weak var lblSeekerNameObj: UILabel!
    
    @IBOutlet weak var btnResumeObj: UIButton!
    @IBOutlet weak var btnCoverObj: UIButton!
    
    // MARK: - Variables
    var viewResume : (()->())?
    var viewCover : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnViewResumeClicked(_ sender: Any) {
        viewResume?()
    }
    
    @IBAction func btnViewCoverClicked(_ sender: Any) {
        viewCover?()
    }
    
    
}

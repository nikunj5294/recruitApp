//
//  CellTeamMembers.swift
//  RecruitApp
//
//  Created by MAC on 26/04/21.
//

import UIKit

class CellTeamMembers: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblRole: UILabel!
    @IBOutlet weak var lblType: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!

    // MARK: - Variables
    var btnEditClicked : (()->())?
    var btnDeleteClicked : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func btnEditDeleteCliked(_ sender: UIButton) {
        
        if sender.tag == 0{
            btnEditClicked?()
        }else{
            btnDeleteClicked?()
        }
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

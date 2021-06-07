//
//  CellTransactionList.swift
//  RecruitApp
//
//  Created by MAC on 19/02/21.
//

import UIKit

class CellTransactionList: UITableViewCell {

    @IBOutlet weak var lblJobPlanObj: UILabel!
    
    @IBOutlet weak var lblTotalJobsObj: UILabel!
    @IBOutlet weak var lblPaymentTypeObj: UILabel!
    @IBOutlet weak var lblPaymentAmountObj: UILabel!
    
    @IBOutlet weak var lblTimeOBj: UILabel!
    
    @IBOutlet weak var lblStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

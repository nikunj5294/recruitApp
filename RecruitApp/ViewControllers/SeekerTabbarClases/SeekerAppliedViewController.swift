//
//  SeekerAppliedViewController.swift
//  RecruitApp
//
//  Created by MAC on 29/04/21.
//

import UIKit

class SeekerAppliedViewController: UIViewController {

    @IBOutlet weak var tblObj: UITableView!
    var appliedJobsData = [AppliedJobDataModel]()
    
    var current_page = 1
    var last_page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblObj.estimatedRowHeight = 500
        tblObj.rowHeight = UITableView.automaticDimension
        tblObj.register(nib: UINib(nibName: "CellSeekerAppliedJobs", bundle: nil), withCellClass: CellSeekerAppliedJobs.self)
        tblObj.tableFooterView = UIView()
        
        callAppliedJobListAPI()
        
        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


// MARK: - UITableViewDelegate & Datasource

extension SeekerAppliedViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appliedJobsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblObj.dequeueReusableCell(withClass: CellSeekerAppliedJobs.self, for: indexPath)
        let teamDataModel = appliedJobsData[indexPath.row]
       
        cell.lblName.text = teamDataModel.job_title
        cell.lblDescription.text = teamDataModel.job_sort_description
        cell.lblPrice.text = "$\(teamDataModel.budget) NZD"
        cell.lblLocation.text = teamDataModel.locations[0].name
        cell.lblOther.text = "Other"
        cell.lblType.text = teamDataModel.job_type_name
        cell.imgJob.sd_setImage(with: URL(string: teamDataModel.job_logo), completed: nil)
        cell.lblNewJob.isHidden = teamDataModel.is_new_job ? false : true
        cell.btnFeatured.isHidden = teamDataModel.is_feature_job ? false : true
        cell.btnExpiring.isHidden = teamDataModel.expired_soon ? false : true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == appliedJobsData.count - 1 {
            if tableView.contentSize.height > tableView.frame.size.height && current_page < last_page {
                current_page += 1
                callAppliedJobListAPI()
            }
        }
    }
    
}

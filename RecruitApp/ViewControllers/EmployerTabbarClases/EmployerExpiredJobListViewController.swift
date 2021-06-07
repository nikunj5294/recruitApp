//
//  EmployerExpiredJobListViewController.swift
//  RecruitApp
//
//  Created by MAC on 17/02/21.
//

import UIKit

class EmployerExpiredJobListViewController: UIViewController {

    @IBOutlet weak var tblJobListObj: UITableView!
    @IBOutlet weak var lblNoJobsFound: UILabel!
    
    var current_page = 1
    var last_page = 0
    var employerJobExpiredListArray = [EmployerJobDraftListDataModel]()
    var employerJobExpiredList = EmployerJobDraftListModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblJobListObj.register(nib: UINib(nibName: "CellExpiredJobList", bundle: nil), withCellClass: CellExpiredJobList.self)
        tblJobListObj.tableFooterView = UIView()
        setupData()
        callEmployerJobExpiredList()
        
        // Do any additional setup after loading the view.
    }
    
    
    func setupData(){
        tblJobListObj.isHidden = false
        lblNoJobsFound.isHidden = true
        let _ = employerJobExpiredList.data.map({employerJobExpiredListArray.append($0)})
        tblJobListObj.reloadData()
    }
    
    
    // MARK: - Button Action
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController()
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


extension EmployerExpiredJobListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employerJobExpiredListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblJobListObj.dequeueReusableCell(withClass: CellExpiredJobList.self, for: indexPath)
        
        cell.lblJobTitle.text = employerJobExpiredListArray[indexPath.row].job_title
        cell.lblJobLocation.text = "Location : \(employerJobExpiredListArray[indexPath.row].locations.count > 0 ? employerJobExpiredListArray[indexPath.row].locations[0].name : "")"
        cell.lblJobCountry.text = "Country : \(employerJobExpiredListArray[indexPath.row].country)"
        cell.lblJobType.text = "Job type : \(employerJobExpiredListArray[indexPath.row].job_type_option_name)"
        cell.lblJobStatus.text = "Status : \(employerJobExpiredListArray[indexPath.row].status_type)"
        
        cell.lblJobExpLevel.text = "Exp. Level : \(employerJobExpiredListArray[indexPath.row].experience_level)"
        cell.lblJobDuration.text = "Duration : \(employerJobExpiredListArray[indexPath.row].job_duration)"
        cell.lblJobEmployer.text = "Employer : \(employerJobExpiredListArray[indexPath.row].employer_name)"
        cell.lblJobobViewed.text = "Job viewed : \(employerJobExpiredListArray[indexPath.row].visit_count)"
        
        cell.imgJobObj.sd_setImage(with: URL(string: employerJobExpiredListArray[indexPath.row].employer_profile_image), completed: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == employerJobExpiredListArray.count - 1 {
            if tableView.contentSize.height > tableView.frame.size.height && current_page < last_page {
                current_page += 1
                callEmployerJobExpiredList()
            }
        }
    }
    
    
}

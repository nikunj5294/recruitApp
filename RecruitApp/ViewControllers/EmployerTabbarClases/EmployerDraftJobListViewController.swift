//
//  EmployerDraftJobListViewController.swift
//  RecruitApp
//
//  Created by MAC on 17/02/21.
//

import UIKit

class EmployerDraftJobListViewController: UIViewController {

    @IBOutlet weak var tblJobListObj: UITableView!
    @IBOutlet weak var lblNoJobsFound: UILabel!
    
    var employerJobDraftListModel = EmployerJobDraftListModel()
    var arrDraftJobList = [EmployerJobDraftListDataModel]()
    var current_page = 1
    var last_page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblJobListObj.register(nib: UINib(nibName: "CellDraftJobList", bundle: nil), withCellClass: CellDraftJobList.self)
        tblJobListObj.tableFooterView = UIView()
        setupData()
        callEmployerJobDraftList()
        
        // Do any additional setup after loading the view.
    }
    
    
    func setupData(){
        tblJobListObj.isHidden = false
        lblNoJobsFound.isHidden = true
        let _ = employerJobDraftListModel.data.map({arrDraftJobList.append($0)})
        tblJobListObj.reloadData()
    }
    
    
    // MARK: - Button Action
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController()
    }

    func setModelData(objDataModel:EmployerJobDraftListDataModel) -> EmployerJobUpdateDataModel {
        let employerDataModelObj = EmployerJobUpdateDataModel()
        employerDataModelObj.job_title = objDataModel.job_title
        employerDataModelObj.categories = objDataModel.categories.map{ $0.id}.joined(separator: ",")
        employerDataModelObj.locations = objDataModel.locations.map{ $0.id}.joined(separator: ",")
        employerDataModelObj.experience_level = objDataModel.experience_level
        employerDataModelObj.job_duration = objDataModel.job_duration
        employerDataModelObj.skills = objDataModel.skills.map{ $0}.joined(separator: ",")
        employerDataModelObj.top_job_start_date = objDataModel.top_job_start_date
        employerDataModelObj.job_type = objDataModel.job_type
        employerDataModelObj.salary_type = objDataModel.salary_type
        employerDataModelObj.budget = objDataModel.budget
        employerDataModelObj.per_week = objDataModel.per_week
        employerDataModelObj.salary_min = objDataModel.salary_min
        employerDataModelObj.salary_max = objDataModel.salary_max
        employerDataModelObj.is_salary_disclosed = objDataModel.is_salary_disclosed
        employerDataModelObj.job_description = objDataModel.job_description
        employerDataModelObj.id = objDataModel.id
        employerDataModelObj.is_top_jobs = objDataModel.is_top_jobs
        employerDataModelObj.contact_name = objDataModel.contact_name
        employerDataModelObj.position = objDataModel.position
        employerDataModelObj.contact_number = objDataModel.contact_number
        employerDataModelObj.contact_email = objDataModel.contact_email
        employerDataModelObj.job_logo = objDataModel.job_logo
        employerDataModelObj.job_duration_custom = objDataModel.job_duration_custom
        employerDataModelObj.job_sort_description = objDataModel.job_sort_description
        employerDataModelObj.job_sort_description = objDataModel.job_sort_description
        employerDataModelObj.job_type_option = objDataModel.job_type_option
        employerDataModelObj.user_id = objDataModel.user_id
        employerDataModelObj.is_team_member = objDataModel.is_team_member
        employerDataModelObj.package_id = objDataModel.package_id
        return employerDataModelObj
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


extension EmployerDraftJobListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrDraftJobList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblJobListObj.dequeueReusableCell(withClass: CellDraftJobList.self, for: indexPath)
        
        let draftJob = arrDraftJobList[indexPath.row]
        cell.lblJobTitle.text = draftJob.job_title
        cell.lblJobLocation.text = "Location : \(draftJob.locations.count > 0 ? draftJob.locations[0].name : "")"
        cell.lblJobCountry.text = "Country : \(draftJob.country)"
        cell.lblJobType.text = "Job type : \(draftJob.job_type_option_name)"
        cell.lblJobStatus.text = "Status : \(draftJob.status_type)"
        cell.imgJobObj.sd_setImage(with: URL(string: draftJob.employer_profile_image), completed: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let postVC = self.storyboard?.instantiateViewController(identifier: "EmployerPostJobViewController") as! EmployerPostJobViewController
        postVC.isUpdatePost = true
        postVC.employerJobDraftListDataModelObj = setModelData(objDataModel: arrDraftJobList[indexPath.row])
        self.navigationController?.pushViewController(postVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == arrDraftJobList.count - 1 {
            if tableView.contentSize.height > tableView.frame.size.height && current_page < last_page {
                current_page += 1
                callEmployerJobDraftList()
            }
        }
    }
}

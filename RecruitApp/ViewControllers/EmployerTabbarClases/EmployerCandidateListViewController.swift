//
//  EmployerCandidateListViewController.swift
//  RecruitApp
//
//  Created by MAC on 19/02/21.
//

import UIKit

class EmployerCandidateListViewController: UIViewController {

    @IBOutlet weak var tblCandidateListObj: UITableView!
    @IBOutlet weak var lblNoJobsFound: UILabel!

    var CandidateListDataArray = [CandidateListDataModel]()
    var CandidateList = CandidateListModel()
    var current_page = 1
    var last_page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblCandidateListObj.register(nib: UINib(nibName: "CellCandidateList", bundle: nil), withCellClass: CellCandidateList.self)
        tblCandidateListObj.tableFooterView = UIView()
        setupData()
        callCandidateList()
        
        // Do any additional setup after loading the view.
    }
    
    func setupData(){
        tblCandidateListObj.isHidden = false
        lblNoJobsFound.isHidden = true
        let _ = CandidateList.data.map({CandidateListDataArray.append($0)})
        tblCandidateListObj.reloadData()
    }
    
    func redirectToBrowser(str:String) {
        guard let url = URL(string: str) else {
             return
        }
        if UIApplication.shared.canOpenURL(url) {
             UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
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

extension EmployerCandidateListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CandidateListDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblCandidateListObj.dequeueReusableCell(withClass: CellCandidateList.self, for: indexPath)
        let CandidateDataModel = CandidateListDataArray[indexPath.row]
        cell.lblJobTitleObj.text = CandidateDataModel.job_title
        cell.lblSeekerEmailObj.text = CandidateDataModel.seeker_email
        cell.lblSeekerNameObj.text = CandidateDataModel.seeker_name
        
        cell.viewResume = {
            self.redirectToBrowser(str: CandidateDataModel.resume_file_path)
        }
        
        cell.viewCover = {
            self.redirectToBrowser(str: CandidateDataModel.cover_latter_file_path)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == CandidateListDataArray.count - 1 {
            if tableView.contentSize.height > tableView.frame.size.height && current_page < last_page {
                current_page += 1
                callCandidateList()
            }
        }
    }
    
}

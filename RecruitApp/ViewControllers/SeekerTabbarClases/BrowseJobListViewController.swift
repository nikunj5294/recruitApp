//
//  BrowseJobListViewController.swift
//  RecruitApp
//
//  Created by MAC on 30/04/21.
//

import UIKit

class BrowseJobListViewController: UIViewController {
    
    var searchJobsData = [SearchJobListDataModel]()
    var locationListArray = [LocationListDataModel]()
    var categoryListArray = [CategoryListDataModel]()
    
    @IBOutlet weak var tblObj: UITableView!
    @IBOutlet weak var viewHeader: UIView!
    @IBOutlet weak var lblBrowseJobList: UILabel!

    var current_page = 1
    var last_page = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblObj.estimatedRowHeight = 500
        tblObj.rowHeight = UITableView.automaticDimension
        tblObj.register(nib: UINib(nibName: "CellBrowseJobs", bundle: nil), withCellClass: CellBrowseJobs.self)
        tblObj.tableFooterView = UIView()
        tblObj.tableHeaderView = viewHeader
        
        callSearchJobListAPI()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnFilterClicked(_ sender: Any) {
        
        let postVC = self.storyboard?.instantiateViewController(identifier: "BrowseJobFilterViewController") as! BrowseJobFilterViewController
        self.navigationController?.pushViewController(postVC, animated: true)
        
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

extension BrowseJobListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchJobsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblObj.dequeueReusableCell(withClass: CellBrowseJobs.self, for: indexPath)
        let teamDataModel = searchJobsData[indexPath.row]
        cell.lblName.text = teamDataModel.job_title
        cell.lblDescription.text = teamDataModel.job_sort_description
        cell.lblPrice.text = "$\(teamDataModel.budget) NZD"
        cell.lblLocation.text = teamDataModel.locations[0].name
        cell.lblOther.text = "Other"
        cell.lblType.text = teamDataModel.job_type_name
        cell.imgJob.sd_setImage(with: URL(string: teamDataModel.job_logo), completed: nil)
        cell.lblNewJob.isHidden = teamDataModel.is_new_job ? false : true
        cell.lblFeaturedJob.isHidden = teamDataModel.is_feature_job ? false : true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let BrowseJobDetailsVC = self.storyboard?.instantiateViewController(identifier: "BrowseJobDetailsViewController") as! BrowseJobDetailsViewController
        BrowseJobDetailsVC.slugname = searchJobsData[indexPath.row].slug
        self.navigationController?.pushViewController(BrowseJobDetailsVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == searchJobsData.count - 1 {
            if tableView.contentSize.height > tableView.frame.size.height && current_page < last_page {
                current_page += 1
                callSearchJobListAPI()
            }
        }
    }
    
}

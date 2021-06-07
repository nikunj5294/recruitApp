//
//  EmployerJobListViewController.swift
//  RecruitApp
//
//  Created by MAC on 13/02/21.
//

import UIKit
import SDWebImage

class EmployerJobListViewController: UIViewController {
    
    @IBOutlet weak var tblJobListObj: UITableView!
    @IBOutlet weak var lblNoJobsFound: UILabel!
    
    var employerJobListArray = [EmployerJobListDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblJobListObj.register(nib: UINib(nibName: "JobEmployerCell", bundle: nil), withCellClass: JobEmployerCell.self)
        tblJobListObj.tableFooterView = UIView()
        callEmployerJobList()
        
        // Do any additional setup after loading the view.
    }
    
    
    func setupData(){
        tblJobListObj.isHidden = false
        lblNoJobsFound.isHidden = true
        tblJobListObj.reloadData()
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


extension EmployerJobListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employerJobListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblJobListObj.dequeueReusableCell(withClass: JobEmployerCell.self, for: indexPath)
        cell.lblTitleOBj.text = employerJobListArray[indexPath.row].job_title
        cell.lblDescription.text = employerJobListArray[indexPath.row].remaining_time
        cell.imgJobObj.sd_setImage(with: URL(string: employerJobListArray[indexPath.row].job_logo), completed: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

    }
    
}

//
//  ManageTeamViewController.swift
//  RecruitApp
//
//  Created by MAC on 25/04/21.
//

import UIKit

class ManageTeamViewController: UIViewController {

    @IBOutlet var tblFooterViewObj: UIView!
    @IBOutlet weak var tblObj: UITableView!

    
    var teamListArray = [TeamListDataModel]()
    
    var current_page = 1
    var last_page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblObj.tableFooterView = tblFooterViewObj
        tblObj.register(nib: UINib(nibName: "CellTeamMembers", bundle: nil), withCellClass: CellTeamMembers.self)
        
        callTeamListAPI()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnAddClicked(_ sender: Any) {
        let addTeamMemberVC = self.storyboard?.instantiateViewController(identifier: "AddTeamMemberViewController") as! AddTeamMemberViewController
        addTeamMemberVC.delegateRefreshMemberList = self
        self.navigationController?.pushViewController(addTeamMemberVC, animated: true)
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

extension ManageTeamViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblObj.dequeueReusableCell(withClass: CellTeamMembers.self, for: indexPath)
        let teamDataModel = teamListArray[indexPath.row]
        cell.lblName.text = "\(teamDataModel.first_name) \(teamDataModel.last_name)"
        cell.lblEmail.text = "Email : \(teamDataModel.email)"
        cell.lblRole.text = "Role : \(teamDataModel.role)"
        cell.lblType.text = "Site Access : \(teamDataModel.type == "2" ? "Hiring Manager" : "Site Admin")"
        cell.btnEditClicked = {
            let addTeamMemberVC = self.storyboard?.instantiateViewController(identifier: "AddTeamMemberViewController") as! AddTeamMemberViewController
            addTeamMemberVC.delegateRefreshMemberList = self
            addTeamMemberVC.isEdit = true
            addTeamMemberVC.teamData = teamDataModel
            self.navigationController?.pushViewController(addTeamMemberVC, animated: true)
            
        }
        
        cell.btnDeleteClicked = {
            self.showAlert(title: strAppName, message: "Are you sure you want to delete this team member?", buttonTitles: ["No","Yes"], highlightedButtonIndex: 0) { (intNumber) in
                if intNumber == 1{
                    self.callDeleteTeamAPI(selectedIndex: indexPath.row)
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == teamListArray.count - 1 {
            if tableView.contentSize.height > tableView.frame.size.height && current_page < last_page {
                current_page += 1
                callTeamListAPI()
            }
        }
    }
    
}

extension ManageTeamViewController : refreshMemberListDelegate{
    func refreshMemberList() {
        DispatchQueue.main.async {
            self.callTeamListAPI()
        }
    }
}

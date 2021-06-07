//
//  SelectJobTypeOptionViewController.swift
//  RecruitApp
//
//  Created by MAC on 16/04/21.
//

import UIKit

protocol passJobTypeOptionDataDelegate {
    func JobTypeOptionDataPass(typeData:[String:String])
}

protocol passSalaryTypeOptionDataDelegate {
    func SalaryTypeOptionDataPass(typeData:[String:String])
}

class SelectJobTypeOptionViewController: UIViewController {

    @IBOutlet weak var tblObj: UITableView!
    @IBOutlet weak var lblTitleObj: UILabel!

    var delegateJobTypeOptionLevel: passJobTypeOptionDataDelegate?
    var delegateSalaryTypeOptionLevel: passSalaryTypeOptionDataDelegate?

    var JobTypeData = [["id":"1","name":"Full Time"],["id":"2","name":"Part Time"],["id":"3","name":"Contract"], ["id":"4","name":"Temporary"]]
    
    var SalaryTypeData = [["id":"0","name":"Annual"],["id":"1","name":"Annual Plus Commission"]]

    
    var employerJobDraftListDataModelObj = EmployerJobDraftListDataModel()
    var selectedIndex = 0
    var isJobType = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        tblObj.register(nib: UINib(nibName: "CellLocation", bundle: nil), withCellClass: CellLocation.self)
        tblObj.reloadData()
        tblObj.tableFooterView = UIView()
        
        lblTitleObj.text = isJobType ? "Select Job Type" : "Select Salary Type"
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCloseClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnDoneClicked(_ sender: Any) {
        
        if isJobType{
            delegateJobTypeOptionLevel?.JobTypeOptionDataPass(typeData: JobTypeData[selectedIndex])
        }else{
            delegateSalaryTypeOptionLevel?.SalaryTypeOptionDataPass(typeData: SalaryTypeData[selectedIndex])
        }
        
        
        self.dismiss(animated: true, completion: nil)
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

extension SelectJobTypeOptionViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isJobType ? JobTypeData.count : SalaryTypeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblObj.dequeueReusableCell(withIdentifier: "CellLocation", for: indexPath) as! CellLocation
        let data = isJobType ? JobTypeData[indexPath.row] : SalaryTypeData[indexPath.row]
        cell.lblLocationTitle.text = data["name"]
        cell.locationTickImage.image = UIImage(named: selectedIndex == indexPath.row ? "ic_radio_selected" : "ic_radio_unselected")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tblObj.reloadData()
    }
    
}

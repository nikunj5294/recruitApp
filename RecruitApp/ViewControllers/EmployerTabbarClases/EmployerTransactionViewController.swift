//
//  EmployerTransactionViewController.swift
//  RecruitApp
//
//  Created by MAC on 18/02/21.
//

import UIKit

class EmployerTransactionViewController: UIViewController {

    @IBOutlet weak var tblTransactionObj: UITableView!
    @IBOutlet weak var lblNoJobsFound: UILabel!
    
    var current_page = 1
    var last_page = 0
    var employerTransactionList = EmployerTransactionListModel()
    var employerTransactionListArray = [EmployerTransactionListDataModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblTransactionObj.register(nib: UINib(nibName: "CellTransactionList", bundle: nil), withCellClass: CellTransactionList.self)
        tblTransactionObj.tableFooterView = UIView()
        setupData()
        callEmployerTransactionList()
        
        // Do any additional setup after loading the view.
    }
    
    func setupData(){
        tblTransactionObj.isHidden = false
        lblNoJobsFound.isHidden = true
        let _ = employerTransactionList.data.map({employerTransactionListArray.append($0)})
        tblTransactionObj.reloadData()
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

extension EmployerTransactionViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employerTransactionListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblTransactionObj.dequeueReusableCell(withClass: CellTransactionList.self, for: indexPath)
        let transactionDataModel = employerTransactionListArray[indexPath.row]
        cell.lblJobPlanObj.text = transactionDataModel.service_name
        cell.lblTotalJobsObj.text = transactionDataModel.number_of
        cell.lblPaymentTypeObj.text = transactionDataModel.payment_type
        cell.lblPaymentAmountObj.text = transactionDataModel.payment_amount
        cell.lblTimeOBj.text = transactionDataModel.transaction_date
        cell.lblStatus.text = transactionDataModel.payment_status

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        

    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == employerTransactionListArray.count - 1 {
            if tableView.contentSize.height > tableView.frame.size.height && current_page < last_page {
                current_page += 1
                callEmployerTransactionList()
            }
        }
    }
}

//
//  EmployerPackgesViewController.swift
//  RecruitApp
//
//  Created by MAC on 28/02/21.
//

import UIKit

class EmployerPackgesViewController: UIViewController {

    @IBOutlet weak var tblJobListObj: UITableView!
    @IBOutlet weak var lblNoJobsFound: UILabel!
    @IBOutlet var viewNext: UIView!
    
    var specialPriceColor = ["#3598db","#17a086","#f1c40f","#8c24eb","#3598db","#17a086","#f1c40f","#8c24eb","#3598db","#17a086","#f1c40f","#8c24eb"]
    
    var tagLabelColor = ["#f39c12","#e74c3c","#ff240d","#436fff","#f39c12","#e74c3c","#ff240d","#436fff","#f39c12","#e74c3c","#ff240d","#436fff"]
    
    var packgesListArray = [PackagesListDataModel]()
    var employerJobDraftListDataModelObj = EmployerJobUpdateDataModel()
    var selectedPackageID = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblJobListObj.rowHeight = UITableView.automaticDimension
        tblJobListObj.estimatedRowHeight = 294
        tblJobListObj.register(nib: UINib(nibName: "CellPackages", bundle: nil), withCellClass: CellPackages.self)
        
        DispatchQueue.main.async {
            self.callAPIpackageList()
        }
        
        selectedPackageID = employerJobDraftListDataModelObj.package_id.count > 0 ? employerJobDraftListDataModelObj.package_id.int ?? 0 : 0
        
        // Do any additional setup after loading the view.
    }
   
    
    // MARK: - Button Actions

    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController()
    }
    
    @IBAction func btnNextClicked(_ sender: Any) {
        self.callAPIJobUpdate()
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

extension EmployerPackgesViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return packgesListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblJobListObj.dequeueReusableCell(withClass: CellPackages.self, for: indexPath)
        
        let package = packgesListArray[indexPath.row]
        cell.lbltag_label.text = package.tag_label
        cell.lbltitle.text = package.title
        cell.lblprice.text = package.price
        cell.lblspecial_price.text = package.special_price
        cell.lblnumber_of_jobs.text = package.number_of_jobs
        cell.lblnumber_of_days.text = package.number_of_days
        cell.lbldescription_text.attributedText = package.description_text.htmlToAttributedString
        cell.lblCurrency.text = "$"
        
        let colorData = UIColor(hexString: specialPriceColor[indexPath.row])
        cell.viewSpecialPrice.backgroundColor = colorData
        cell.lblprice.textColor = colorData
        cell.lblnumber_of_days.textColor = colorData
        cell.lblnumber_of_jobs.textColor = colorData
        cell.lblCurrency.textColor = colorData
        cell.lbltag_label.backgroundColor = UIColor(hexString: tagLabelColor[indexPath.row])
        
        if employerJobDraftListDataModelObj.package_id.int ?? 0 == package.id.int ?? 0{
            cell.imgSelected.isHidden = false
        }else{
            cell.imgSelected.isHidden = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        employerJobDraftListDataModelObj.package_id = packgesListArray[indexPath.row].id
        tblJobListObj.reloadData()
    }
    
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

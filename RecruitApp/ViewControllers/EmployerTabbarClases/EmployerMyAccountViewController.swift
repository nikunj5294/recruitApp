//
//  EmployerMyAccountViewController.swift
//  RecruitApp
//
//  Created by MAC on 15/02/21.
//

import UIKit
import SDWebImage


class EmployerMyAccountViewController: UIViewController {

    @IBOutlet var lblNameObj: UILabel!
    @IBOutlet var lblUserTypeObj: UILabel!
    @IBOutlet var imgUser: UIImageView!
    
    @IBOutlet var viewHeaderObj: UIView!
    @IBOutlet weak var tblViewObj: UITableView!
    
    
    var arrTitle = ["My Profile","Draft Jobs","Expired Jobs","Transactions","Candidate List","Manage Team","Change Password","How it Works?","Share App","FAQs","Privacy Policy","Contact Us","Logout"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tblViewObj.register(nib: UINib(nibName: "CellMyAccount", bundle: nil), withCellClass: CellMyAccount.self)
        tblViewObj.tableFooterView = UIView()
        tblViewObj.tableHeaderView = viewHeaderObj
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupData()
    }

    func setupData() {
        let getDashboardData = self.getDashboardData()
        lblNameObj.text = getDashboardData.name
        lblUserTypeObj.text = "\(userType.rawValue)"
        imgUser.sd_setImage(with: URL(string: getDashboardData.profile_image), completed: nil)
    }
    
    func redirectToBrowser(str:String) {
        guard let url = URL(string: str) else {
             return
        }
        if UIApplication.shared.canOpenURL(url) {
             UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
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

extension EmployerMyAccountViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblViewObj.dequeueReusableCell(withIdentifier: "CellMyAccount") as! CellMyAccount
        cell.lblTitleObj.text = arrTitle[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch arrTitle[indexPath.row] {
        case "My Profile":
            let empProfile = self.storyboard?.instantiateViewController(identifier: "EmployerProfileViewController") as! EmployerProfileViewController
            self.navigationController?.pushViewController(empProfile)
        case "Draft Jobs":
            let draftJob = self.storyboard?.instantiateViewController(identifier: "EmployerDraftJobListViewController") as! EmployerDraftJobListViewController
            self.navigationController?.pushViewController(draftJob)
        case "Expired Jobs":
            let draftJob = self.storyboard?.instantiateViewController(identifier: "EmployerExpiredJobListViewController") as! EmployerExpiredJobListViewController
            self.navigationController?.pushViewController(draftJob)
        case "Manage Team":
            let draftJob = self.storyboard?.instantiateViewController(identifier: "ManageTeamViewController") as! ManageTeamViewController
            self.navigationController?.pushViewController(draftJob)
        case "FAQs":
            redirectToBrowser(str: "https://www.google.com")
        case "How it Works?":
            redirectToBrowser(str: "https://www.recruit.nz/about-us")
        case "Privacy Policy":
            redirectToBrowser(str: "https://www.recruit.nz/privacy-policy")
        case "Transactions":
            let transactionList = self.storyboard?.instantiateViewController(identifier: "EmployerTransactionViewController") as! EmployerTransactionViewController
            self.navigationController?.pushViewController(transactionList)
        case "Candidate List":
            let transactionList = self.storyboard?.instantiateViewController(identifier: "EmployerCandidateListViewController") as! EmployerCandidateListViewController
            self.navigationController?.pushViewController(transactionList)
        case "Change Password":
            let changePasswordVC = self.storyboard?.instantiateViewController(identifier: "ChangePasswordViewController") as! ChangePasswordViewController
            changePasswordVC.modalPresentationStyle = .overCurrentContext
            changePasswordVC.delegateSendMessage = self
            self.navigationController?.present(changePasswordVC, animated: true, completion: nil)
        case "Contact Us":
            let ContactUs = self.storyboard?.instantiateViewController(identifier: "ContactUsViewController") as! ContactUsViewController
            self.navigationController?.pushViewController(ContactUs)
        case "Logout":
            showAlert(title: strAppName, message: "Are you sure you want to logout?", buttonTitles: ["No","Yes"], highlightedButtonIndex: 0) { (intNumber) in
                if intNumber == 1{
                    self.navigationController?.viewControllers.forEach({ (viewController) in
                        if viewController is LoginViewController{
                            LoginDataModel.currentUser = LoginDataModel()
                            self.navigationController?.popToViewController(viewController, animated: true)
                        }
                    })
                }
            }
         
        default:
            break
        }
    }
    
}

extension EmployerMyAccountViewController : passMessage{
    func passwordChanged(strMessage: String) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            self.showAlertView(message: strMessage)
        }
    }
}

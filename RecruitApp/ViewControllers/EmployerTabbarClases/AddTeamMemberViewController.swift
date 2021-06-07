//
//  AddTeamMemberViewController.swift
//  RecruitApp
//
//  Created by MAC on 25/04/21.
//

import UIKit

protocol refreshMemberListDelegate {
    func refreshMemberList()
}

class AddTeamMemberViewController: UIViewController {

    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtRole: UITextField!
    @IBOutlet weak var txtType: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!
    
    
    var selectedType = "2"
    var delegateRefreshMemberList:refreshMemberListDelegate?
    var isEdit = false
    var teamData = TeamListDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if isEdit{
            btnSubmit.setTitle("Update", for: .normal)
            setupEditData()
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.endEditing(true)
    }
    
    func setupEditData()  {
        txtFirstName.text = teamData.first_name
        txtLastName.text = teamData.last_name
        txtEmail.text = teamData.email
        txtRole.text = teamData.role
        txtType.text = teamData.type == "2" ? "Hiring Manager" : "Site Admin"
        selectedType = teamData.type
    }
    
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnSubmitClicked(_ sender: Any) {
        if validation(){
            callCreateTeamAPI()
        }
    }
    
    func validation() -> Bool{
        
        var isValid = true
        
        if txtFirstName.text!.trimmed.isEmpty || txtLastName.text!.trimmed.isEmpty || txtEmail.text!.trimmed.isEmpty || txtRole.text!.trimmed.isEmpty || txtType.text!.trimmed.isEmpty{
            isValid = false
            showAlertView(message: "All fields are required.")
        }else if !txtEmail.hasValidEmail{
            showAlertView(message: "Please enter valid email")
            isValid = false
        }
        
        return isValid
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

extension AddTeamMemberViewController : UITextFieldDelegate, passMemberTypeDelegate{
    func MemberTypePass(memberType: [String : String]) {
        txtType.text = memberType["name"]
        selectedType = memberType["id"] ?? "2"
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        
        if textField == txtType{
            self.view.endEditing(true)
            let selectTypeVC = self.storyboard?.instantiateViewController(identifier: "SelectMemberTypeViewController") as! SelectMemberTypeViewController
            selectTypeVC.modalPresentationStyle = .overCurrentContext
            selectTypeVC.selectedTypeData = selectedType
            selectTypeVC.delegateMemberType = self
            self.navigationController?.present(selectTypeVC, animated: true, completion: nil)
            return false
        }
        
        return true
    }
 
    
}


//
//  ContactDetailsViewController.swift
//  RecruitApp
//
//  Created by MAC on 19/04/21.
//

import UIKit

class ContactDetailsViewController: UIViewController {

    @IBOutlet weak var imgAddTeamMember: UIImageView!

    @IBOutlet weak var txtContactName: UITextField!
    @IBOutlet weak var txtContactEmail: UITextField!
    @IBOutlet weak var txtContactNumber: UITextField!
    @IBOutlet weak var txtPosition: UITextField!

    @IBOutlet weak var viewTeamMember: UIView!
    
    var employerJobDraftListDataModelObj = EmployerJobUpdateDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewTeamMember.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnAddTeamMemberClicked(_ sender: UIButton) {
        
        sender.isSelected.toggle()
        imgAddTeamMember.image = UIImage(named:  sender.isSelected ? "ic_tick_box" : "ic_untick_box")
        
        if sender.isSelected{
            viewTeamMember.isHidden = false
        }else{
            viewTeamMember.isHidden = true
        }
    }

    // MARK: - Button Actions

    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController()
    }
    
    @IBAction func btnNextClicked(_ sender: Any) {
        callAPIJobUpdate()
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

extension ContactDetailsViewController : UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == txtContactName{
            employerJobDraftListDataModelObj.contact_name = textField.text ?? ""
        }else if textField == txtContactEmail{
            employerJobDraftListDataModelObj.contact_email = textField.text ?? ""
        }else if textField == txtContactNumber{
            employerJobDraftListDataModelObj.contact_number = textField.text ?? ""
        }else if textField == txtPosition{
            employerJobDraftListDataModelObj.position = textField.text ?? ""
        }
    }
    
}

//
//  SalaryInformationViewController.swift
//  RecruitApp
//
//  Created by MAC on 16/04/21.
//

import UIKit

class SalaryInformationViewController: UIViewController {

    @IBOutlet weak var txtJobTypeObj: UITextField!
    @IBOutlet weak var txtSalaryTypeObj: UITextField!
    @IBOutlet weak var txtHourPayObj: UITextField!
    @IBOutlet weak var txtMinSalaryObj: UITextField!
    @IBOutlet weak var txtMaxSalaryObj: UITextField!

    @IBOutlet weak var stackByHourly: UIStackView!
    @IBOutlet weak var stackByAnnually: UIStackView!

    @IBOutlet weak var imgByHourly: UIImageView!
    @IBOutlet weak var imgByAnnually: UIImageView!
    @IBOutlet weak var imgByCommisionOnly: UIImageView!
    
    
    @IBOutlet weak var imgHoursPerWeekOne: UIImageView!
    @IBOutlet weak var imgHoursPerWeekTwo: UIImageView!
    @IBOutlet weak var imgHoursPerWeekThree: UIImageView!
    @IBOutlet weak var imgHoursPerWeekFour: UIImageView!
    @IBOutlet weak var imgHoursPerWeekFive: UIImageView!
    
    @IBOutlet weak var btnDisclouse: UIButton!

    @IBOutlet weak var viewSalaryType: UIView!
    @IBOutlet weak var imgdisclouseSalary: UIImageView!

    
    
    var employerJobDraftListDataModelObj = EmployerJobUpdateDataModel()
    
    var JobTypeData = [["id":"1","name":"Full Time"],["id":"2","name":"Part Time"],["id":"3","name":"Contract"], ["id":"4","name":"Temporary"]]
    
    var SalaryTypeData = [["id":"0","name":"Annual"],["id":"1","name":"Annual Plus Commission"]]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupData()
        setupUIdata()
        
        // Do any additional setup after loading the view.
    }
    
    func setupData()  {
        
        stackByHourly.isHidden = false
        stackByAnnually.isHidden = true
        
    }
    
    func setupUIdata()  {
        
        unSelectedHoursPerWeekButton()
        let img = UIImage(named: "ic_radio_selected")
        
        switch employerJobDraftListDataModelObj.per_week {
        case "1-9":
            imgHoursPerWeekOne.image = img
            break
        case "10-19":
            imgHoursPerWeekTwo.image = img
            break
        case "20-29":
            imgHoursPerWeekThree.image = img
            break
        case "30-39":
            imgHoursPerWeekFour.image = img
            break
        case "40+":
            imgHoursPerWeekFive.image = img
            break
        default:
            employerJobDraftListDataModelObj.per_week = "1-9"
            imgHoursPerWeekOne.image = img
        }
        
        JobTypeData.forEach { (dataObj) in
            if let idObj = dataObj["id"]{
                if employerJobDraftListDataModelObj.job_type_option == idObj{
                    txtJobTypeObj.text = dataObj["name"] ?? ""
                }
            }
        }

        SalaryTypeData.forEach { (dataObj) in
            if let idObj = dataObj["id"]{
                if employerJobDraftListDataModelObj.salary_type == idObj{
                    txtSalaryTypeObj.text = dataObj["name"] ?? ""
                }
            }
        }
        
        setPayData(index: employerJobDraftListDataModelObj.job_type.int ?? 1)
        txtMinSalaryObj.text = employerJobDraftListDataModelObj.salary_min
        txtMaxSalaryObj.text = employerJobDraftListDataModelObj.salary_max
        txtHourPayObj.text = employerJobDraftListDataModelObj.budget
        
        imgdisclouseSalary.image = UIImage(named:  employerJobDraftListDataModelObj.is_salary_disclosed == "1" ? "ic_tick_box" : "ic_untick_box")
        btnDisclouse.isSelected = employerJobDraftListDataModelObj.is_salary_disclosed == "1" ? true : false
        
    }

    // MARK: - Button Actions

    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController()
    }
    
    @IBAction func btnPayTypeClicked(_ sender: UIButton) {
        setPayData(index: sender.tag+1)
    }
    
    func setPayData(index:Int)  {
        
        unSelectedPayTypeButton()
        let img = UIImage(named: "ic_radio_selected")
        switch index {
        case 1:
            employerJobDraftListDataModelObj.job_type = "1"
            imgByHourly.image = img
            stackByHourly.isHidden = false
            stackByAnnually.isHidden = true
            break
        case 2:
            employerJobDraftListDataModelObj.job_type = "2"
            viewSalaryType.isHidden = false
            imgByAnnually.image = img
            stackByHourly.isHidden = true
            stackByAnnually.isHidden = false
            break
        case 3:
            employerJobDraftListDataModelObj.job_type = "3"
            viewSalaryType.isHidden = true
            imgByCommisionOnly.image = img
            stackByHourly.isHidden = true
            stackByAnnually.isHidden = false
            break
        default:
            employerJobDraftListDataModelObj.job_type = "1"
            imgByHourly.image = img
            stackByHourly.isHidden = false
            stackByAnnually.isHidden = true
        }
        
    }
    
    func unSelectedPayTypeButton() {
        
        imgByHourly.image = UIImage(named: "ic_radio_unselected")
        imgByAnnually.image = imgByHourly.image
        imgByCommisionOnly.image = imgByHourly.image
    }
    
    @IBAction func btnHoursPerClicked(_ sender: UIButton) {
        
        unSelectedHoursPerWeekButton()
        let img = UIImage(named: "ic_radio_selected")
        switch sender.tag {
        case 0:
            employerJobDraftListDataModelObj.per_week = "1-9"
            imgHoursPerWeekOne.image = img
            break
        case 1:
            employerJobDraftListDataModelObj.per_week = "10-19"
            imgHoursPerWeekTwo.image = img
            break
        case 2:
            employerJobDraftListDataModelObj.per_week = "20-29"
            imgHoursPerWeekThree.image = img
            break
        case 3:
            employerJobDraftListDataModelObj.per_week = "30-39"
            imgHoursPerWeekFour.image = img
            break
        case 4:
            employerJobDraftListDataModelObj.per_week = "40+"
            imgHoursPerWeekFive.image = img
            break
        default:
            print("Not Clicked")
        }
        
    }
    
    
    func unSelectedHoursPerWeekButton() {
        
        imgHoursPerWeekOne.image = UIImage(named: "ic_radio_unselected")
        imgHoursPerWeekTwo.image = imgHoursPerWeekOne.image
        imgHoursPerWeekThree.image = imgHoursPerWeekOne.image
        imgHoursPerWeekFour.image = imgHoursPerWeekOne.image
        imgHoursPerWeekFive.image = imgHoursPerWeekOne.image
    }
    
    
    @IBAction func btnDiscloseSalaryClicked(_ sender: UIButton) {
        
        sender.isSelected.toggle()
        imgdisclouseSalary.image = UIImage(named:  sender.isSelected ? "ic_tick_box" : "ic_untick_box")
        employerJobDraftListDataModelObj.is_salary_disclosed = sender.isSelected ? "1" : "0"
    }
    
    @IBAction func btnNextClicked(_ sender: Any) {
        
        var isValidAPI = true
        
        if txtJobTypeObj.text?.count == 0 {
            isValidAPI = false
            showAlertView(message: "Please Select Job Type")
        }else{
            if employerJobDraftListDataModelObj.job_type == "1"{
                if txtHourPayObj.text!.trimmed.isEmpty{
                    isValidAPI = false
                    showAlertView(message: "Please Enter Hourly Pay")
                }
            }else if employerJobDraftListDataModelObj.job_type == "2"{
                if txtSalaryTypeObj.text?.count == 0 {
                    isValidAPI = false
                    showAlertView(message: "Please Select Salary Type")
                }else if txtMinSalaryObj.text?.count == 0 {
                    isValidAPI = false
                    showAlertView(message: "Please Enter Minimum Salary")
                }else if txtMaxSalaryObj.text?.count == 0 {
                    isValidAPI = false
                    showAlertView(message: "Please Enter Maximum Salary")
                }
            }else if employerJobDraftListDataModelObj.job_type == "3"{
                if txtMinSalaryObj.text?.count == 0 {
                    isValidAPI = false
                    showAlertView(message: "Please Enter Minimum Salary")
                }else if txtMaxSalaryObj.text?.count == 0 {
                    isValidAPI = false
                    showAlertView(message: "Please Enter Maximum Salary")
                }
            }
        }
        
        if isValidAPI{
            self.callAPIJobUpdate()
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

extension SalaryInformationViewController : UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        switch textField {
        case txtJobTypeObj:
            let JobTypeOptionVC = self.storyboard?.instantiateViewController(identifier: "SelectJobTypeOptionViewController") as! SelectJobTypeOptionViewController
            JobTypeOptionVC.modalPresentationStyle = .overCurrentContext
            JobTypeOptionVC.delegateJobTypeOptionLevel = self
            self.navigationController?.present(JobTypeOptionVC, animated: true, completion: nil)
        case txtSalaryTypeObj:
            let JobTypeOptionVC = self.storyboard?.instantiateViewController(identifier: "SelectJobTypeOptionViewController") as! SelectJobTypeOptionViewController
            JobTypeOptionVC.modalPresentationStyle = .overCurrentContext
            JobTypeOptionVC.delegateSalaryTypeOptionLevel = self
            JobTypeOptionVC.isJobType = false
            self.navigationController?.present(JobTypeOptionVC, animated: true, completion: nil)
        case txtHourPayObj, txtMaxSalaryObj, txtMinSalaryObj:
            return true
        default:
            print("")
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        switch textField {
        case txtHourPayObj:
            employerJobDraftListDataModelObj.budget = txtHourPayObj.text ?? ""
        case txtMinSalaryObj:
            employerJobDraftListDataModelObj.salary_min = txtMinSalaryObj.text ?? ""
        case txtMaxSalaryObj:
            employerJobDraftListDataModelObj.salary_max = txtMaxSalaryObj.text ?? ""
        default:
            print("default")
        }
        
    }
    
}

extension SalaryInformationViewController : passJobTypeOptionDataDelegate{
    func JobTypeOptionDataPass(typeData: [String : String]) {
        txtJobTypeObj.text = typeData["name"] ?? ""
        employerJobDraftListDataModelObj.job_type_option = typeData["id"] ?? ""
    }
}

extension SalaryInformationViewController : passSalaryTypeOptionDataDelegate{
    func SalaryTypeOptionDataPass(typeData: [String : String]) {
        txtSalaryTypeObj.text = typeData["name"] ?? ""
        employerJobDraftListDataModelObj.salary_type = typeData["id"] ?? ""
    }
}

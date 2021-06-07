//
//  Webservices.swift
//  Helpr
//
//  Created by InexTure on 04/04/19.
//  Copyright © 2019 inexture. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import EVReflection


extension UIViewController  {
    
    var isConnectedToInternet : Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    func GenericApiCallForObject<T : URLRequestConvertible, D : EVObject>(router : T, showHud : Bool = true ,responseModel : @escaping (D) -> ()) {
        
        view.endEditing(true)
        
        if !isConnectedToInternet {
            DispatchQueue.main.async {
                //                self.showNetworkError()
            }
            return
        }
        
        if showHud{
            ShowHUD()
        }
        
        Alamofire.request(router).responseObject { (response: DataResponse<D>) in
            
            self.handleResponseWithError(response: response, customAlert: false ,isSuccess: { (success) in
                
                self.HideHUD()
                
                if success {
                    if response.result.value != nil{
                        responseModel(response.result.value!)
                    }
                }
                else {
                    
                    if response.result.value != nil{
                        responseModel(response.result.value!)
                    }else{
                        self.showAlertView(message: response.result.description)
                    }
                    
//                    if let data = response.result.value {
//                        print(data)
//                    }
                }
            })
        }
        .responseString { (resp) in
            print(resp)
        }
    }
    
    func handleResponseWithError<T:EVObject>(response : DataResponse<T>, popToRootReq : Bool = false , popRequired : Bool = false ,customAlert : Bool = true, hideHud : Bool = true, isSuccess : @escaping (Bool) -> ()) {
        
        print(response)
        if hideHud {
            HideHUD()
        }
        switch response.response?.statusCode ?? 0 {
        case 200...299:
            isSuccess(true)
        case 401:
            isSuccess(false)
            if customAlert {
                //                showTokenError()
            }
        case -1005,-1001,-1003:
            break
        default:
            isSuccess(false)
            let jsonString = response.result.value?.toJsonString()
            let modelStruct = GeneralModel(json: jsonString)
            if customAlert {
                if !modelStruct.message.isEmpty {
                    ShowAlertVC(title: "", subTitle : modelStruct.message) {
                        if popRequired {
                            self.navigationController?.popViewController()
                        } else if popToRootReq {
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                    }
                }
            }
        }
        
    }
    
    
    //MARK:- Main Stroyboard
    
    
    var Main : UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    func ShowAlertVC(title:String = "", subTitle:String = "", okAction : (()->())? = nil ) {
        
        if var topVC = UIApplication.shared.windows.first(where: { $0.rootViewController != nil })?.rootViewController {
            while let presentedViewController = topVC.presentedViewController {
                topVC = presentedViewController
            }
            let alert = UIAlertController(title: "Aerobit", message: subTitle, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in
                alert.dismiss(animated: true)
            }))
            topVC.present(alert, animated: true)
        }
    }
    
}


//MARK:- View Controller Extension
//MARK:- Employer

extension LoginViewController {
    
    //MARK:- *** getEmployerProfile
    
    
}

//MARK:- ForgotPasswordViewController

extension ForgotPasswordViewController{
    
    func callAPIForgotPassword() {
        
        let dict = ["email": txtEmailObj.text!]
        
        GenericApiCallForObject(router: Router.forgotPassword(dict)) { (resp:LoginModel) in
            if resp.success {
                print(resp.message)
                self.txtEmailObj.text = ""
                self.showAlertView(message: resp.message)
                self.navigationController?.popViewController()
            }else{


            }
        }
    }
    
    
}

//MARK:- LoginViewController
 
extension LoginViewController {
    
    func callAPILogin() {
        
        //        let dict = ["email":"test@employer.com",
        //                    "password":"123456",
        //                    "device_token":"123445555"]
        
        let dict = ["email":txtEmailObj.text!,
                    "password":txtPasswordObj.text!]
        
        GenericApiCallForObject(router: Router.login(dict)) { (resp:LoginModel) in
            
            if resp.success {
                
                LoginDataModel.currentUser = resp.data
                if resp.data.type == "0"{
                    let tabbar = self.storyboard?.instantiateViewController(identifier: "TabBarController")
                    self.navigationController?.pushViewController(tabbar!)
                }else{
                    let tabbar = self.storyboard?.instantiateViewController(identifier: "TabBarViewControllerEmployer")
                    self.navigationController?.pushViewController(tabbar!)
                }
            }
            else {
                self.showAlertView(message: resp.message.count > 0 ? resp.message : "Something went wrong. Please try again")
            }
        }
    }
    
}

//MARK:- RegisterViewController

extension RegisterViewController {
    
    func callAPIRegister() {
        
        var dict = [String:String]()
        
        dict = ["first_name":txtFirstNameObj.text!,
                "last_name": txtLastNameObj.text!,
                "email":txtEmailObj.text!,
                "password":txtPasswordObj.text!,
                "password_confirmation":txtConfirmPasswordObj.text!,
                "phone":txtMobileNumberObj.text!,
                "address":""
        ]
        
        GenericApiCallForObject(router: Router.register(dict)) { (resp:GeneralModel) in
            if resp.success {
                
                self.showAlertView(message: resp.data.message.count > 0 ? resp.data.message : resp.message)
                self.navigationController?.popViewController()
            }
            else {
                self.showAlertView(message: resp.message.count > 0 ? resp.message : "Something went wrong. Please try again")
            }
            
        }
    }
    
}

//MARK:- Seeker Dashboard ViewController

extension HomeViewController {
    
    func callSeekerDashboard() {
        
        GenericApiCallForObject(router: Router.seekerEmployerDashboard) { (resp:SeekerDashboardModel) in
            if resp.success {
                self.dashboardData = resp.data
                self.setupData()
            }
            else {
                self.showAlertView(message: resp.message.count > 0 ? resp.message : "Something went wrong. Please try again")
            }
            
        }
    }
    
}

//MARK:- Employer Dashboard ViewController

extension EmployerHomeViewController {
    
    func callEmployerDashboard() {
        
        GenericApiCallForObject(router: Router.seekerEmployerDashboard) { (resp:EmployerDashboardModel) in
            if resp.success {
                self.dashboardData = resp.data
                self.setDashboardData(respData: resp.data)
                self.setupData()
            }
            else {
                self.showAlertView(message: resp.message.count > 0 ? resp.message : "Something went wrong. Please try again")
            }
            
        }
    }
    
}

//MARK:- Employer Job List ViewController

extension EmployerJobListViewController {
    
    func callEmployerJobList() {
        
        GenericApiCallForObject(router: Router.EmployerJobList) { (resp:EmployerJobListModel) in
            
            if resp.data.count > 0{
                self.employerJobListArray = resp.data
                self.setupData()
            }else{
                self.tblJobListObj.isHidden = true
                self.lblNoJobsFound.isHidden = false
            }
          
        }
    }
    
}

//MARK:- Employer Draft Job List ViewController

extension EmployerDraftJobListViewController {
    
    func callEmployerJobDraftList() {
        
        let dict = ["per_page":"\(per_page_data)",
                    "page":"\(current_page)"]
        
        GenericApiCallForObject(router: Router.EmployerJobDraftList(dict)) { (resp:EmployerJobDraftListModel) in
            
            if resp.data.count > 0{
                self.employerJobDraftListModel = resp
                self.current_page = self.employerJobDraftListModel.meta.current_page
                self.last_page = self.employerJobDraftListModel.meta.last_page
                self.setupData()
            }else{
                if self.arrDraftJobList.count == 0{
                    self.tblJobListObj.isHidden = true
                    self.lblNoJobsFound.isHidden = false
                }
            }
        }
    }
    
}


//MARK:- Employer Expired Job List ViewController

extension EmployerExpiredJobListViewController {
    
    func callEmployerJobExpiredList() {
        
        let dict = ["per_page":"\(per_page_data)",
                    "page":"\(current_page)"]
        
        GenericApiCallForObject(router: Router.EmployerJobExpiredList(dict)) { (resp:EmployerJobDraftListModel) in
            
            if resp.data.count > 0{
                self.employerJobExpiredList = resp
                self.current_page = resp.meta.current_page
                self.last_page = resp.meta.last_page
                self.setupData()
            }else{
                if self.employerJobExpiredListArray.count == 0{
                    self.tblJobListObj.isHidden = true
                    self.lblNoJobsFound.isHidden = false
                }
            }
        }
    }
    
}


//MARK:- Employer Transaction List ViewController

extension EmployerTransactionViewController {
    
    func callEmployerTransactionList() {
        
        let dict = ["per_page":"\(per_page_data)",
                    "page":"\(current_page)"]
        
        GenericApiCallForObject(router: Router.EmployerTransactionList(dict)) { (resp:EmployerTransactionListModel) in
            
            if resp.data.count > 0{
                self.employerTransactionList = resp
                self.current_page = resp.meta.current_page
                self.last_page = resp.meta.last_page
                self.setupData()
            }else{
                if self.employerTransactionListArray.count == 0{
                    self.tblTransactionObj.isHidden = true
                    self.lblNoJobsFound.isHidden = false
                }
            }
        }
    }
    
}


//MARK:- Candidate List ViewController

extension EmployerCandidateListViewController {
    
    func callCandidateList() {
        
        let dict = ["per_page":"\(per_page_data)",
                    "page":"\(current_page)"]
        
        GenericApiCallForObject(router: Router.EmployerCandidateList(dict)) { (resp:CandidateListModel) in
            
            if resp.data.count > 0{
                self.CandidateList = resp
                self.current_page = resp.meta.current_page
                self.last_page = resp.meta.last_page
                self.setupData()
            }else{
                if self.CandidateListDataArray.count == 0{
                    self.tblCandidateListObj.isHidden = true
                    self.lblNoJobsFound.isHidden = false
                }
            }
        }
    }
    
}

//MARK:- Candidate List ViewController

extension ChangePasswordViewController{
    
    func callAPIChangePassword() {
        
        let dict = ["old_password": txtCurrentPassword.text!,
                    "password":txtNewPassword.text!,
                    "password_confirmation":txtConfirmPassword.text!]
        
        GenericApiCallForObject(router: Router.ChangePassword(dict)) { (resp:LoginModel) in
            if resp.success {
                resp.data.type = LoginDataModel.currentUser?.type ?? ""
                LoginDataModel.currentUser = resp.data
                self.delegateSendMessage?.passwordChanged(strMessage: resp.message)
                self.dismiss(animated: false, completion: nil)
            }else{
                self.showAlertView(message: resp.message)
            }
        }
    }
    
    
}


extension EmployerPostJobViewController{
    
    func callLocationListAPI() {
        
        GenericApiCallForObject(router: Router.locations) { (resp:LocationListModel) in
            
            if resp.success {
                self.locationListArray = resp.data
                if self.isUpdatePost{
                    let locationIDArray = self.employerJobDraftListDataModelObj.locations.split(separator: ",")
                    self.locationListArray.forEach { (categoryData) in
                        locationIDArray.forEach { (locationID) in
                            if locationID == categoryData.id{
                                let location = LocationListDataModel()
                                location.name = categoryData.name
                                location.id = categoryData.id
                                location.is_active = ""
                                location.isSelected = true
                                self.selectedLocationListArray.append(location)
                            }
                        }
                    }
                    self.txtLocation.text = self.selectedLocationListArray.map{ $0.name}.joined(separator: ", ")
                }
            }else{
                self.showAlertView(message: resp.message)
            }
        }
    }
    
    func callCategoryListAPI() {
        
        GenericApiCallForObject(router: Router.categoriesMain) { (resp:CategoryListModel) in
            
            if resp.success {
                self.categoryListArray = resp.data
                print(self.categoryListArray.count)
                if self.isUpdatePost{
                    self.categoryListArray.forEach { (category) in
                        if self.employerJobDraftListDataModelObj.categories == category.id{
                            let location = CategoryListDataModel()
                            location.name = category.name
                            location.id = category.id
                            location.is_active = ""
                            location.isSelected = true
                            self.selectedCategory = location
                        }
                    }
                    self.txtCategory.text = self.selectedCategory.name
                }
                
            }else{
                self.showAlertView(message: resp.message)
            }
        }
    }
    
    func callSkillListAPI() {
        
        GenericApiCallForObject(router: Router.skills) { (resp:CategoryListModel) in
            
            if resp.success {
                self.skillListArray = resp.data
                
                if self.isUpdatePost{
                    let SkillsNameArray = self.employerJobDraftListDataModelObj.skills.split(separator: ",")
                    self.skillListArray.forEach { (skillData) in
                        SkillsNameArray.forEach { (skill) in
                            if skill == skillData.name{
                                let skills = CategoryListDataModel()
                                skills.name = skillData.name
                                skills.id = skillData.id
                                skills.isSelected = true
                                self.selectedSkillListArray.append(skills)
                            }
                        }
                    }
                    self.txtSkills.text = self.selectedSkillListArray.map{ $0.name}.joined(separator: ", ")
                }
            }else{
                self.showAlertView(message: resp.message)
            }
        }
    }
    
    func callAPIJobCreate() {
        
        
        var dict = [String:String]()
        
        if employerJobDraftListDataModelObj.top_job_start_date.count == 0{
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "yyyy-MM-dd"
            let strDate = dateFormatterPrint.string(from: Date())
            employerJobDraftListDataModelObj.top_job_start_date = strDate
        }
        
        if isUpdatePost{
            dict = [
                "job_title": txtJobTitle.text ?? "",
                    "categories": selectedCategory.id,
                    "locations": selectedLocationListArray.map{ $0.id}.joined(separator: ", "),
                    "country": "New Zealand",
                    "experience_level": selectedDesiredLevel["id"] ?? "",
                    "job_duration": selectedDurationLevel["id"] ?? "",
                    "status": "1",
                    "skills": selectedSkillListArray.map{ $0.name}.joined(separator: ", "),
                    "top_job_start_date": employerJobDraftListDataModelObj.top_job_start_date,
                    "job_type": employerJobDraftListDataModelObj.job_type,
                    "salary_type": employerJobDraftListDataModelObj.salary_type,
                    "budget": employerJobDraftListDataModelObj.budget,
                    "per_week": employerJobDraftListDataModelObj.per_week,
                    "salary_min": employerJobDraftListDataModelObj.salary_min,
                    "salary_max": employerJobDraftListDataModelObj.salary_max,
                    "is_salary_disclosed": employerJobDraftListDataModelObj.is_salary_disclosed,
                    "job_description": employerJobDraftListDataModelObj.job_description,
                    "job_id": employerJobDraftListDataModelObj.id,
                    "is_top_jobs": employerJobDraftListDataModelObj.is_top_jobs,
                    "contact_name": employerJobDraftListDataModelObj.contact_name,
                    "position": employerJobDraftListDataModelObj.position,
                    "contact_number": employerJobDraftListDataModelObj.contact_number,
                    "contact_email": employerJobDraftListDataModelObj.contact_email,
                    "logo_attachment": employerJobDraftListDataModelObj.job_logo,
                    "job_duration_custom": employerJobDraftListDataModelObj.job_duration_custom,
                    "job_sort_description": employerJobDraftListDataModelObj.job_sort_description,
                    "external_link": employerJobDraftListDataModelObj.job_sort_description,
                    "job_type_option": employerJobDraftListDataModelObj.job_type_option,
                    "team_user_id": employerJobDraftListDataModelObj.user_id,
                    "is_team_member": employerJobDraftListDataModelObj.is_team_member,
                    "package_id": employerJobDraftListDataModelObj.package_id]
            
        }else{
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "yyyy-MM-dd"

            let strDate = dateFormatterPrint.string(from: Date())
            
            dict = ["job_title": txtJobTitle.text ?? "",
                    "categories": selectedCategory.id,
                    "locations": selectedLocationListArray.map{ $0.id}.joined(separator: ", "),
                    "country": "New Zealand",
                    "experience_level": selectedDesiredLevel["id"] ?? "",
                    "job_duration": selectedDurationLevel["id"] ?? "",
                    "status": "1",
                    "skills": selectedSkillListArray.map{ $0.name}.joined(separator: ", "),
                    "is_top_jobs": "1",
                    "top_job_start_date": strDate,
                    "job_duration_custom": ""]
        }
        
        print(employerJobDraftListDataModelObj)
        
        GenericApiCallForObject(router: isUpdatePost ? Router.jobUpdate(dict) : Router.jobCreate(dict)) { (resp:JobCreateModel) in
            if resp.success {
                self.isUpdatePost = true
                self.employerJobDraftListDataModelObj.job_title = self.txtJobTitle.text ?? ""
                self.employerJobDraftListDataModelObj.categories = self.selectedCategory.id
                self.employerJobDraftListDataModelObj.locations = self.selectedLocationListArray.map{ $0.id}.joined(separator: ",")
                self.employerJobDraftListDataModelObj.country = self.employerJobDraftListDataModelObj.country
                self.employerJobDraftListDataModelObj.experience_level = self.selectedDesiredLevel["id"] ?? ""
                self.employerJobDraftListDataModelObj.job_duration = self.selectedDurationLevel["id"] ?? ""
                self.employerJobDraftListDataModelObj.status = self.employerJobDraftListDataModelObj.status
                self.employerJobDraftListDataModelObj.skills = self.selectedSkillListArray.map{ $0.name}.joined(separator: ",")
                
                let PackgesVC = self.storyboard?.instantiateViewController(identifier: "EmployerPackgesViewController") as! EmployerPackgesViewController
                PackgesVC.employerJobDraftListDataModelObj = self.employerJobDraftListDataModelObj
                self.navigationController?.pushViewController(PackgesVC, animated: true)
            }else{
                self.showAlertView(message: resp.message)
            }
        }
    }
    
}

extension EmployerPackgesViewController{
    
    func callAPIpackageList() {
        
        GenericApiCallForObject(router: Router.packages) { (resp:PackagesListModel) in
            if resp.success {
                self.packgesListArray = resp.data
                if self.packgesListArray.count > 0{
                    self.tblJobListObj.tableFooterView = self.viewNext
                    self.tblJobListObj.reloadData()
                    self.lblNoJobsFound.isHidden = true
                }else{
                    self.lblNoJobsFound.isHidden = false
                }
                
            }else{
                self.showAlertView(message: resp.message)
            }
        }
    }
    
    func callAPIJobUpdate() {
        
           let dict = [
                    "job_title": employerJobDraftListDataModelObj.job_title,
                    "categories": employerJobDraftListDataModelObj.categories,
                    "locations": employerJobDraftListDataModelObj.locations,
                    "country": "New Zealand",
                    "experience_level": employerJobDraftListDataModelObj.experience_level,
                    "job_duration": employerJobDraftListDataModelObj.job_duration,
                    "status": "1",
                    "skills": employerJobDraftListDataModelObj.skills,
                    "top_job_start_date": employerJobDraftListDataModelObj.top_job_start_date,
                    "job_type": employerJobDraftListDataModelObj.job_type,
                    "salary_type": employerJobDraftListDataModelObj.salary_type,
                    "budget": employerJobDraftListDataModelObj.budget,
                    "per_week": employerJobDraftListDataModelObj.per_week,
                    "salary_min": employerJobDraftListDataModelObj.salary_min,
                    "salary_max": employerJobDraftListDataModelObj.salary_max,
                    "is_salary_disclosed": employerJobDraftListDataModelObj.is_salary_disclosed,
                    "job_description": employerJobDraftListDataModelObj.job_description,
                    "job_id": employerJobDraftListDataModelObj.id,
                    "is_top_jobs": employerJobDraftListDataModelObj.is_top_jobs,
                    "contact_name": employerJobDraftListDataModelObj.contact_name,
                    "position": employerJobDraftListDataModelObj.position,
                    "contact_number": employerJobDraftListDataModelObj.contact_number,
                    "contact_email": employerJobDraftListDataModelObj.contact_email,
                    "logo_attachment": employerJobDraftListDataModelObj.job_logo,
                    "job_duration_custom": employerJobDraftListDataModelObj.job_duration_custom,
                    "job_sort_description": employerJobDraftListDataModelObj.job_sort_description,
                    "external_link": employerJobDraftListDataModelObj.job_sort_description,
                    "job_type_option": employerJobDraftListDataModelObj.job_type_option,
                    "team_user_id": employerJobDraftListDataModelObj.user_id,
                    "is_team_member": employerJobDraftListDataModelObj.is_team_member,
                    "package_id": employerJobDraftListDataModelObj.package_id] as [String : Any]
            
        print("\(employerJobDraftListDataModelObj)")
        
        GenericApiCallForObject(router: Router.jobUpdate(dict)) { (resp:JobCreateModel) in
            if resp.success {
                let SalaryInfoVC = self.storyboard?.instantiateViewController(identifier: "SalaryInformationViewController") as! SalaryInformationViewController
                SalaryInfoVC.employerJobDraftListDataModelObj = self.employerJobDraftListDataModelObj
                self.navigationController?.pushViewController(SalaryInfoVC, animated: true)
                
            }else{
                self.showAlertView(message: resp.message)
            }
        }
    }
    
}

extension SalaryInformationViewController {
    
    func callAPIJobUpdate() {
        
           let dict = [
                    "job_title": employerJobDraftListDataModelObj.job_title,
                    "categories": employerJobDraftListDataModelObj.categories,
                    "locations": employerJobDraftListDataModelObj.locations,
                    "country": "New Zealand",
                    "experience_level": employerJobDraftListDataModelObj.experience_level,
                    "job_duration": employerJobDraftListDataModelObj.job_duration,
                    "status": "1",
                    "skills": employerJobDraftListDataModelObj.skills,
                    "top_job_start_date": employerJobDraftListDataModelObj.top_job_start_date,
                    "job_type": employerJobDraftListDataModelObj.job_type,
                    "salary_type": employerJobDraftListDataModelObj.salary_type,
                    "budget": employerJobDraftListDataModelObj.budget,
                    "per_week": employerJobDraftListDataModelObj.per_week,
                    "salary_min": employerJobDraftListDataModelObj.salary_min,
                    "salary_max": employerJobDraftListDataModelObj.salary_max,
                    "is_salary_disclosed": employerJobDraftListDataModelObj.is_salary_disclosed,
//                    "educations": employerJobDraftListDataModelObj.educations,
                    "job_description": employerJobDraftListDataModelObj.job_description,
                    "job_id": employerJobDraftListDataModelObj.id,
                    "is_top_jobs": employerJobDraftListDataModelObj.is_top_jobs,
                    "contact_name": employerJobDraftListDataModelObj.contact_name,
                    "position": employerJobDraftListDataModelObj.position,
                    "contact_number": employerJobDraftListDataModelObj.contact_number,
                    "contact_email": employerJobDraftListDataModelObj.contact_email,
                    "logo_attachment": employerJobDraftListDataModelObj.job_logo,
                    "job_duration_custom": employerJobDraftListDataModelObj.job_duration_custom,
                    "job_sort_description": employerJobDraftListDataModelObj.job_sort_description,
                    "external_link": employerJobDraftListDataModelObj.job_sort_description,
                    "job_type_option": employerJobDraftListDataModelObj.job_type_option,
                    "team_user_id": employerJobDraftListDataModelObj.user_id,
                    "is_team_member": employerJobDraftListDataModelObj.is_team_member,
                    "package_id": employerJobDraftListDataModelObj.package_id] as [String : Any]
            
        
        GenericApiCallForObject(router: Router.jobUpdate(dict)) { (resp:JobCreateModel) in
            if resp.success {
                let JobDescriptionVC = self.storyboard?.instantiateViewController(identifier: "JobDescriptionViewController") as! JobDescriptionViewController
                JobDescriptionVC.employerJobDraftListDataModelObj = self.employerJobDraftListDataModelObj
                self.navigationController?.pushViewController(JobDescriptionVC, animated: true)
            }else{
                self.showAlertView(message: resp.message)
            }
        }
    }
    
}


extension JobDescriptionViewController {
    
    func callAPIJobUpdate() {
        
           let dict = [
                    "job_title": employerJobDraftListDataModelObj.job_title,
                    "categories": employerJobDraftListDataModelObj.categories,
                    "locations": employerJobDraftListDataModelObj.locations,
                    "country": "New Zealand",
                    "experience_level": employerJobDraftListDataModelObj.experience_level,
                    "job_duration": employerJobDraftListDataModelObj.job_duration,
                    "status": "1",
                    "skills": employerJobDraftListDataModelObj.skills,
                    "top_job_start_date": employerJobDraftListDataModelObj.top_job_start_date,
                    "job_type": employerJobDraftListDataModelObj.job_type,
                    "salary_type": employerJobDraftListDataModelObj.salary_type,
                    "budget": employerJobDraftListDataModelObj.budget,
                    "per_week": employerJobDraftListDataModelObj.per_week,
                    "salary_min": employerJobDraftListDataModelObj.salary_min,
                    "salary_max": employerJobDraftListDataModelObj.salary_max,
                    "is_salary_disclosed": employerJobDraftListDataModelObj.is_salary_disclosed,
//                    "educations": employerJobDraftListDataModelObj.educations,
                    "job_description": employerJobDraftListDataModelObj.job_description,
                    "job_id": employerJobDraftListDataModelObj.id,
                    "is_top_jobs": employerJobDraftListDataModelObj.is_top_jobs,
                    "contact_name": employerJobDraftListDataModelObj.contact_name,
                    "position": employerJobDraftListDataModelObj.position,
                    "contact_number": employerJobDraftListDataModelObj.contact_number,
                    "contact_email": employerJobDraftListDataModelObj.contact_email,
                    "logo_attachment": employerJobDraftListDataModelObj.job_logo,
                    "job_duration_custom": employerJobDraftListDataModelObj.job_duration_custom,
                    "job_sort_description": employerJobDraftListDataModelObj.job_sort_description,
                    "external_link": employerJobDraftListDataModelObj.job_sort_description,
                    "job_type_option": employerJobDraftListDataModelObj.job_type_option,
                    "team_user_id": employerJobDraftListDataModelObj.user_id,
                    "is_team_member": employerJobDraftListDataModelObj.is_team_member,
                    "package_id": employerJobDraftListDataModelObj.package_id] as [String : Any]
            
        
        GenericApiCallForObject(router: Router.jobUpdate(dict)) { (resp:JobCreateModel) in
            if resp.success {
                let ContactVC = self.storyboard?.instantiateViewController(identifier: "ContactDetailsViewController") as! ContactDetailsViewController
                ContactVC.employerJobDraftListDataModelObj = self.employerJobDraftListDataModelObj
                self.navigationController?.pushViewController(ContactVC, animated: true)
            }else{
                self.showAlertView(message: resp.message)
            }
        }
    }
    
}

extension ContactDetailsViewController {
    
    func callAPIJobUpdate() {
        
           let dict = [
                    "job_title": employerJobDraftListDataModelObj.job_title,
                    "categories": employerJobDraftListDataModelObj.categories,
                    "locations": employerJobDraftListDataModelObj.locations,
                    "country": "New Zealand",
                    "experience_level": employerJobDraftListDataModelObj.experience_level,
                    "job_duration": employerJobDraftListDataModelObj.job_duration,
                    "status": "1",
                    "skills": employerJobDraftListDataModelObj.skills,
                    "top_job_start_date": employerJobDraftListDataModelObj.top_job_start_date,
                    "job_type": employerJobDraftListDataModelObj.job_type,
                    "salary_type": employerJobDraftListDataModelObj.salary_type,
                    "budget": employerJobDraftListDataModelObj.budget,
                    "per_week": employerJobDraftListDataModelObj.per_week,
                    "salary_min": employerJobDraftListDataModelObj.salary_min,
                    "salary_max": employerJobDraftListDataModelObj.salary_max,
                    "is_salary_disclosed": employerJobDraftListDataModelObj.is_salary_disclosed,
//                    "educations": employerJobDraftListDataModelObj.educations,
                    "job_description": employerJobDraftListDataModelObj.job_description,
                    "job_id": employerJobDraftListDataModelObj.id,
                    "is_top_jobs": employerJobDraftListDataModelObj.is_top_jobs,
                    "contact_name": employerJobDraftListDataModelObj.contact_name,
                    "position": employerJobDraftListDataModelObj.position,
                    "contact_number": employerJobDraftListDataModelObj.contact_number,
                    "contact_email": employerJobDraftListDataModelObj.contact_email,
                    "logo_attachment": employerJobDraftListDataModelObj.job_logo,
                    "job_duration_custom": employerJobDraftListDataModelObj.job_duration_custom,
                    "job_sort_description": employerJobDraftListDataModelObj.job_sort_description,
                    "external_link": employerJobDraftListDataModelObj.job_sort_description,
                    "job_type_option": employerJobDraftListDataModelObj.job_type_option,
                    "team_user_id": employerJobDraftListDataModelObj.user_id,
                    "is_team_member": employerJobDraftListDataModelObj.is_team_member,
                    "package_id": employerJobDraftListDataModelObj.package_id] as [String : Any]
            
        
        GenericApiCallForObject(router: Router.jobUpdate(dict)) { (resp:JobCreateModel) in
            if resp.success {
                let UploadLogoVC = self.storyboard?.instantiateViewController(identifier: "UploadLogoViewController") as! UploadLogoViewController
                UploadLogoVC.employerJobDraftListDataModelObj = self.employerJobDraftListDataModelObj
                self.navigationController?.pushViewController(UploadLogoVC, animated: true)
            }else{
                self.showAlertView(message: resp.message)
            }
        }
    }
    
}


extension UploadLogoViewController {
    
    func callAPIJobUpdate() {
        
        ShowHUD()
        
           let dict = [
                    "job_title": employerJobDraftListDataModelObj.job_title,
                    "categories": employerJobDraftListDataModelObj.categories,
                    "locations": employerJobDraftListDataModelObj.locations,
                    "country": "New Zealand",
                    "experience_level": employerJobDraftListDataModelObj.experience_level,
                    "job_duration": employerJobDraftListDataModelObj.job_duration,
                    "status": "1",
                    "skills": employerJobDraftListDataModelObj.skills,
                    "top_job_start_date": employerJobDraftListDataModelObj.top_job_start_date,
                    "job_type": employerJobDraftListDataModelObj.job_type,
                    "salary_type": employerJobDraftListDataModelObj.salary_type,
                    "budget": employerJobDraftListDataModelObj.budget,
                    "per_week": employerJobDraftListDataModelObj.per_week,
                    "salary_min": employerJobDraftListDataModelObj.salary_min,
                    "salary_max": employerJobDraftListDataModelObj.salary_max,
                    "is_salary_disclosed": employerJobDraftListDataModelObj.is_salary_disclosed,
//                    "educations": employerJobDraftListDataModelObj.educations,
                    "job_description": employerJobDraftListDataModelObj.job_description,
                    "job_id": employerJobDraftListDataModelObj.id,
                    "is_top_jobs": employerJobDraftListDataModelObj.is_top_jobs,
                    "contact_name": employerJobDraftListDataModelObj.contact_name,
                    "position": employerJobDraftListDataModelObj.position,
                    "contact_number": employerJobDraftListDataModelObj.contact_number,
                    "contact_email": employerJobDraftListDataModelObj.contact_email,
//                    "logo_attachment": employerJobDraftListDataModelObj.job_logo,
                    "job_duration_custom": employerJobDraftListDataModelObj.job_duration_custom,
                    "job_sort_description": employerJobDraftListDataModelObj.job_sort_description,
                    "external_link": employerJobDraftListDataModelObj.job_sort_description,
                    "job_type_option": employerJobDraftListDataModelObj.job_type_option,
                    "team_user_id": employerJobDraftListDataModelObj.user_id,
                    "is_team_member": employerJobDraftListDataModelObj.is_team_member,
                    "package_id": employerJobDraftListDataModelObj.package_id] as [String : String]
            
        /*
        GenericApiCallForObject(router: Router.jobUpdate(dict)) { (resp:JobCreateModel) in
            if resp.success {
                let UploadLogoVC = self.storyboard?.instantiateViewController(identifier: "UploadLogoViewController") as! UploadLogoViewController
                UploadLogoVC.employerJobDraftListDataModelObj = self.employerJobDraftListDataModelObj
                self.navigationController?.pushViewController(UploadLogoVC, animated: true)
            }else{
                self.showAlertView(message: resp.message)
            }
        }
        */
        
        
        let headersData = ["Authorization": "Bearer \(LoginDataModel.currentUser?.access_token ?? "")", "Content-type": "multipart/form-data", "Accept":"application/json"]
        /*
        Alamofire.upload(multipartFormData: { (form) in
            if self.imgLogo.image != nil{
                let imgData = self.imgLogo.image!.pngData()
                form.append(imgData!, withName: "logo_attachment", fileName: "file.png", mimeType: "image/png")
            }
            for (key, value) in dict {
                form.append(value.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!, withName: key)
            }
        }, to: "\(Router.baseURLString)job/update", headers: headersData, encodingCompletion: { result in
             switch result {
             case .success(let upload, _, _):
               upload.responseString { response in
                 print(response.value)
               }
                upload.responseJSON { response in
                    self.HideHUD()
                    print(response.result.value)
                }
             case .failure(let encodingError):
               print(encodingError)
             }
           })*/
        
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            if self.imgLogo.image != nil{
                let imgData = self.imgLogo.image!.pngData()
                multipartFormData.append(imgData!, withName: "logo_attachment",fileName: "file.png", mimeType: "image/png")
            }
            for (key, value) in dict {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        },
        to:"\(Router.baseURLString)employer/job/update",headers:headersData)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    self.HideHUD()
                    let jsonDict : NSDictionary = response.result.value as! NSDictionary

                    if let success = jsonDict["success"] as? Bool
                    {
                        if success{
                            self.showAlertView(message: "Success")
                        }
                    }
                }
                
            case .failure(let encodingError):
                self.HideHUD()
                print(encodingError)
            }
        }
    }
    
}

extension EmployerProfileViewController {
    
    func callGetProfileAPI() {
        
        GenericApiCallForObject(router: Router.employerProfile) { (resp:ProfileModel) in
            
            if resp.success {
                self.profileDataModelObj = resp.data
                self.setupData()
            }else{
                self.showAlertView(message: resp.message)
            }
        }
    }
    
    func callGetStateListAPI() {
        
        GenericApiCallForObject(router: Router.stateList) { (resp:StateListModel) in
            if resp.success {
                self.stateListDataModelObj = resp.data
                self.setupData()
            }else{
                self.showAlertView(message: resp.message)
            }
        }
    }
    
    func callUpdateProfileAPI() {
        
        ShowHUD()
        
        let dict = [
            "first_name": txtFirstName.text ?? "",
            "last_name": txtLastName.text ?? "",
            "about_company": txtAboutCompany.text ?? "",
            "address": txtAddress1.text ?? "",
            "phone": txtPhone.text ?? "",
            "address2": txtAddress2.text ?? "",
            "city": "\(selectedCityId)",
            "state": selectedStateListDataModelObj.id,
            "country": txtCountry.text ?? "",
            "zip": txtZipcode.text ?? "",
            "twitter_profile": "",
            "github_profile": "",
            "company_name": txtCompanyName.text ?? ""
        ] as [String : String]
   
        
        let headersData = ["Authorization": "Bearer \(LoginDataModel.currentUser?.access_token ?? "")", "Content-type": "multipart/form-data", "Accept":"application/json"]
        
        Alamofire.upload(multipartFormData: { multipartFormData in
            
            if self.isSelectedImage{
                let imgData = self.imgProfile.image!.jpegData(compressionQuality: 0.5)
                multipartFormData.append(imgData!, withName: "profile_image",fileName: "file.jpg", mimeType: "image/jpg")
            }
            
            for (key, value) in dict {
                multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        },
        to:"\(Router.baseURLString)employer/user/profile/change",headers:headersData)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                
                upload.uploadProgress(closure: { (progress) in
                    print("Upload Progress: \(progress.fractionCompleted)")
                })
                
                upload.responseJSON { response in
                    self.HideHUD()
                    let jsonDict : NSDictionary = response.result.value as! NSDictionary
                    print(jsonDict)
                    if let success = jsonDict["success"] as? Bool
                    {
                        NotificationCenter.default.post(name: Notification.Name("refreshDashboardData"), object: nil, userInfo: nil)
                        if success{
                            self.showAlertView(message: "Profile Updated Successfully")
                        }
                    }else{
                        if let message = jsonDict["message"] as? String{
                            self.showAlertView(message: message)
                        }
                    }
                }
                
            case .failure(let encodingError):
                self.HideHUD()
                print(encodingError)
            }
        }
    }
    
}

extension ManageTeamViewController{
    
    func callTeamListAPI() {
        
        let dict = ["per_page":"\(per_page_data)",
                    "page":"\(current_page)"]
        
        GenericApiCallForObject(router: Router.teamList(dict)) { (resp:TeamListModel) in
            if resp.data.count > 0{
                self.teamListArray = resp.data
                self.tblObj.reloadData()
            }
        }
    }
    
    func callDeleteTeamAPI(selectedIndex: Int) {
        
        let dict = ["user_id":teamListArray[selectedIndex].id]
        GenericApiCallForObject(router: Router.deleteTeam(dict)) { (resp:JobCreateModel) in
            if resp.data.count > 0{
                self.showAlertView(message: resp.message)
                self.teamListArray.remove(at: selectedIndex)
                self.tblObj.reloadData()
            }
        }
    }
    
}

extension AddTeamMemberViewController{
    
    func callCreateTeamAPI() {
        
        let dict = ["first_name":txtFirstName.text ?? "",
                    "last_name":txtLastName.text ?? "",
                    "email":txtEmail.text ?? "",
                    "role":txtRole.text ?? "",
                    "type":selectedType,
                    "user_id": isEdit ? teamData.id : ""]
        
        GenericApiCallForObject(router: isEdit ? Router.updateTeam(dict) : Router.createTeam(dict)) { (resp:JobCreateModel) in
            if resp.success {
                self.delegateRefreshMemberList?.refreshMemberList()
                self.navigationController?.popViewController(animated: true, nil)
            }
        }
    }
    
}

extension ContactUsViewController{
    
    func callContactUsAPI() {
        
        let dict = ["name":txtName.text ?? "",
                    "email":txtEmail.text ?? "",
                    "phone":txtPhone.text ?? "",
                    "message":txtMessage.text ?? "",
                    "subject":txtSubject.text ?? ""
                    ]
        
        GenericApiCallForObject(router: Router.contactUS(dict)) { (resp:JobCreateModel) in
            if resp.success {
                self.navigationController?.popViewController(animated: true, nil)
            }
        }
    }
    
}

extension SeekerAppliedViewController{
    
    func callAppliedJobListAPI() {
     
        let dict = ["per_page":"\(per_page_data)",
                    "page":"\(current_page)"]
        
        GenericApiCallForObject(router: Router.AppliedJobList(dict)) { (resp:AppliedJobModel) in
            if resp.data.count > 0{
                self.appliedJobsData = resp.data
                self.tblObj.reloadData()
            }
        }
    }
    
}

extension BrowseJobListViewController{
    
    func callSearchJobListAPI() {
     
        let dict = ["per_page":"\(per_page_data)",
                    "page":"\(current_page)"]
        
        GenericApiCallForObject(router: Router.SearchJobList(dict)) { (resp:SearchJobListModel) in
            if resp.data.count > 0{
                self.searchJobsData = resp.data
                self.lblBrowseJobList.text = "Browse Jobs (\(resp.data.count))"
                self.tblObj.reloadData()
            }
        }
    }
    
    func callLocationListAPI() {
        
        GenericApiCallForObject(router: Router.locations) { (resp:LocationListModel) in
            
            if resp.success {
                self.locationListArray = resp.data
            }else{
                self.showAlertView(message: resp.message)
            }
        }
    }
    
    func callCategoryListAPI() {
        
        GenericApiCallForObject(router: Router.categoriesMain) { (resp:CategoryListModel) in
            
            if resp.success {
                self.categoryListArray = resp.data
            }else{
                self.showAlertView(message: resp.message)
            }
        }
    }
    
    
}


extension BrowseJobDetailsViewController{
    
    func callJobDetailsAPI(slugName:String) {
     
        let dict = ["slug":"\(slugName)"]
        
        GenericApiCallForObject(router: Router.JobDetails(dict)) { (resp:JobDetailsDataModel) in
            if resp.success {
                self.jobDetailsDataObj = resp.data
                self.setupData()
//                print(self.jobDetailsDataObj)
            }else{
                self.showAlertView(message: resp.message)
            }
        }
    }
}

//
//  EmployerPostJobViewController.swift
//  RecruitApp
//
//  Created by MAC on 25/02/21.
//

import UIKit

class EmployerPostJobViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var txtJobTitle: UITextField!
    @IBOutlet weak var txtLocation: UITextField!
    @IBOutlet weak var txtCategory: UITextField!
    @IBOutlet weak var txtSkills: UITextField!
    @IBOutlet weak var txtDesiredExperience: UITextField!
    @IBOutlet weak var txtYearsExperience: UITextField!
    

    // MARK: - Variables
    var paddingRight:CGFloat = 25
    var locationListArray = [LocationListDataModel]()
    var categoryListArray = [CategoryListDataModel]()
    var skillListArray = [CategoryListDataModel]()
    
    var selectedCategory = CategoryListDataModel()
    var selectedDesiredLevel = [String:String]()
    var selectedDurationLevel = [String:String]()
    var selectedLocationListArray = [LocationListDataModel]()
    var selectedSkillListArray = [CategoryListDataModel]()
    var employerJobDraftListDataModelObj = EmployerJobUpdateDataModel()
    var isUpdatePost = false
    var selectedDesiredLevelIndex = 0
    var selectedDurationLevelIndex = 0
    
    var experienceData = [["id":"1","name":"Entry Level"],["id":"2","name":"Intermediate"],["id":"3","name":"Expert"]]
    
    var experienceDurationData = [["id":"1","name":"Not sure"],["id":"2","name":"Less than 1 year"],["id":"3","name":"1 year - 2 years"],["id":"4","name":"2 years - 3 years"],["id":"5","name":"3 years - 4 years"],["id":"6","name":"5 Years+"]]

    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupData()
        callLocationListAPI()
        callCategoryListAPI()
        callSkillListAPI()
        
        if isUpdatePost{
            setupUpdateData()
        }
        
//        DispatchQueue.main.async {
//            let PackgesVC = self.storyboard?.instantiateViewController(identifier: "EmployerPackgesViewController") as! EmployerPackgesViewController
//            self.navigationController?.pushViewController(PackgesVC, animated: true)
//        }
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Private Functions
    func setupData() {
        txtLocation.setRightPaddingPoints(paddingRight)
        txtCategory.setRightPaddingPoints(paddingRight)
        txtSkills.setRightPaddingPoints(paddingRight)
        txtDesiredExperience.setRightPaddingPoints(paddingRight)
        txtYearsExperience.setRightPaddingPoints(paddingRight)
    }
    
    func setupUpdateData() {
        
        selectedLocationListArray.removeAll()
        
//        employerJobDraftListDataModelObj.locations.forEach { (locationData) in
//            let location = LocationListDataModel()
//            location.name = locationData.name
//            location.id = locationData.id
//            location.is_active = ""
//            location.isSelected = true
//            selectedLocationListArray.append(location)
//        }
        
//        employerJobDraftListDataModelObj.categories.forEach { (categoryData) in
//            let category = CategoryListDataModel()
//            category.name = categoryData.name
//            category.id = categoryData.id
//            category.isSelected = true
//            selectedCategory = category
//        }
        
//        employerJobDraftListDataModelObj.skills.forEach { (skillsData) in
//            let skills = CategoryListDataModel()
//            skills.name = skillsData
//            skills.isSelected = true
//            selectedSkillListArray.append(skills)
//        }
        
        txtJobTitle.text = employerJobDraftListDataModelObj.job_title
//        txtSkills.text = employerJobDraftListDataModelObj.skills.joined(separator: ",")
//        txtLocation.text = employerJobDraftListDataModelObj.locations.map{ $0.name}.joined(separator: ", ")
//        txtCategory.text = employerJobDraftListDataModelObj.categories.map{ $0.name}.joined(separator: ", ")
        
        let data = experienceData.filter { $0["id"] == employerJobDraftListDataModelObj.experience_level }
        if data.count > 0{
            txtDesiredExperience.text = data[0]["name"]
            selectedDesiredLevel = data[0]
            selectedDesiredLevelIndex = data[0]["id"]?.int ?? 0
        }
        
        let dataJobDuration = experienceDurationData.filter { $0["id"] == employerJobDraftListDataModelObj.job_duration }
        if dataJobDuration.count > 0{
            txtYearsExperience.text = dataJobDuration[0]["name"]
            selectedDurationLevel = dataJobDuration[0]
            selectedDurationLevelIndex = dataJobDuration[0]["id"]?.int ?? 0
        }
        

    }
    
    func isValid() -> Bool {
        var valid = true
        
        if txtJobTitle.text?.count == 0{
            valid = false
            showAlertView(message: ValidationMessage.EnterJobTitle)
        }else if txtLocation.text?.count == 0{
            valid = false
            showAlertView(message: ValidationMessage.SelectLocation)
        }else if txtCategory.text?.count == 0{
            valid = false
            showAlertView(message: ValidationMessage.SelectCatrgory)
        }else if txtSkills.text?.count == 0{
            valid = false
            showAlertView(message: ValidationMessage.SelectSkill)
        }else if txtDesiredExperience.text?.count == 0{
            valid = false
            showAlertView(message: ValidationMessage.SelectDesiredLevel)
        }else if txtYearsExperience.text?.count == 0{
            valid = false
            showAlertView(message: ValidationMessage.SelectYearsExperienceLevel)
        }
        
        return valid
    }
    
    // MARK: - Button Actions

    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController()
    }
    
    @IBAction func btnNextClicked(_ sender: Any) {
        if isValid(){
            callAPIJobCreate()
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


extension EmployerPostJobViewController : UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        switch textField {
        case txtLocation:
            let selectLocationVC = self.storyboard?.instantiateViewController(identifier: "SelectLocationViewController") as! SelectLocationViewController
            selectLocationVC.modalPresentationStyle = .overCurrentContext
            selectLocationVC.locationList = locationListArray
            selectLocationVC.delegateLocationData = self
            self.navigationController?.present(selectLocationVC, animated: true, completion: nil)
        case txtCategory:
            let selectCategoryVC = self.storyboard?.instantiateViewController(identifier: "JobCategoryViewController") as! JobCategoryViewController
            selectCategoryVC.modalPresentationStyle = .overCurrentContext
            selectCategoryVC.categoryList = categoryListArray
            selectCategoryVC.selectedCategory = selectedCategory
            selectCategoryVC.delegateCategoryData = self
            self.navigationController?.present(selectCategoryVC, animated: true, completion: nil)
        case txtSkills:
            let selectSkillsVC = self.storyboard?.instantiateViewController(identifier: "JobSkillsViewController") as! JobSkillsViewController
            selectSkillsVC.modalPresentationStyle = .overCurrentContext
            selectSkillsVC.skillsList = skillListArray
            selectSkillsVC.delegateSkillData = self
            self.navigationController?.present(selectSkillsVC, animated: true, completion: nil)
        case txtDesiredExperience:
            let selectDesiredLevelVC = self.storyboard?.instantiateViewController(identifier: "DesiredExperienceLevelViewController") as! DesiredExperienceLevelViewController
            selectDesiredLevelVC.modalPresentationStyle = .overCurrentContext
            selectDesiredLevelVC.delegateDesiredLevel = self
            selectDesiredLevelVC.selectedIndex = selectedDesiredLevelIndex > 0 ? selectedDesiredLevelIndex - 1 : 0
            self.navigationController?.present(selectDesiredLevelVC, animated: true, completion: nil)
        case txtYearsExperience:
            let selectYearExperienceVC = self.storyboard?.instantiateViewController(identifier: "YearsExperienceViewController") as! YearsExperienceViewController
            selectYearExperienceVC.modalPresentationStyle = .overCurrentContext
            selectYearExperienceVC.delegateYearsExperience = self
            selectYearExperienceVC.selectedIndex = selectedDurationLevelIndex > 0 ? selectedDurationLevelIndex - 1 : 0
            self.navigationController?.present(selectYearExperienceVC, animated: true, completion: nil)
        case txtJobTitle:
            return true
        default:
            print("")
        }
        return false
    }
    
}

extension EmployerPostJobViewController : passLocationDataDelegate{
    func locationDataPass(locations: [LocationListDataModel]) {
        selectedLocationListArray = locations
        DispatchQueue.main.async {
            self.txtLocation.text = locations.map{ $0.name}.joined(separator: ", ")
        }
    }
}

extension EmployerPostJobViewController : passDesiredExperienceDataDelegate{
    func DesiredExperienceDataPass(levelData: [String : String]) {
        selectedDesiredLevel = levelData
        txtDesiredExperience.text = levelData["name"]
    }
}

extension EmployerPostJobViewController : passYearsExperienceDataDelegate{
    func YearsExperienceDataPass(experienceData: [String : String]) {
        selectedDurationLevel = experienceData
        txtYearsExperience.text = experienceData["name"]
    }
}

extension EmployerPostJobViewController : passCategoryDataDelegate {
    func categoryDataPass(categories: CategoryListDataModel) {
        selectedCategory = categories
        txtCategory.text = categories.name
    }
}

extension EmployerPostJobViewController : passSkillsDataDelegate {
    func skillsDataPass(skills: [CategoryListDataModel]) {
        selectedSkillListArray = skills
        self.txtSkills.text = skills.map{ $0.name}.joined(separator: ", ")
    }
}


//
//  EmployerProfileViewController.swift
//  RecruitApp
//
//  Created by MAC on 24/04/21.
//

import UIKit

class EmployerProfileViewController: UIViewController {

    // MARK: - IBOutlet Actions
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtCompanyName: UITextField!
    @IBOutlet weak var txtAddress1: UITextField!
    @IBOutlet weak var txtAddress2: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtZipcode: UITextField!
    @IBOutlet weak var txtAboutCompany: UITextView!
    @IBOutlet weak var imgProfile: UIImageView!
    
    
    var profileDataModelObj = ProfileDataModel()
    var stateListDataModelObj = [StateListDataModel]()
    var selectedStateListDataModelObj = StateListDataModel()
    var selectedCityId = 0
    var imagePicker = UIImagePickerController()
    var isSelectedImage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        callGetProfileAPI()
        callGetStateListAPI()

        if txtAboutCompany.text.isEmpty {
            txtAboutCompany.text = "About company (optional)"
            txtAboutCompany.textColor = UIColor.lightGray.withAlphaComponent(0.8)
        }

        // Do any additional setup after loading the view.
    }
    
    func setupData() {
    
        txtFirstName.text = profileDataModelObj.first_name
        txtLastName.text = profileDataModelObj.last_name
        txtEmail.text = profileDataModelObj.email
        txtCompanyName.text = profileDataModelObj.company_name
        txtAboutCompany.text = profileDataModelObj.info
        txtAddress1.text = profileDataModelObj.address
        txtAddress2.text = profileDataModelObj.address2
        
        if self.profileDataModelObj.state != "0"{
            self.stateListDataModelObj.forEach { (stateList) in
                if self.profileDataModelObj.state == stateList.id{
                    self.txtState.text = stateList.name
                    stateList.city_list.forEach { (cityList) in
                        if self.profileDataModelObj.city == cityList.id{
                            self.txtCity.text = cityList.name
                        }
                    }
                }
            }
        }
        
        if profileDataModelObj.profile_image.count > 0{
            imgProfile.sd_setImage(with: URL(string: profileDataModelObj.profile_image), completed: nil)
        }
        
        txtZipcode.text = profileDataModelObj.zip
        
        if txtAboutCompany.text.isEmpty {
            txtAboutCompany.text = "About company (optional)"
            txtAboutCompany.textColor = UIColor.lightGray.withAlphaComponent(0.8)
        }
    }
    
    
    @IBAction func btnSaveChangesClicked(_ sender: Any) {
        var isValid = true
        
        if txtFirstName.text!.isEmpty || txtLastName.text!.isEmpty || txtEmail.text!.isEmpty{
            isValid = false
            showAlertView(message: "Please enter required details.")
        }
        
        if isValid{
            callUpdateProfileAPI()
        }
    }
    
    // MARK: - Button Actions

    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController()
    }
    
    @IBAction func btnImagePickerClicked(_ sender: Any) {
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
           alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
               self.openCamera()
           }))

           alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
               self.openGallary()
           }))

           alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

           imagePicker.delegate = self
           self.present(alert, animated: true, completion: nil)
       }
    
       func openCamera()
       {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
       }
    
       func openGallary()
       {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
           imagePicker.allowsEditing = true
           self.present(imagePicker, animated: true, completion: nil)
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


extension EmployerProfileViewController : UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if txtAboutCompany.text.isEmpty {
            txtAboutCompany.text = "About company (optional)"
            txtAboutCompany.textColor = UIColor.lightGray
            
//            txtLinkedin.text = profileDataModelObj.
        }
        
    }
    
}


extension EmployerProfileViewController : UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtState{
            let selectLocationVC = self.storyboard?.instantiateViewController(identifier: "SelectStateCityViewController") as! SelectStateCityViewController
            selectLocationVC.modalPresentationStyle = .overCurrentContext
            selectLocationVC.stateListDataModelObj = stateListDataModelObj
            selectLocationVC.delegateStateData = self
            selectLocationVC.isStateMode = true
            self.navigationController?.present(selectLocationVC, animated: true, completion: nil)
            return false
        }else if textField == txtCity{
            if selectedStateListDataModelObj.id.count > 0{
                let selectLocationVC = self.storyboard?.instantiateViewController(identifier: "SelectStateCityViewController") as! SelectStateCityViewController
                selectLocationVC.modalPresentationStyle = .overCurrentContext
                selectLocationVC.stateListDataModelObj = selectedStateListDataModelObj.city_list
                selectLocationVC.delegateCityData = self
                self.navigationController?.present(selectLocationVC, animated: true, completion: nil)
            }
            return false
        }
        return true
    }
    
}

extension EmployerProfileViewController : passStateDataDelegate, passCityDataDelegate{
    func cityDataPass(city: StateListDataModel) {
        DispatchQueue.main.async {
            self.txtCity.text = city.name
            self.selectedCityId = city.id.int ?? 0
        }
    }
    
    func stateDataPass(state: StateListDataModel) {
        DispatchQueue.main.async {
            self.txtState.text = state.name
            self.selectedStateListDataModelObj = state
        }
    }
}

extension EmployerProfileViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        isSelectedImage = true
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        {
            self.imgProfile.image = image
        }else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.imgProfile.image = image
        }
        imagePicker.dismiss(animated:true, completion: nil)
    }
    
}

//
//  RegisterViewController.swift
//  RecruitApp
//
//  Created by MAC on 02/02/21.
//

import UIKit

class RegisterViewController: UIViewController {

    // MARK: Outlet
    @IBOutlet weak var viewFirstNameObj: UIView!
    @IBOutlet weak var txtFirstNameObj: UITextField!
    
    @IBOutlet weak var viewLastNameObj: UIView!
    @IBOutlet weak var txtLastNameObj: UITextField!
    
    @IBOutlet weak var viewEmailObj: UIView!
    @IBOutlet weak var txtEmailObj: UITextField!
    
    @IBOutlet weak var viewMobileNumberObj: UIView!
    @IBOutlet weak var txtMobileNumberObj: UITextField!
    
    @IBOutlet weak var viewPasswordObj: UIView!
    @IBOutlet weak var txtPasswordObj: UITextField!
        
    @IBOutlet weak var viewConfirmPasswordObj: UIView!
    @IBOutlet weak var txtConfirmPasswordObj: UITextField!
    
    @IBOutlet weak var btnJobSeeker: UIButton!
    @IBOutlet weak var btnEmployer: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    
    @IBOutlet weak var imgAppLogo: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        zoomInOutAppLogo()
        // Do any additional setup after loading the view.
    }
    
    // MARK: SetupView
    func setupView() {
        
        btnJobSeeker.backgroundColor = Theme.colors.buttonBg
        btnJobSeeker.setTitleColor(.white, for: .normal)
        userType = .seeker
        
        setBorderColor(view: viewFirstNameObj)
        setBorderColor(view: viewLastNameObj)
        setBorderColor(view: viewEmailObj)
        setBorderColor(view: viewMobileNumberObj)
        setBorderColor(view: viewConfirmPasswordObj)
        setBorderColor(view: viewPasswordObj)
        
        btnJobSeeker.layer.cornerRadius = 5
        btnEmployer.layer.cornerRadius = 5
        btnRegister.layer.cornerRadius = 5
    }
    
    func setBorderColor(view:UIView) {
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.cornerRadius = 5
    }
    
    func zoomInOutAppLogo() {
        imgAppLogo.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
    
        UIView.animate(withDuration: 1.0) {
            self.imgAppLogo.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }
    }
    
    func isValid() -> Bool {
        
        var isValid = true
        
        if txtFirstNameObj.text?.count == 0{
            isValid = false
            showAlertView(message: ValidationMessage.EnterFirstName)
        }else if txtLastNameObj.text?.count == 0{
            isValid = false
            showAlertView(message: ValidationMessage.EnterLastName)
        }else if txtEmailObj.text?.count == 0{
            isValid = false
            showAlertView(message: ValidationMessage.EnterEmail)
        }else if !txtEmailObj.text!.isValidEmail{
            isValid = false
            showAlertView(message: ValidationMessage.EnterValidEmail)
        }else if txtMobileNumberObj.text?.count == 0{
            isValid = false
            showAlertView(message: ValidationMessage.EnterMobileNumber)
        }else if txtPasswordObj.text?.count == 0{
            isValid = false
            showAlertView(message: ValidationMessage.EnterPassword)
        }else if txtConfirmPasswordObj.text?.count == 0{
            isValid = false
            showAlertView(message: ValidationMessage.EnterConfirmPassword)
        }else if txtPasswordObj.text != txtConfirmPasswordObj.text{
            isValid = false
            showAlertView(message: ValidationMessage.EnterPasswordDoNotMatch)
        }
        
        return isValid
    }
    
    
    // MARK: IBAction
    @IBAction func btnLoginClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true, nil)
    }

    @IBAction func btnRegisterClicked(_ sender: Any) {
        if isValid(){
            callAPIRegister()
        }
    }
    
    @IBAction func btnJobSeekerEmployerClicked(_ sender: UIButton) {
        
        if sender.tag == 0{
            btnJobSeeker.backgroundColor = Theme.colors.buttonBg
            btnEmployer.backgroundColor = Theme.colors.buttonBgSelection
            btnJobSeeker.setTitleColor(.white, for: .normal)
            btnEmployer.setTitleColor(.black, for: .normal)
            userType = .seeker
        }else{
            btnJobSeeker.backgroundColor = Theme.colors.buttonBgSelection
            btnEmployer.backgroundColor = Theme.colors.buttonBg
            btnJobSeeker.setTitleColor(.black, for: .normal)
            btnEmployer.setTitleColor(.white, for: .normal)
            userType = .employer
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

//
//  LoginViewController.swift
//  RecruitApp
//
//  Created by MAC on 31/01/21.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: Outlet
    @IBOutlet weak var viewEmailObj: UIView!
    @IBOutlet weak var txtEmailObj: UITextField!
        
    @IBOutlet weak var viewPasswordObj: UIView!
    @IBOutlet weak var txtPasswordObj: UITextField!
    
    @IBOutlet weak var btnJobSeeker: UIButton!
    @IBOutlet weak var btnEmployer: UIButton!
    @IBOutlet weak var btnLogin: UIButton!

    @IBOutlet weak var imgAppLogo: UIImageView!
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isUserLoggedIn(){
            if LoginDataModel.currentUser?.type == "0"{
                userType = .seeker
                let tabbar = self.storyboard?.instantiateViewController(identifier: "TabBarController")
                self.navigationController?.pushViewController(tabbar!, animated: false)
            }else{
                userType = .employer
                let tabbar = self.storyboard?.instantiateViewController(identifier: "TabBarViewControllerEmployer")
                self.navigationController?.pushViewController(tabbar!, animated: false)
            }
        }else{
            userType = .seeker
            zoomInOutAppLogo()
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.txtEmailObj.text = ""
        self.txtPasswordObj.text = ""
        if !isUserLoggedIn(){
            userType = .seeker
        }
        setupView()
    }
    
    // MARK: SetupView
    func setupView() {
        
        setBorderColor(view: viewEmailObj)
        setBorderColor(view: viewPasswordObj)
        
        btnJobSeeker.backgroundColor = Theme.colors.buttonBg
        btnEmployer.backgroundColor = Theme.colors.buttonBgSelection
        btnJobSeeker.setTitleColor(.white, for: .normal)
        btnEmployer.setTitleColor(.black, for: .normal)
        
        btnJobSeeker.layer.cornerRadius = 5
        btnEmployer.layer.cornerRadius = 5
        btnLogin.layer.cornerRadius = 5
        
                #if targetEnvironment(simulator)
                if userType == .seeker {
                    txtEmailObj.text = "testbinarycode@gmail.com"
                    txtPasswordObj.text = "12345678"
                }
                else {
                    txtEmailObj.text = "jalpeshcpatel@gmail.com"
                    txtPasswordObj.text = "12345678"
                }
                #else
                #endif
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
        
        if txtEmailObj.text?.count == 0{
            isValid = false
            showAlertView(message: ValidationMessage.EnterEmail)
        }else if !txtEmailObj.text!.isValidEmail{
            isValid = false
            showAlertView(message: ValidationMessage.EnterValidEmail)
        }else if txtPasswordObj.text?.count == 0{
            isValid = false
            showAlertView(message: ValidationMessage.EnterPassword)
        }
        
        return isValid
    }
    
    // MARK: IBAction
    @IBAction func btnLoginClicked(_ sender: Any) {
        
        if isValid(){
            LoginDataModel.currentUser = LoginDataModel()
            callAPILogin()
        }
    }
    
    @IBAction func btnFotgotPasswordClicked(_ sender: Any) {
        let aVC = self.storyboard?.instantiateViewController(withClass: ForgotPasswordViewController.self)
        self.navigationController?.pushViewController(aVC!, animated: true)
    }
    
    @IBAction func btnSignUpClicked(_ sender: Any) {
        let aVC = self.storyboard?.instantiateViewController(withClass: RegisterViewController.self)
        self.navigationController?.pushViewController(aVC!, animated: true)
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
        
        #if targetEnvironment(simulator)
        if userType == .seeker {
            txtEmailObj.text = "testbinarycode@gmail.com"
            txtPasswordObj.text = "12345678"
        }
        else {
            txtEmailObj.text = "jalpeshcpatel@gmail.com"
            txtPasswordObj.text = "12345678"
        }
        #else
        #endif
        
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

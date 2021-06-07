//
//  ForgotPasswordViewController.swift
//  RecruitApp
//
//  Created by MAC on 02/02/21.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    // MARK: Outlet
    @IBOutlet weak var viewEmailObj: UIView!
    @IBOutlet weak var txtEmailObj: UITextField!
    
    @IBOutlet weak var btnSendClicked: UIButton!
    
    @IBOutlet weak var imgAppLogo: UIImageView!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        zoomInOutAppLogo()
        // Do any additional setup after loading the view.
    }
    
    // MARK: SetupView
    func setupView() {
        viewEmailObj.layer.borderWidth = 2
        viewEmailObj.layer.borderColor = UIColor.gray.cgColor
        viewEmailObj.layer.cornerRadius = 5
        btnSendClicked.layer.cornerRadius = 5
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
        }
        return isValid
    }
    
    // MARK: IBAction
    @IBAction func btnBackLoginClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: IBAction
    @IBAction func btnSendClicked(_ sender: Any) {
        
        if isValid(){
            print("Password Send Success")
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

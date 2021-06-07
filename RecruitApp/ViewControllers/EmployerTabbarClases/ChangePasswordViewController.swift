//
//  ChangePasswordViewController.swift
//  RecruitApp
//
//  Created by MAC on 19/02/21.
//

import UIKit

protocol passMessage {
    func passwordChanged(strMessage:String)
}

class ChangePasswordViewController: UIViewController {

    
    @IBOutlet weak var txtCurrentPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!

    var delegateSendMessage: passMessage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnUpdatePasswordClicked(_ sender: Any) {
            
        if isValid(){
            callAPIChangePassword()
        }
    }
    
    @IBAction func btnCloseClicked(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    func isValid() -> Bool{
        
        var isValid = true
        
        if txtCurrentPassword.trimmedText?.count == 0{
            isValid = false
            showAlertView(message: ValidationMessage.EnterCurrentPassword)
        }else if txtNewPassword.trimmedText?.count == 0{
            isValid = false
            showAlertView(message: ValidationMessage.EnterNewPassword)
        }else if txtConfirmPassword.trimmedText?.count == 0{
            isValid = false
            showAlertView(message: ValidationMessage.EnterConfirmPassword)
        }else if txtNewPassword.text != txtConfirmPassword.text{
            isValid = false
            showAlertView(message: ValidationMessage.EnterPasswordDoNotMatch)
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

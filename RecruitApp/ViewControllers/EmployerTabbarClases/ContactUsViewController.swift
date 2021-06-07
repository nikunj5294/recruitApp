//
//  ContactUsViewController.swift
//  RecruitApp
//
//  Created by MAC on 28/04/21.
//

import UIKit

class ContactUsViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSubject: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtMessage: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtMessage.text = "Message"
        txtMessage.textColor = UIColor.lightGray
        
        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Button Actions

    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController()
    }
    
    @IBAction func btnSubmitClicked(_ sender: Any) {
        
        if isValidation(){
            callContactUsAPI()
        }
        
    }
    
    func isValidation() -> Bool{
        
        var isValid = true
        
        if txtName.text!.isEmpty || txtEmail.text!.isEmpty || txtSubject.text!.isEmpty || txtSubject.text!.isEmpty || txtSubject.text!.isEmpty {
            showAlertView(message: "All fields are required.")
            isValid = false
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


extension ContactUsViewController : UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = ""
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if txtMessage.text.isEmpty {
            txtMessage.text = "Message"
            txtMessage.textColor = UIColor.lightGray
        }
    }
    
}



//
//  LogoutViewController.swift
//  RecruitApp
//
//  Created by MAC on 10/02/21.
//

import UIKit

class LogoutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showAlert(title: strAppName, message: "Are you sure you want to logout?", buttonTitles: ["No","Yes"], highlightedButtonIndex: 0) { (intNumber) in
            if intNumber == 1{
                self.navigationController?.viewControllers.forEach({ (viewController) in
                    if viewController is LoginViewController{
                        LoginDataModel.currentUser = LoginDataModel()
                        self.navigationController?.popToViewController(viewController, animated: true)
                    }
                })
            }
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

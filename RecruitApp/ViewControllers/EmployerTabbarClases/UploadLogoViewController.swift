//
//  UploadLogoViewController.swift
//  RecruitApp
//
//  Created by MAC on 19/04/21.
//

import UIKit

class UploadLogoViewController: UIViewController {

    @IBOutlet weak var txtUploadFile: UITextField!
    
    var employerJobDraftListDataModelObj = EmployerJobUpdateDataModel()
    var imagePicker = UIImagePickerController()
    var imgLogo = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Button Actions

    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController()
    }
    
    @IBAction func btnNextClicked(_ sender: Any) {
        callAPIJobUpdate()
    }
    
    @IBAction func btnChooseFileClicked(_ sender: Any) {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
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

extension UploadLogoViewController :  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            txtUploadFile.text = "\(url.lastPathComponent)"
        }
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imgLogo.image = image
        }else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imgLogo.image = image
        }
           
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    
}

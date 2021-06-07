//
//  JobDescriptionViewController.swift
//  RecruitApp
//
//  Created by MAC on 18/04/21.
//

import UIKit

class JobDescriptionViewController: UIViewController {

    @IBOutlet weak var txtJobDescription: UITextView!
    @IBOutlet weak var txtJobShortDescription: UITextView!
    
    var employerJobDraftListDataModelObj = EmployerJobUpdateDataModel()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        if employerJobDraftListDataModelObj.job_description.count > 0{
            txtJobDescription.text = employerJobDraftListDataModelObj.job_description
            txtJobDescription.attributedText = employerJobDraftListDataModelObj.job_description.htmlToAttributedString
        }else{
            txtJobDescription.text = "Job Description *"
            txtJobDescription.textColor = UIColor.lightGray
        }
        
        if employerJobDraftListDataModelObj.job_sort_description.count > 0{
            txtJobShortDescription.text = employerJobDraftListDataModelObj.job_sort_description
        }else{
            txtJobShortDescription.text = "Job Short Description *"
            txtJobShortDescription.textColor = UIColor.lightGray
        }
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Button Actions

    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController()
    }
    
    @IBAction func btnNextClicked(_ sender: Any) {
        
        var isValid = true
        
        if txtJobDescription.text.trimmed.count == 0{
            isValid = false
        }else if txtJobShortDescription.text.trimmed.count == 0{
            isValid = false
        }
        
        if isValid{
            callAPIJobUpdate()
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

extension JobDescriptionViewController : UITextViewDelegate{
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if txtJobDescription.text.isEmpty {
            txtJobDescription.text = "Job Description *"
            txtJobDescription.textColor = UIColor.lightGray
        }else{
            employerJobDraftListDataModelObj.job_description = txtJobDescription.text
        }
        
        if txtJobShortDescription.text.isEmpty {
            txtJobShortDescription.text = "Job Short Description *"
            txtJobShortDescription.textColor = UIColor.lightGray
        }else{
            employerJobDraftListDataModelObj.job_sort_description = txtJobShortDescription.text
        }
    }
    
}



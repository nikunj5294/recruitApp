//
//  BrowseJobDetailsViewController.swift
//  RecruitApp
//
//  Created by MAC on 03/05/21.
//

import UIKit
import SDWebImage

class BrowseJobDetailsViewController: UIViewController {

    var jobDetailsDataObj = SearchJobListDataModel()
    var slugname = ""

    // MARK: - IBOutlet
    @IBOutlet weak var jobTitleObj: UILabel!
    @IBOutlet weak var jobOpenHours: UILabel!
    
    
    @IBOutlet weak var lblAnnualTitle: UILabel!
    @IBOutlet weak var lblAnnualValue: UILabel!
    @IBOutlet weak var lblJobType: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblExperience: UILabel!
    
    @IBOutlet weak var lblDescription: UILabel!
    
    @IBOutlet weak var lblApplicationContact: UILabel!

    @IBOutlet weak var lblEmaiVerified: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblUserLocation: UILabel!
    @IBOutlet weak var lblEmailObj: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    
    @IBOutlet weak var imgVerified: UIImageView!
    
    @IBOutlet weak var imgUserProfile: UIImageView!
    
    @IBOutlet weak var lblJobLink: UILabel!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        callJobDetailsAPI(slugName: slugname)
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: - SetupView Data
    func setupData() {
        
        jobTitleObj.text = jobDetailsDataObj.job_title
        jobOpenHours.text = jobDetailsDataObj.remaining_time
        lblAnnualValue.text = "$\(jobDetailsDataObj.budget) NZD"
        lblAnnualTitle.text = jobDetailsDataObj.salary_type_name
        lblJobType.text = jobDetailsDataObj.job_type_option_name
        if jobDetailsDataObj.locations.count > 0{
            lblLocation.text = jobDetailsDataObj.locations[0].name
        }
        
        lblExperience.text = jobDetailsDataObj.experience_level_name
        
        if let labelTextFormatted = jobDetailsDataObj.job_description.htmlToAttributString {
                        let textAttributes = [
                            NSAttributedString.Key.foregroundColor: lblDescription.textColor!,
                            NSAttributedString.Key.font: lblDescription.font!
                        ] as [NSAttributedString.Key: Any]
                        labelTextFormatted.addAttributes(textAttributes, range: NSRange(location: 0, length: labelTextFormatted.length))
                        self.lblDescription.attributedText = labelTextFormatted
                    }
        
//        lblDescription.text = jobDetailsDataObj.job_description
        lblApplicationContact.text = "Contact Name: \(jobDetailsDataObj.contact_name)\nContact Email: \(jobDetailsDataObj.contact_email)\nContact Number: \(jobDetailsDataObj.contact_number)"
        
        let attributedString = NSMutableAttributedString(string: "Contact Name: \(jobDetailsDataObj.contact_name)\nContact Email: \(jobDetailsDataObj.contact_email)\nContact Number: \(jobDetailsDataObj.contact_number)")

        // *** Create instance of `NSMutableParagraphStyle`
        let paragraphStyle = NSMutableParagraphStyle()

        // *** set LineSpacing property in points ***
        paragraphStyle.lineSpacing = 5 // Whatever line spacing you want in points

        // *** Apply attribute to string ***
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

        // *** Set Attributed String to your label ***
        lblApplicationContact.attributedText = attributedString
        
        if jobDetailsDataObj.employer_verified{
            lblEmaiVerified.text = "Email Address Verified"
            imgVerified.tintColor = UIColor.green
        }else{
            imgVerified.tintColor = UIColor.lightGray
        }
        
        lblName.text = jobDetailsDataObj.employer_name
        lblUserLocation.text = jobDetailsDataObj.employer_location
        lblEmailObj.text = jobDetailsDataObj.employer_email
        lblPhoneNumber.text = jobDetailsDataObj.employer_phone
        
        if jobDetailsDataObj.employer_profile_image.count > 0{
            imgUserProfile.sd_setImage(with: URL(string: jobDetailsDataObj.employer_profile_image), completed: nil)
        }
        
        lblJobLink.text = "https://www.recruit.nz/jobapply/\(jobDetailsDataObj.id)/\(jobDetailsDataObj.slug)"
        
    }

    
    // MARK: - IBAction
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnClickedApply(_ sender: Any) {
        
    }
    
    @IBAction func btnClickedViewProfile(_ sender: Any) {
        
    }
    
    @IBAction func btnShareClicked(_ sender: UIButton) {
        
        let textToShare = jobDetailsDataObj.job_title

            if let myWebsite = NSURL(string: "https://www.recruit.nz/jobapply/\(jobDetailsDataObj.id)/\(jobDetailsDataObj.slug)") {
                let objectsToShare: [Any] = [textToShare, myWebsite]
                let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
                activityVC.popoverPresentationController?.sourceView = sender
                self.present(activityVC, animated: true, completion: nil)
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


extension String {

 var htmlToAttributString: NSMutableAttributedString? {
    guard let data = data(using: .utf8) else { return nil }
    do {
        return try NSMutableAttributedString(data: data,
                                      options: [.documentType: NSMutableAttributedString.DocumentType.html,
                                                .characterEncoding: String.Encoding.utf8.rawValue],
                                      documentAttributes: nil)
    } catch let error as NSError {
        print(error.localizedDescription)
        return  nil
    }
 }

}

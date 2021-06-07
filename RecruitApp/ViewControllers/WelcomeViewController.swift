//
//  WelcomeViewController.swift
//  RecruitApp
//
//  Created by MAC on 31/01/21.
//

import UIKit
import SwifterSwift

class welcomeCell: UICollectionViewCell {
 
    // MARK: Outlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!

    @IBOutlet weak var imgWelcome: UIImageView!
    @IBOutlet weak var lblDesc: UILabel!
}

class WelcomeViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnSkip: UIButton!

    @IBOutlet weak var pageControlObj: UIPageControl!
    
    @IBOutlet weak var collectionViewObj: UICollectionView!
    
    var titleArray = ["Sign Up With Us",
                      "Fill In Your Company Details",
                      "Post Your Job"]
    var subTitleArray = ["Why Use Our Recruiter App?",
                         "Popular Job Profiles That You Can Hire Candidates",
                         "Finding the right candidate was never so easy!"]
    
    var descArray = ["Hire fast and hire the best staff with Recruit! So if you are an employer looking to hire we got your back!.",
                     "Hassle-Free Hiring In New Zealand For Any Blue And Grey Collar Profiles. Specially Made For Employers And Recruiters Who Want To Hire Best Staff Easily..",
                     "Recruit app is made keeping in mind the troubles faced by Employers and Recruiters. to find relevant candidates and faster is very tough for employers."]
    
    var imageArray = ["welcome_2","welcome_2","welcome_3"]
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        if isUserLoggedIn(){
            let aVC = self.storyboard?.instantiateViewController(withClass: LoginViewController.self)
            self.navigationController?.pushViewController(aVC!, animated: false)
        }
        
        pageControlObj.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration:1.0) {
            self.collectionViewObj.alpha = 1.0
        }
    }
    
    @IBAction func btnNextAction(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "LETS GO"{
            btnSkipAction(btnSkip!)
        }else{
            collectionViewObj.scrollToItem(at: IndexPath(item: pageControlObj.currentPage+1, section: 0), at: .right, animated: true)
            pageControlObj.currentPage = pageControlObj.currentPage + 1
            if pageControlObj.currentPage == titleArray.count-1{
                btnNext.setTitle("LETS GO", for: .normal)
                btnSkip.isHidden = true
            }else{
                btnNext.setTitle("NEXT", for: .normal)
                btnSkip.isHidden = false
            }
        }
    }
    
    @IBAction func btnSkipAction(_ sender: Any) {
           let aVC = self.storyboard?.instantiateViewController(withClass: LoginViewController.self)
           self.navigationController?.pushViewController(aVC!, animated: true)
    }

}

extension WelcomeViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "welcomeCell", for: indexPath) as! welcomeCell
        cell.lblTitle.text = titleArray[indexPath.row]
        cell.lblSubTitle.text = subTitleArray[indexPath.row]
        
        cell.lblDesc.text = descArray[indexPath.row]
        
        cell.imgWelcome.image = UIImage(named: imageArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: collectionView.frame.size.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        pageControlObj.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        print(pageControlObj.currentPage)
        
        if pageControlObj.currentPage == titleArray.count-1{
            btnNext.setTitle("LETS GO", for: .normal)
            btnSkip.isHidden = true
        }else{
            btnNext.setTitle("NEXT", for: .normal)
            btnSkip.isHidden = false
        }
    }
    
}

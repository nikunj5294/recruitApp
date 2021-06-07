//
//  HomeViewController.swift
//  RecruitApp
//
//  Created by MAC on 10/02/21.
//

import UIKit
import SDWebImage

class HomeViewController: UIViewController {

    // MARK: Outlet
    @IBOutlet weak var collectionViewObj: UICollectionView!
    @IBOutlet weak var lblSeekerName: UILabel!
    @IBOutlet weak var imgUserObj: UIImageView!
    
    var dashboardData = SeekerDashboardDataModel()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewObj.register(nib: UINib(nibName: "CategoryDashboardCell", bundle: nil), forCellWithClass: CategoryDashboardCell.self)
        
        callSeekerDashboard()
        
        // Do any additional setup after loading the view.
    }
    
    // MARK: Setup Data
    func setupData() {
        lblSeekerName.text = dashboardData.name
//        imgUserObj.sd_setImage(with: URL(string: dashboardData.profile_image), completed: nil)
        lblSeekerName.text = dashboardData.name
        collectionViewObj.reloadData()
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

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewObj.dequeueReusableCell(withReuseIdentifier: "CategoryDashboardCell", for: indexPath) as! CategoryDashboardCell
        
        
        if indexPath.item == 0{
            cell.lblJobTitle.text = "Applied Jobs"
            cell.lblJobCount.text = dashboardData.applied
            cell.viewBg.backgroundColor = UIColor(hexString: "#e2e7fb")
            cell.lblJobTitle.textColor = UIColor(hexString: "#6c63ff")
            cell.imgCategory.image = UIImage(named: "ic_posted_job")
        }else{
            cell.lblJobTitle.text = "Shortlisted Jobs"
            cell.lblJobCount.text = dashboardData.shortlist
            cell.viewBg.backgroundColor = UIColor(hexString: "#ffefcb")
            cell.lblJobTitle.textColor = UIColor(hexString: "#f4b162")
            cell.imgCategory.image = UIImage(named: "ic_offered")
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionViewObj.frame.size.width / 2)-30
        return CGSize(width: width, height: width-30)
    }
    
}

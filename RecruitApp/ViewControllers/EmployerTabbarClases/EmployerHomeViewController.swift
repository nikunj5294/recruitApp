//
//  EmployerHomeViewController.swift
//  RecruitApp
//
//  Created by MAC on 12/02/21.
//

import UIKit

class EmployerHomeViewController: UIViewController {

    // MARK: Outlet
    @IBOutlet weak var collectionViewObj: UICollectionView!
    @IBOutlet weak var lblSeekerName: UILabel!
    @IBOutlet weak var imgUserObj: UIImageView!
    
    var dashboardData = EmployerDashboardDataModel()
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewObj.register(nib: UINib(nibName: "CategoryDashboardCell", bundle: nil), forCellWithClass: CategoryDashboardCell.self)
        
        refreshAPIData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshAPIData), name: Notification.Name("refreshDashboardData"), object: nil)

        // Do any additional setup after loading the view.
    }
    
    @objc func refreshAPIData()  {
        callEmployerDashboard()
    }
    
    // MARK: Setup Data
    func setupData() {
        lblSeekerName.text = dashboardData.name
//        imgUserObj.sd_setImage(with: URL(string: dashboardData.profile_image), completed: nil)
        lblSeekerName.text = dashboardData.name
        collectionViewObj.reloadData()
    }

    @IBAction func btnClickedPlus(_ sender: Any) {
        
        let postVC = self.storyboard?.instantiateViewController(identifier: "EmployerPostJobViewController") as! EmployerPostJobViewController
        self.navigationController?.pushViewController(postVC, animated: true)
        
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


extension EmployerHomeViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionViewObj.dequeueReusableCell(withReuseIdentifier: "CategoryDashboardCell", for: indexPath) as! CategoryDashboardCell
        
        
        switch indexPath.item {
        case 0:
            cell.lblJobTitle.text = "Posted Jobs"
            cell.lblJobCount.text = dashboardData.posted_job
            cell.imgCategory.image = UIImage(named: "ic_posted_job")
            cell.viewBg.backgroundColor = UIColor(hexString: "#e2e7fb")
            cell.lblJobTitle.textColor = UIColor(hexString: "#6c63ff")
        case 1:
            cell.lblJobTitle.text = "Application Jobs"
            cell.lblJobCount.text = dashboardData.application
            cell.imgCategory.image = UIImage(named: "ic_application")
            cell.viewBg.backgroundColor = UIColor(hexString: "#ffe4e9")
            cell.lblJobTitle.textColor = UIColor(hexString: "#ff97b0")
        case 2:
            cell.lblJobTitle.text = "Offered Jobs"
            cell.lblJobCount.text = dashboardData.offered
            cell.imgCategory.image = UIImage(named: "ic_offered")
            cell.viewBg.backgroundColor = UIColor(hexString: "#ffefcb")
            cell.lblJobTitle.textColor = UIColor(hexString: "#f4b162")
        case 3:
            cell.lblJobTitle.text = "shortlisted Jobs"
            cell.lblJobCount.text = dashboardData.shortlist
            cell.imgCategory.image = UIImage(named: "ic_shortlist")
            cell.viewBg.backgroundColor = UIColor(hexString: "#f1e3fc")
            cell.lblJobTitle.textColor = UIColor(hexString: "#c288ff")
        default:
            print("")
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionViewObj.frame.size.width / 2)-30
        return CGSize(width: width, height: width-30)
    }
    
}

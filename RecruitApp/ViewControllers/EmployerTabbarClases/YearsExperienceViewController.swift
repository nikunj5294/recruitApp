//
//  YearsExperienceViewController.swift
//  RecruitApp
//
//  Created by MAC on 28/02/21.
//

import UIKit

protocol passYearsExperienceDataDelegate {
    func YearsExperienceDataPass(experienceData:[String:String])
}

class YearsExperienceViewController: UIViewController {

    @IBOutlet weak var tblYearsExperienceObj: UITableView!
    var delegateYearsExperience: passYearsExperienceDataDelegate?
    var experienceData = [["id":"1","name":"Not sure"],["id":"2","name":"Less than 1 year"],["id":"3","name":"1 year - 2 years"],["id":"4","name":"2 years - 3 years"],["id":"5","name":"3 years - 4 years"],["id":"6","name":"5 Years+"]]
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        tblYearsExperienceObj.register(nib: UINib(nibName: "CellLocation", bundle: nil), withCellClass: CellLocation.self)
        tblYearsExperienceObj.reloadData()
        tblYearsExperienceObj.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCloseClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnDoneClicked(_ sender: Any) {
        delegateYearsExperience?.YearsExperienceDataPass(experienceData: experienceData[selectedIndex])
        self.dismiss(animated: true, completion: nil)
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


extension YearsExperienceViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return experienceData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblYearsExperienceObj.dequeueReusableCell(withIdentifier: "CellLocation", for: indexPath) as! CellLocation
        let data = experienceData[indexPath.row]
        cell.lblLocationTitle.text = data["name"]
        cell.locationTickImage.image = UIImage(named: selectedIndex == indexPath.row ? "ic_radio_selected" : "ic_radio_unselected")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tblYearsExperienceObj.reloadData()
    }
    
}

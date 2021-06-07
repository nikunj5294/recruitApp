//
//  DesiredExperienceLevelViewController.swift
//  RecruitApp
//
//  Created by MAC on 28/02/21.
//

import UIKit

protocol passDesiredExperienceDataDelegate {
    func DesiredExperienceDataPass(levelData:[String:String])
}

class DesiredExperienceLevelViewController: UIViewController {

    @IBOutlet weak var tblDesiredLevelObj: UITableView!

    var delegateDesiredLevel: passDesiredExperienceDataDelegate?
    var experienceData = [["id":"1","name":"Entry Level"],["id":"2","name":"Intermediate"],["id":"3","name":"Expert"]]
    var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        tblDesiredLevelObj.register(nib: UINib(nibName: "CellLocation", bundle: nil), withCellClass: CellLocation.self)
        tblDesiredLevelObj.reloadData()
        tblDesiredLevelObj.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnCloseClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnDoneClicked(_ sender: Any) {
        delegateDesiredLevel?.DesiredExperienceDataPass(levelData: experienceData[selectedIndex])
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

extension DesiredExperienceLevelViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return experienceData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblDesiredLevelObj.dequeueReusableCell(withIdentifier: "CellLocation", for: indexPath) as! CellLocation
        let data = experienceData[indexPath.row]
        cell.lblLocationTitle.text = data["name"]
        cell.locationTickImage.image = UIImage(named: selectedIndex == indexPath.row ? "ic_radio_selected" : "ic_radio_unselected")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        tblDesiredLevelObj.reloadData()
    }
    
}

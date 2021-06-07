//
//  JobSkillsViewController.swift
//  RecruitApp
//
//  Created by MAC on 28/02/21.
//

import UIKit


protocol passSkillsDataDelegate {
    func skillsDataPass(skills:[CategoryListDataModel])
}

class JobSkillsViewController: UIViewController {

    @IBOutlet weak var tblSkillsObj: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    
    
    var skillsList = [CategoryListDataModel]()
    var tempStoreSkillsList = [CategoryListDataModel]()
    var delegateSkillData: passSkillsDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tempStoreSkillsList = skillsList
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        tblSkillsObj.register(nib: UINib(nibName: "CellLocation", bundle: nil), withCellClass: CellLocation.self)
        tblSkillsObj.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCloseClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnDoneClicked(_ sender: Any) {
        
        skillsList.forEach { (skillModel) in
            for i in 0...tempStoreSkillsList.count-1{
                if tempStoreSkillsList[i].id == skillModel.id{
                    tempStoreSkillsList[i] = skillModel
                }
            }
        }
        skillsList = tempStoreSkillsList
        
        delegateSkillData?.skillsDataPass(skills: skillsList.filter{ $0.isSelected == true })
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


extension JobSkillsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return skillsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblSkillsObj.dequeueReusableCell(withIdentifier: "CellLocation", for: indexPath) as! CellLocation
        let locationData = skillsList[indexPath.row]
        cell.lblLocationTitle.text = locationData.name
        cell.locationTickImage.image = UIImage(named: locationData.isSelected ? "ic_tick_box" : "ic_untick_box" )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        skillsList[indexPath.row].isSelected = skillsList[indexPath.row].isSelected ? false : true
        tblSkillsObj.reloadData()
    }
    
}

extension JobSkillsViewController : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text: NSString = (textField.text ?? "") as NSString
        let resultString = text.replacingCharacters(in: range, with: string)
        
        let filterData = tempStoreSkillsList.filter({ modelData in
            return modelData.name.caseInsensitiveHasPrefix(resultString)
        })
        
        skillsList = filterData
        tblSkillsObj.reloadData()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {

        skillsList.forEach { (locationModel) in
            for i in 0...tempStoreSkillsList.count-1{
                if tempStoreSkillsList[i].id == locationModel.id{
                    tempStoreSkillsList[i] = locationModel
                }
            }
        }
        
        skillsList = tempStoreSkillsList
        tblSkillsObj.reloadData()
        return true
    }
    
}

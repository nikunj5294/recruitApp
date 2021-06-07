//
//  SelectStateCityViewController.swift
//  RecruitApp
//
//  Created by MAC on 25/04/21.
//

import UIKit

protocol passStateDataDelegate {
    func stateDataPass(state:StateListDataModel)
}

protocol passCityDataDelegate {
    func cityDataPass(city:StateListDataModel)
}

class SelectStateCityViewController: UIViewController {

    @IBOutlet weak var tblStateCityObj: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var lblNavigationTitle: UILabel!

    var stateListDataModelObj = [StateListDataModel]()
    var tempstateListDataModelObj = [StateListDataModel]()
    var selectedstateListDataModelObj = StateListDataModel()

    var delegateStateData: passStateDataDelegate?
    var delegateCityData: passCityDataDelegate?
    
    var isStateMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblNavigationTitle.text = isStateMode ? "Select State" : "Select City"
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        tempstateListDataModelObj = stateListDataModelObj
        tblStateCityObj.register(nib: UINib(nibName: "CellLocation", bundle: nil), withCellClass: CellLocation.self)
        tblStateCityObj.tableFooterView = UIView()
        tblStateCityObj.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCloseClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func btnDoneClicked(_ sender: Any) {
        
        if isStateMode{
            delegateStateData?.stateDataPass(state: selectedstateListDataModelObj)
        }else{
            delegateCityData?.cityDataPass(city: selectedstateListDataModelObj)
        }
        
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


extension SelectStateCityViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stateListDataModelObj.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblStateCityObj.dequeueReusableCell(withIdentifier: "CellLocation", for: indexPath) as! CellLocation
        let locationData = stateListDataModelObj[indexPath.row]
        cell.lblLocationTitle.text = locationData.name
        cell.locationTickImage.image = UIImage(named: selectedstateListDataModelObj.id == locationData.id ? "ic_radio_selected" : "ic_radio_unselected" )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedstateListDataModelObj = stateListDataModelObj[indexPath.row]
        tblStateCityObj.reloadData()
    }
    
}

extension SelectStateCityViewController : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text: NSString = (textField.text ?? "") as NSString
        let resultString = text.replacingCharacters(in: range, with: string)
        
        let filterData = tempstateListDataModelObj.filter({ modelData in
            return modelData.name.caseInsensitiveHasPrefix(resultString)
        })
        
        stateListDataModelObj = filterData
        tblStateCityObj.reloadData()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {

        stateListDataModelObj.forEach { (locationModel) in
            for i in 0...tempstateListDataModelObj.count-1{
                if tempstateListDataModelObj[i].id == locationModel.id{
                    tempstateListDataModelObj[i] = locationModel
                }
            }
        }
        
        stateListDataModelObj = tempstateListDataModelObj
        tblStateCityObj.reloadData()
        return true
    }
    
}

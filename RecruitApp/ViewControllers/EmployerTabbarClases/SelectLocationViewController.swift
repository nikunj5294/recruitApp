//
//  SelectLocationViewController.swift
//  RecruitApp
//
//  Created by MAC on 27/02/21.
//

import UIKit

protocol passLocationDataDelegate {
    func locationDataPass(locations:[LocationListDataModel])
}

class SelectLocationViewController: UIViewController {

    @IBOutlet weak var tblLocationObj: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    
    
    var locationList = [LocationListDataModel]()
    var tempStoreLocationList = [LocationListDataModel]()
    var delegateLocationData: passLocationDataDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        tempStoreLocationList = locationList
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        tblLocationObj.register(nib: UINib(nibName: "CellLocation", bundle: nil), withCellClass: CellLocation.self)
        tblLocationObj.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCloseClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnDoneClicked(_ sender: Any) {
        
        locationList.forEach { (locationModel) in
            for i in 0...tempStoreLocationList.count-1{
                if tempStoreLocationList[i].id == locationModel.id{
                    tempStoreLocationList[i] = locationModel
                }
            }
        }
        locationList = tempStoreLocationList
        
        delegateLocationData?.locationDataPass(locations: locationList.filter{ $0.isSelected == true })
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

extension SelectLocationViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblLocationObj.dequeueReusableCell(withIdentifier: "CellLocation", for: indexPath) as! CellLocation
        let locationData = locationList[indexPath.row]
        cell.lblLocationTitle.text = locationData.name
        cell.locationTickImage.image = UIImage(named: locationData.isSelected ? "ic_tick_box" : "ic_untick_box" )
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        locationList[indexPath.row].isSelected = locationList[indexPath.row].isSelected ? false : true
        tblLocationObj.reloadData()
    }
    
}

extension SelectLocationViewController : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text: NSString = (textField.text ?? "") as NSString
        let resultString = text.replacingCharacters(in: range, with: string)
        
        let filterData = tempStoreLocationList.filter({ modelData in
            return modelData.name.caseInsensitiveHasPrefix(resultString)
        })
        
        locationList = filterData
        tblLocationObj.reloadData()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {

        locationList.forEach { (locationModel) in
            for i in 0...tempStoreLocationList.count-1{
                if tempStoreLocationList[i].id == locationModel.id{
                    tempStoreLocationList[i] = locationModel
                }
            }
        }
        
        locationList = tempStoreLocationList
        tblLocationObj.reloadData()
        return true
    }
    
}

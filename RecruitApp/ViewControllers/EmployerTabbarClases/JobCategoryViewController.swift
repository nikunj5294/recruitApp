//
//  JobCategoryViewController.swift
//  RecruitApp
//
//  Created by MAC on 28/02/21.
//

import UIKit

protocol passCategoryDataDelegate {
    func categoryDataPass(categories:CategoryListDataModel)
}

class JobCategoryViewController: UIViewController {

    @IBOutlet weak var tblCategoryObj: UITableView!
    @IBOutlet weak var txtSearch: UITextField!
    
    var categoryList = [CategoryListDataModel]()
    var tempStorecategoryList = [CategoryListDataModel]()
    var selectedCategory = CategoryListDataModel()
    var delegateCategoryData: passCategoryDataDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tempStorecategoryList = categoryList
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        tblCategoryObj.register(nib: UINib(nibName: "CellLocation", bundle: nil), withCellClass: CellLocation.self)
        tblCategoryObj.reloadData()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCloseClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnDoneClicked(_ sender: Any) {
        delegateCategoryData?.categoryDataPass(categories: selectedCategory)
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


extension JobCategoryViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblCategoryObj.dequeueReusableCell(withIdentifier: "CellLocation", for: indexPath) as! CellLocation
        let locationData = categoryList[indexPath.row]
        cell.lblLocationTitle.text = locationData.name
        cell.locationTickImage.image = UIImage(named: categoryList[indexPath.row].name == selectedCategory.name ? "ic_radio_selected" : "ic_radio_unselected")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCategory = categoryList[indexPath.row]
        tblCategoryObj.reloadData()
    }
    
}

extension JobCategoryViewController : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text: NSString = (textField.text ?? "") as NSString
        let resultString = text.replacingCharacters(in: range, with: string)
        let filterData = tempStorecategoryList.filter({ modelData in
            return modelData.name.caseInsensitiveHasPrefix(resultString)
        })
        
        categoryList = filterData
        tblCategoryObj.reloadData()
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        categoryList = tempStorecategoryList
        tblCategoryObj.reloadData()
        return true
    }
}

//
//  SelectMemberTypeTableViewCell.swift
//  RecruitApp
//
//  Created by MAC on 26/04/21.
//

import UIKit

protocol passMemberTypeDelegate {
    func MemberTypePass(memberType:[String:String])
}

class SelectMemberTypeViewController: UIViewController {

    @IBOutlet weak var tblObj: UITableView!
    
    var memberType = [["id":"2","name":"Hiring Manager"],["id":"3","name":"Site Admin"]]
    var delegateMemberType:passMemberTypeDelegate?
    var selectedTypeData = "2"
    var selectedIndex = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        tblObj.register(nib: UINib(nibName: "CellLocation", bundle: nil), withCellClass: CellLocation.self)
        tblObj.reloadData()
        tblObj.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnCloseClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnDoneClicked(_ sender: Any) {
        
        let data = memberType[selectedIndex]
        delegateMemberType?.MemberTypePass(memberType: data)
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


extension SelectMemberTypeViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblObj.dequeueReusableCell(withIdentifier: "CellLocation", for: indexPath) as! CellLocation
        let data = memberType[indexPath.row]
        cell.lblLocationTitle.text = data["name"]
        cell.locationTickImage.image = UIImage(named: selectedTypeData == data["id"] ? "ic_radio_selected" : "ic_radio_unselected")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = memberType[indexPath.row]
        selectedTypeData = data["id"] ?? ""
        selectedIndex = indexPath.row
        tblObj.reloadData()
    }
    
}

//
//  ModalSelectionSearchRemove.swift
//  x-wing_squad_builder
//
//  Created by Alexander on 14/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import UIKit
import RealmSwift

protocol ModalSelectionSearchRemoveVCDelegate: class {
    func closeModalSelectionSearchRemoveVC()
    func attach(upgrade: Upgrade)
    func removeUpgrade()
}

class ModalSelectionSearchRemoveVC: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var topLbl: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var selectionTableView: UITableView!
    @IBOutlet weak var upgradeIconIV: UIImageView!
    
    var modalSelectionVCDelegate: ModalSelectionSearchRemoveVCDelegate!
    
    var selectedSquadPilot: SquadPilot!
    var selectedType: String!
    var upgradeList: Results<Upgrade>?
    var squadFaction: Faction!
    
    convenience init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, withSquadPilot: SquadPilot, withFaction: Faction!, withType: String, selectionDelegate: ModalSelectionSearchRemoveVCDelegate) {
        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.selectedSquadPilot = withSquadPilot
        self.squadFaction = withFaction
        self.selectedType = withType
        self.modalSelectionVCDelegate = selectionDelegate
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewWillLayoutSubviews() {
        initLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.searchTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        initSelectionTableView()
        initUI()
    }
    
    
    func initLayout() {
        containerView.translatesAutoresizingMaskIntoConstraints = true
        containerView.frame.size.height = LayoutManager.modalSelectionVCheight
        containerView.frame.size.width = LayoutManager.modalSelectionVCwidth
        containerView.center.x = self.view.center.x
        containerView.center.y = self.view.center.y
    }
    
    func initUI() {
        topLbl.text = selectedType
        upgradeIconIV.image = UIImage(named: UpgradeVM(fromType: selectedType).imageNameBlack)
    }
    
    func initSelectionTableView() {
        initUpgradeList()
        selectionTableView.register(UINib(nibName: "UpgradeSelectionCell", bundle: nil), forCellReuseIdentifier: "UpgradeSelectionCell")
        selectionTableView.dataSource = self
        selectionTableView.delegate = self
    }
    
    func initUpgradeList() {
        upgradeList = UpgradeManager.getUpgrades(withFaction: squadFaction, ofType: selectedType, forShip: ShipManager.getShip(withId: selectedSquadPilot.shipId)!)
        selectionTableView.reloadData()
    }
    
    func filterUpgradeList(byName: String) {
        upgradeList = UpgradeManager.filter(upgrades: upgradeList!, byName: byName)
        selectionTableView.reloadData()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if searchTextField.text?.count == 0 {
            initUpgradeList()
        } else {
            filterUpgradeList(byName: searchTextField.text ?? "")
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filterUpgradeList(byName: searchBar.text ?? "")
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
    }
    

    @IBAction func removeBtnPressed(_ sender: UIButton) {
        modalSelectionVCDelegate?.removeUpgrade()
    }
    
    @IBAction func cancelBtnPressed(_ sender: UIButton) {
        modalSelectionVCDelegate?.closeModalSelectionSearchRemoveVC()
    }
    
    @IBAction func clearBtnPressed(_ sender: UIButton) {
        searchTextField.text = ""
        initUpgradeList()
        DispatchQueue.main.async {
            self.searchTextField.resignFirstResponder()
        }
    }
    

}


// MARK: - TableView Methods
extension ModalSelectionSearchRemoveVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upgradeList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = selectionTableView.dequeueReusableCell(withIdentifier: "UpgradeSelectionCell", for: indexPath) as! UpgradeSelectionCell
        if let upgrade = upgradeList?[indexPath.row] {
            let upgradeVM = UpgradeVM(from: upgrade)
            cell.initUI(fromUpgradeVM: upgradeVM)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let upgrade = upgradeList?[indexPath.row] {
            modalSelectionVCDelegate?.attach(upgrade: upgrade)
        }
    }
}





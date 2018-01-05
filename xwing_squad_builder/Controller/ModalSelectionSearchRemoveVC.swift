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
    }
    
    func initSelectionTableView() {
        upgradeList = UpgradeManager.getUpgrades(withFaction: squadFaction, ofType: selectedType)
        selectionTableView.register(UINib(nibName: "UpgradeSelectionCell", bundle: nil), forCellReuseIdentifier: "UpgradeSelectionCell")
        selectionTableView.dataSource = self
        selectionTableView.delegate = self
    }

    @IBAction func removeBtnPressed(_ sender: UIButton) {
        modalSelectionVCDelegate?.removeUpgrade()
    }
    
    @IBAction func cancelBtnPressed(_ sender: UIButton) {
        modalSelectionVCDelegate?.closeModalSelectionSearchRemoveVC()
    }
    
    @IBAction func clearBtnPressed(_ sender: UIButton) {
    }
    

}

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

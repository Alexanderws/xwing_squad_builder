//
//  SquadPilotVC.swift
//  xwing_squad_builder
//
//  Created by Alexander on 28/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import Foundation
import UIKit

protocol SquadPilotVCDelegate: class {
    func getSelectedSquad() -> Squad?
    func closeSquadPilot()
}

class SquadPilotVC: UIViewController {

    
    @IBOutlet weak var shipNameLbl: UILabel!
    @IBOutlet weak var pilotSkillLbl: UILabel!
    @IBOutlet weak var uniquePilotIV: UIImageView!
    @IBOutlet weak var pilotNameLbl: UILabel!
    @IBOutlet weak var abilityTextLbl: UILabel!
    @IBOutlet weak var upgradeTableView: UITableView!
    @IBOutlet weak var squadCostLbl: UILabel!
    
    private var squadPilotVCDelegate: SquadPilotVCDelegate?
    
    
    var selectedSquadPilot: SquadPilot! {
        didSet {
            print("selectedSquadPilot -> didSet")
            //updateSquadCosts()
        }
    }
    
    convenience init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, withPilot: SquadPilot, withDelegate: SquadPilotVCDelegate) {
        self.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.selectedSquadPilot = withPilot
        self.squadPilotVCDelegate = withDelegate
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initUI()
    }
    
    func initTableView() {
        upgradeTableView.delegate = self
        upgradeTableView.dataSource = self
        upgradeTableView.reloadData()
        print(selectedSquadPilot.upgradeSlots)
    }
    
    func initUI() {
        shipNameLbl.text = selectedSquadPilot.shipName.uppercased()
        pilotSkillLbl.text = String(selectedSquadPilot.pilotSkill)
        uniquePilotIV.isHidden = !selectedSquadPilot.isUnique
        pilotNameLbl.text = selectedSquadPilot.name
        abilityTextLbl.text = selectedSquadPilot.abilityText
        let squadCost = squadPilotVCDelegate?.getSelectedSquad()?.squadCost ?? 0
        let squadCostLimit = squadPilotVCDelegate?.getSelectedSquad()?.squadCostLimit ?? 100
        squadCostLbl.text = "\(squadCost)/\(squadCostLimit)"
    }
    
    
    @IBAction func draggableBtnPressed(_ sender: Any) {
        squadPilotVCDelegate?.closeSquadPilot()
    }
    
    
}

extension SquadPilotVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedSquadPilot?.upgradeSlots.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let upgradeCell = tableView.dequeueReusableCell(withIdentifier: "UpgradeCell")
        let upgradeType = selectedSquadPilot.upgradeSlots[indexPath.row]
        let upgradeId = selectedSquadPilot.attachedUpgrades[indexPath.row]
        upgradeCell?.textLabel?.text = upgradeType
        return upgradeCell ?? UITableViewCell()
    }
    
    
    
    
    
    
}

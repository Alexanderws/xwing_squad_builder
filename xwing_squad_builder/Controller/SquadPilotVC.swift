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
    
    // statValuesView
    @IBOutlet weak var attackIconIV: UIImageView!
    @IBOutlet weak var attackValueLbl: UILabel!
    @IBOutlet weak var agilityIconIV: UIImageView!
    @IBOutlet weak var agilityValueLbl: UILabel!
    @IBOutlet weak var hullIconIV: UIImageView!
    @IBOutlet weak var hullValueLbl: UILabel!
    @IBOutlet weak var shieldIconIV: UIImageView!
    @IBOutlet weak var shieldValueLbl: UILabel!
    
    
    @IBOutlet weak var actionBarView: UIView!
    @IBOutlet weak var upgradeCollectionView: UICollectionView!
    @IBOutlet weak var squadCostLbl: UILabel!
    @IBOutlet weak var pilotSquadCostLbl: UILabel!
    
    
    var upgradeSelectVC: ModalSelectionSearchRemoveVC!
    
    private var squadPilotVCDelegate: SquadPilotVCDelegate?
    
    private var currentIndex: Int = -1
    private var currentUpgradeType: String = ""

    var selectedSquadPilot: SquadPilot!
    
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
        initCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initUI()
    }
    
    func initCollectionView() {
        if let flowLayout = upgradeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        upgradeCollectionView.register(UINib(nibName: "EmptyUpgradeCell", bundle: nil), forCellWithReuseIdentifier: "EmptyUpgradeCell")
        upgradeCollectionView.register(UINib(nibName: "UpgradeCell", bundle: nil), forCellWithReuseIdentifier: "UpgradeCell")
        upgradeCollectionView.delegate = self
        upgradeCollectionView.dataSource = self
        upgradeCollectionView.reloadData()
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
        pilotSquadCostLbl.text = String(selectedSquadPilot.squadCost)
        
        attackIconIV.image = UIImage(named: AssetManager.getStatIconName(from: "attack", color: "white"))
        agilityIconIV.image = UIImage(named: AssetManager.getStatIconName(from: "agility", color: "white"))
        hullIconIV.image = UIImage(named: AssetManager.getStatIconName(from: "hull", color: "white"))
        shieldIconIV.image = UIImage(named: AssetManager.getStatIconName(from: "shield", color: "white"))
        attackValueLbl.text = String(selectedSquadPilot.attackValue)
        agilityValueLbl.text = String(selectedSquadPilot.agilityValue)
        hullValueLbl.text = String(selectedSquadPilot.hullValue)
        shieldValueLbl.text = String(selectedSquadPilot.shieldValue)
        
        if let ship = ShipManager.getShip(withId: selectedSquadPilot.shipId) {
            initActionsUI(actions: Array(ship.actions))
        }
    }
    
    func initActionsUI(actions: [String]) {
        for i in 1...7 {
            if let imageView = actionBarView.viewWithTag(i) as? UIImageView {
                if actions.indices.contains(i-1) {
                    let action = actions[i-1]
                    imageView.isHidden = false
                    imageView.image = UIImage(named: AssetManager.getActionIconName(from: action, color: "white"))
                } else {
                    imageView.isHidden = true
                }
            }
        }
    }
    
    func updateUI() {
        squadPilotVCDelegate?.getSelectedSquad()?.updateValues()
        let squadCost = squadPilotVCDelegate?.getSelectedSquad()?.squadCost ?? 0
        let squadCostLimit = squadPilotVCDelegate?.getSelectedSquad()?.squadCostLimit ?? 100
        squadCostLbl.text = "\(squadCost)/\(squadCostLimit)"
        pilotSquadCostLbl.text = String(selectedSquadPilot.squadCost)
        upgradeCollectionView.reloadData()
    }
    
    func presentUpgradeSelectVC() {
        let faction = squadPilotVCDelegate?.getSelectedSquad()?.faction ?? Faction.mixed
        upgradeSelectVC = ModalSelectionSearchRemoveVC(nibName: "ModalSelectionSearchRemoveVC", bundle: nil, withSquadPilot: selectedSquadPilot, withFaction: faction, withType: currentUpgradeType, selectionDelegate: self)
        ViewManager.add(asChildViewController: upgradeSelectVC, inView: self.view, fromViewController: self, atLevel: 10)
    }
    
    @IBAction func draggableBtnPressed(_ sender: Any) {
        squadPilotVCDelegate?.closeSquadPilot()
    }
    
    
}

// MARK: - ModalSelectionSearchRemoveVCDelegate Methods
extension SquadPilotVC: ModalSelectionSearchRemoveVCDelegate {
    func closeModalSelectionSearchRemoveVC() {
        ViewManager.remove(asChildViewController: upgradeSelectVC)
        currentIndex = -1
    }
    
    func attach(upgrade: Upgrade) {
        ViewManager.remove(asChildViewController: upgradeSelectVC)
        selectedSquadPilot.remove(upgrade: currentIndex)
        selectedSquadPilot.attach(upgrade: upgrade, atIndex: currentIndex)
        updateUI()
        currentIndex = -1
    }
    
    func removeUpgrade() {
        ViewManager.remove(asChildViewController: upgradeSelectVC)
        selectedSquadPilot.remove(upgrade: currentIndex)
        updateUI()
        currentIndex = -1
    }
}

// MARK: - UICollectionView Methods
extension SquadPilotVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return selectedSquadPilot.filteredUpgradeSlots.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let upgradeType = selectedSquadPilot.filteredUpgradeSlots[indexPath.row]
        let upgradeId = selectedSquadPilot.filteredAttachedUpgrades[indexPath.row]
        if upgradeId == -1 { // Empty slot
            let upgradeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmptyUpgradeCell", for: indexPath) as! EmptyUpgradeCell
            upgradeCell.initUI(withUpgradetype: upgradeType)
            return upgradeCell
        }
        let upgradeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpgradeCell", for: indexPath) as! UpgradeCell
        if let upgrade = UpgradeManager.getUpgrade(withId: upgradeId) {
            let upgradeVM = UpgradeVM(from: upgrade)
            upgradeCell.initUI(fromUpgradeVM: upgradeVM)
        }
        return upgradeCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentIndex = indexPath.row
        currentUpgradeType = selectedSquadPilot.upgradeSlots[indexPath.row]
        presentUpgradeSelectVC()
    }
}

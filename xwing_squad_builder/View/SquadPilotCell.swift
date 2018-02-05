//
//  SquadPilotCell.swift
//  x-wing_squad_builder
//
//  Created by Alexander on 15/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import UIKit

class SquadPilotCell: SwipeCollectionViewCell {

    
    @IBOutlet weak var pilotSkillLbl: DetailLbl!
    @IBOutlet weak var pilotNameLbl: PrimaryTextLbl!
    @IBOutlet weak var shipNameLbl: PrimaryTextLbl!
    @IBOutlet weak var uniqueIV: UIImageView!
    @IBOutlet weak var squadCostLbl: UILabel!
    
    @IBOutlet weak var attackIconIV: UIImageView!
    @IBOutlet weak var attackValueLbl: UILabel!
    @IBOutlet weak var agilityIconIV: UIImageView!
    @IBOutlet weak var agilityValueLbl: UILabel!
    @IBOutlet weak var hullIconIV: UIImageView!
    @IBOutlet weak var hullValueLbl: UILabel!
    @IBOutlet weak var shieldIconIV: UIImageView!
    @IBOutlet weak var shieldValueLbl: UILabel!
    
    @IBOutlet weak var upgradesCV: UICollectionView!
    
    @IBOutlet weak var copyBtn: UIButton!
    @IBOutlet weak var deleteBtn: UIButton!
    
    @IBOutlet weak var actionBarView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initUpgrades()
        upgradesCV.reloadData()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var upgrades: [String] = [String]()
    
    func initUpgrades() {
        upgradesCV.delegate = self
        upgradesCV.dataSource = self
        upgradesCV.register(UINib(nibName: "SmallUpgradeCell", bundle: nil), forCellWithReuseIdentifier: "SmallUpgradeCell")
    }
    
    
    
    func initUI(pilot: SquadPilot) {
        self.pilotNameLbl.text = pilot.name
        self.pilotSkillLbl.text = String(pilot.pilotSkill)
        self.shipNameLbl.text = pilot.shipName
        self.squadCostLbl.text = String(pilot.squadCost)
        if !pilot.isUnique {
            uniqueIV.isHidden = true
        }
        self.upgrades = pilot.upgradeStrings
        upgradesCV.reloadData()
        attackIconIV.image = UIImage(named: AssetManager.getStatIconName(from: "attack", color: "white"))
        agilityIconIV.image = UIImage(named: AssetManager.getStatIconName(from: "agility", color: "white"))
        hullIconIV.image = UIImage(named: AssetManager.getStatIconName(from: "hull", color: "white"))
        shieldIconIV.image = UIImage(named: AssetManager.getStatIconName(from: "shield", color: "white"))
        attackValueLbl.text = String(pilot.attackValue)
        agilityValueLbl.text = String(pilot.agilityValue)
        hullValueLbl.text = String(pilot.hullValue)
        shieldValueLbl.text = String(pilot.shieldValue)
        
        if let ship = ShipManager.getShip(withId: pilot.shipId) {
            initActionsUI(actions: Array(ship.actions))
        }
    }
    
    func initActionsUI(actions: [String]) {
        for i in 1...7 {
            let imageView = actionBarView.viewWithTag(i) as? UIImageView ?? UIImageView()
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

extension SquadPilotCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upgrades.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let upgradeCell = upgradesCV.dequeueReusableCell(withReuseIdentifier: "SmallUpgradeCell", for: indexPath) as! SmallUpgradeCell
        upgradeCell.upgradeNameLbl.text = upgrades[indexPath.row]
        return upgradeCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let demoLabel = UILabel()
        demoLabel.text = upgrades[indexPath.row]
        let widthDemo = demoLabel.sizeThatFits(CGSize(width: 170, height: 14)).width
        let height = 14
        let width = Int(widthDemo)
        return CGSize(width: width, height: height)
    }
}

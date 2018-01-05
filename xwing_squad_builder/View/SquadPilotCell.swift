//
//  SquadPilotCell.swift
//  x-wing_squad_builder
//
//  Created by Alexander on 15/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import UIKit

class SquadPilotCell: UICollectionViewCell {

    
    @IBOutlet weak var pilotSkillLbl: DetailLbl!
    @IBOutlet weak var pilotNameLbl: PrimaryTextLbl!
    @IBOutlet weak var shipNameLbl: PrimaryTextLbl!
    @IBOutlet weak var uniqueIV: UIImageView!
    @IBOutlet weak var squadCostLbl: UILabel!
    @IBOutlet weak var upgradesView: UIView!
    @IBOutlet weak var attackValueLbl: UILabel!
    @IBOutlet weak var agilityValueLbl: UILabel!
    @IBOutlet weak var hullValueLbl: UILabel!
    @IBOutlet weak var shieldValueLbl: UILabel!
    @IBOutlet weak var actionBarView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func initUI(pilot: SquadPilot) {
        self.pilotNameLbl.text = pilot.name
        self.pilotSkillLbl.text = String(pilot.pilotSkill)
        self.shipNameLbl.text = pilot.shipName
        self.squadCostLbl.text = String(pilot.squadCost)
        if !pilot.isUnique {
            uniqueIV.isHidden = true
        }
        // TODO: Init other parameters
  
    }
    
}

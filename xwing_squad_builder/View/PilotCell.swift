//
//  PilotCell.swift
//  x-wing_squad_builder
//
//  Created by Alexander on 14/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import UIKit

class PilotCell: UITableViewCell {

    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pilotNameLbl: UILabel!
    @IBOutlet weak var pilotSkillLbl: UILabel!
    @IBOutlet weak var squadCostLbl: UILabel!
    @IBOutlet weak var abilityLbl: UILabel!
    @IBOutlet weak var uniqueIV: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)
    }
    
    func initUI(pilotName: String, pilotSkill: Int, squadCost: Int, abilityText: String) {
        self.pilotNameLbl.text = pilotName
        self.pilotSkillLbl.text = String(pilotSkill)
        self.squadCostLbl.text = String(squadCost)
        self.abilityLbl.text = abilityText
    }
    
    func initUI(pilot: Pilot) {
        self.pilotNameLbl.text = pilot.name
        self.pilotSkillLbl.text = String(pilot.pilotSkill)
        self.squadCostLbl.text = String(pilot.squadCost)
        if pilot.abilityText == "" {
            self.abilityLbl.text = "No ability."
        } else {
            self.abilityLbl.text = pilot.abilityText
        }
        self.uniqueIV.isHidden = !pilot.isUnique
    }
}

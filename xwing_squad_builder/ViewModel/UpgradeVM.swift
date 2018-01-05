//
//  UpgradeVM.swift
//  xwing_squad_builder
//
//  Created by Alexander on 04/01/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

import Foundation

class UpgradeVM {
    
    var name: String!
    var isUnique: Bool!
    var text: String!
    var squadCost: Int!
    var imageName: String!
    var slotCount: Int!
    var restrictionText: String!
    var isWeapon: Bool = false
    var attackValue: Int!
    var attackRange: String!
    
    init(from upgrade: Upgrade) {
        self.name = upgrade.name
        self.isUnique = upgrade.isUnique
        self.text = upgrade.text
        self.imageName = getImageName(from: upgrade.upgradeType)
        self.slotCount = upgrade.slotCount
        self.squadCost = upgrade.squadCost
        self.restrictionText = getRestrictionText(from: upgrade)
        if upgrade.isWeapon {
            self.isWeapon = true
            self.attackRange = upgrade.range
            self.attackValue = upgrade.attackValue
        }
    }
    
    func getImageName(from type: String) -> String {
        switch type {
        case UpgradeType.elite.rawValue:
            return UpgradeImageName.elite.rawValue
        case UpgradeType.turret.rawValue:
            return UpgradeImageName.turret.rawValue
        case UpgradeType.torpedo.rawValue:
            return UpgradeImageName.torpedo.rawValue
        case UpgradeType.astromech.rawValue:
            return UpgradeImageName.astromech.rawValue
        case UpgradeType.missile.rawValue:
            return UpgradeImageName.missile.rawValue
        case UpgradeType.crew.rawValue:
            return UpgradeImageName.crew.rawValue
        case UpgradeType.cannon.rawValue:
            return UpgradeImageName.cannon.rawValue
        case UpgradeType.bomb.rawValue:
            return UpgradeImageName.bomb.rawValue
        case UpgradeType.system.rawValue:
            return UpgradeImageName.system.rawValue
        case UpgradeType.cargo.rawValue:
            return UpgradeImageName.cargo.rawValue
        case UpgradeType.hardpoint.rawValue:
            return UpgradeImageName.hardpoint.rawValue
        case UpgradeType.team.rawValue:
            return UpgradeImageName.team.rawValue
        case UpgradeType.illicit.rawValue:
            return UpgradeImageName.illicit.rawValue
        case UpgradeType.salvagedAstromech.rawValue:
            return UpgradeImageName.salvagedAstromech.rawValue
        case UpgradeType.title.rawValue:
            return UpgradeImageName.title.rawValue
        case UpgradeType.tech.rawValue:
            return UpgradeImageName.tech.rawValue
        case UpgradeType.modification.rawValue:
            return UpgradeImageName.modification.rawValue
        default:
            return UpgradeImageName.unknown.rawValue
        }
    }
    
    func getRestrictionText(from upgrade: Upgrade) -> String {
        var text = ""
        // Check for special cases
        /* [Maul, Attani Mindlink,  */
        let specialCases = ["Maul", "Attanni Mindlink", "Lightweight Frame", "Integrated Astromech", "Smuggling Compartment", "Quick-release Cargo Locks", "Twin Ion Engine Mk. II"]
        if specialCases.contains(upgrade.name) {
            switch upgrade.name {
            case specialCases[0]: // "Maul"
                text = "SCUM OR SQUAD CONTAINING \"EZRA BRIDGER\"."
            case specialCases[1]: // "Attanni Mindlink"
                text = "SCUM ONLY. LIMIT 2 PER SQUAD."
            case specialCases[2]: // "Lightweight Frame"
                text = "TIE ONLY."
            case specialCases[3]: // "Integrated Astromech"
                text = "X-WING ONLY."
            case specialCases[4]: // "Smuggling Compartment"
                text = "YT-1300 AND YT-2400 ONLY."
            case specialCases[5]: // "Quick-release Cargo Locks"
                text = "C-ROC CRUISER AND GR-75 ONLY. LIMITED."
            case specialCases[6]: // "Twin Ion Engine Mk. II"
                text = "TIE ONLY."
            default:
                text = "UNHANDLED SPECIAL CASE"
            }
            return text
        }
        if upgrade.compatibleShips.count == 1 {
            text += "\(upgrade.compatibleShips.first!.name.uppercased()) ONLY. "
        }
        if upgrade.shipSizeLimit != "" {
            text += "\(upgrade.shipSizeLimit.uppercased()) SHIP ONLY. "
        }
        if upgrade.factions.count > 1 {
        
        } else if upgrade.factions.first?.type != Faction.mixed.rawValue {
            if upgrade.factions.first?.type == Faction.rebelAlliance.rawValue {
                text += "REBEL ONLY. "
            }
            if upgrade.factions.first?.type == Faction.scumAndVillainy.rawValue {
                text += "SCUM ONLY. "
            }
            if upgrade.factions.first?.type == Faction.galacticEmpire.rawValue {
                text += "IMPERIAL ONLY. "
            }
        }
        if upgrade.isDualCard {
            text += "DUAL CARD. "
        }
        if upgrade.isLimited {
            text += "LIMITED. "
        }
        let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmedText
    }
    
    
    
}

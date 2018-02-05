//
//  AssetManager.swift
//  xwing_squad_builder
//
//  Created by Alexander on 09/01/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

import Foundation

class AssetManager {

    class func getUniqueIconName(color: String) -> String {
        if color == "black" {
            return "icon_unique_18_black"
        }
        return "icon_unique_18_white"
    }

    class func getActionIconName(from action: String, color: String) -> String {
        switch action {
        case "Focus":
            if color == "black" {
                return "icon_action_focus_black"
            }
            return "icon_action_focus_white"
        case "Target Lock":
            if color == "black" {
                return "icon_action_targetlock_black"
            }
            return "icon_action_targetlock_white"
        case "Boost":
            if color == "black" {
                return "icon_action_boost_black"
            }
            return "icon_action_boost_white"
        case "Evade":
            if color == "black" {
                return "icon_action_evade_black"
            }
            return "icon_action_evade_white"
        case "Barrel Roll":
            if color == "black" {
                return "icon_action_barrelroll_black"
            }
            return "icon_action_barrelroll_white"
        case "Reinforce":
            if color == "black" {
                return "icon_action_reinforce_black"
            }
            return "icon_action_reinforce_white"
        case "SLAM":
            if color == "black" {
                return "icon_action_slam_black"
            }
            return "icon_action_slam_white"
        case "Recover":
            if color == "black" {
                return "icon_upgrade_unknown_black"
            }
            return "icon_upgrade_unknown_white"
        case "Coordinate":
            if color == "black" {
                return "icon_action_coordinate_black"
            }
            return "icon_action_coordinate_white"
        case "Rotate Arc":
            if color == "black" {
                return "icon_upgrade_unknown_black"
            }
            return "icon_upgrade_unknown_white"
        case "Cloak":
            if color == "black" {
                return "icon_upgrade_unknown_black"
            }
            return "icon_upgrade_unknown_white"
        case "Jam":
            if color == "black" {
                return "icon_action_jam_black"
            }
            return "icon_action_jam_white"
        case "Reload":
            if color == "black" {
                return "icon_action_reload_black"
            }
            return "icon_action_reload_white"
        default:
            if color == "black" {
                return "icon_upgrade_unknown_black"
            }
            return "icon_upgrade_unknown_white"
        }
    }

    class func getStatIconName(from type: String, color: String) -> String {
        switch type {
        case "attack":
            if color == "black" {
                return "icon_stat_attack_black"
            }
            return "icon_stat_attack_white"
        case "agility":
            if color == "black" {
                return "icon_stat_agility_black"
            }
            return "icon_stat_agility_white"
        case "hull":
            if color == "black" {
                return "icon_stat_hull_black"
            }
                return "icon_stat_hull_white"
        case "shield":
            if color == "black" {
                return "icon_stat_shield_black"
            }
            return "icon_stat_shield_white"
        case "shieldHull":
            if color == "black" {
                return "icon_stat_shieldhull_black"
            }
            return "icon_stat_shieldhull_white"
        case "victory":
            if color == "black" {
                return "icon_stat_victory_black"
            }
            return "icon_stat_victory_white"
        default:
            if color == "black" {
                return "icon_upgrade_unknown_black"
            }
            return "icon_upgrade_unknown_white"
        }
    }

    class func getUpgradeIconName(from type: String, color: String) -> String {
        switch type {
        case UpgradeType.elite.rawValue:
            if color == "white" {
                return "\(UpgradeImageName.elite.rawValue)white"
            } else {
                return "\(UpgradeImageName.elite.rawValue)black"
            }
        case UpgradeType.turret.rawValue:
            if color == "white" {
                return "\(UpgradeImageName.turret.rawValue)white"
            } else {
                return "\(UpgradeImageName.turret.rawValue)black"
            }
        case UpgradeType.torpedo.rawValue:
            if color == "white" {
                return "\(UpgradeImageName.torpedo.rawValue)white"
            } else {
                return "\(UpgradeImageName.torpedo.rawValue)black"
            }
        case UpgradeType.astromech.rawValue:
            if color == "white" {
                return "\(UpgradeImageName.astromech.rawValue)white"
            } else {
                return "\(UpgradeImageName.astromech.rawValue)black"
            }
        case UpgradeType.missile.rawValue:
            if color == "white" {
                return "\(UpgradeImageName.missile.rawValue)white"
            } else {
                return "\(UpgradeImageName.missile.rawValue)black"
            }
        case UpgradeType.crew.rawValue:
            if color == "white" {
                return "\(UpgradeImageName.crew.rawValue)white"
            } else {
                return "\(UpgradeImageName.crew.rawValue)black"
            }
        case UpgradeType.cannon.rawValue:
            if color == "white" {
                return "\(UpgradeImageName.cannon.rawValue)white"
            } else {
                return "\(UpgradeImageName.cannon.rawValue)black"
            }
        case UpgradeType.bomb.rawValue:
            if color == "white" {
                return "\(UpgradeImageName.bomb.rawValue)white"
            } else {
                return "\(UpgradeImageName.bomb.rawValue)black"
            }
        case UpgradeType.system.rawValue:
            if color == "white" {
                return "\(UpgradeImageName.system.rawValue)white"
            } else {
                return "\(UpgradeImageName.system.rawValue)black"
            }
        case UpgradeType.cargo.rawValue:
            if color == "white" {
                return "\(UpgradeImageName.cargo.rawValue)white"
            } else {
                return "\(UpgradeImageName.cargo.rawValue)black"
            }
        case UpgradeType.hardpoint.rawValue:
            if color == "white" {
                return "\(UpgradeImageName.hardpoint.rawValue)white"
            } else {
                return "\(UpgradeImageName.hardpoint.rawValue)black"
            }
        case UpgradeType.team.rawValue:
            if color == "white" {
                return "\(UpgradeImageName.team.rawValue)white"
            } else {
                return "\(UpgradeImageName.team.rawValue)black"
            }
        case UpgradeType.illicit.rawValue:
            if color == "white" {
                return "\(UpgradeImageName.illicit.rawValue)white"
            } else {
                return "\(UpgradeImageName.illicit.rawValue)black"
            }
        case UpgradeType.salvagedAstromech.rawValue:
            if color == "white" {
                return "\(UpgradeImageName.salvagedAstromech.rawValue)white"
            } else {
                return "\(UpgradeImageName.salvagedAstromech.rawValue)black"
            }
        case UpgradeType.title.rawValue:
            if color == "white" {
                return "\(UpgradeImageName.title.rawValue)white"
            } else {
                return "\(UpgradeImageName.title.rawValue)black"
            }
        case UpgradeType.tech.rawValue:
            if color == "white" {
                return "\(UpgradeImageName.tech.rawValue)white"
            } else {
                return "\(UpgradeImageName.tech.rawValue)black"
            }
        case UpgradeType.modification.rawValue:
            if color == "white" {
                return "\(UpgradeImageName.modification.rawValue)white"
            } else {
                return "\(UpgradeImageName.modification.rawValue)black"
            }
        default:
            return UpgradeImageName.unknown.rawValue
        }
    }

}

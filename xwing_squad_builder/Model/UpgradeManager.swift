//
//  UpgradeManager.swift
//  xwing_squad_builder
//
//  Created by Alexander on 27/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import Foundation
import RealmSwift

class UpgradeManager {
    
    class func initUpgrades() {
        let filePath = Bundle.main.path(forResource: "upgrades", ofType:"json")
        let data = try! Data(contentsOf: URL(fileURLWithPath:filePath!), options: .uncached)
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        
        if let array = json as? [Any] {
            for upgrade in array {
                if let upgradeDictionary = upgrade as? [String: Any] {
                    
                    guard let name = upgradeDictionary["name"] as? String, let id = upgradeDictionary["id"] as? Int, let upgradeType = upgradeDictionary["slot"] as? String, let slotCount = upgradeDictionary["slotCount"] as? Int, let squadCost = upgradeDictionary["points"] as? Int, let text = upgradeDictionary["text"] as? String, let xws = upgradeDictionary["xws"] as? String else {
                        print("error: guard let upgradeDictionary")
                        print("upgradeName \(upgradeDictionary["name"] as! String)")
                        return
                    }
                    
                    let unique = upgradeDictionary["unique"] as? Bool ?? false
                    var factions = [String]()
                    if let singleFaction = upgradeDictionary["faction"] as? String {
                        factions.append(singleFaction)
                    } else if let factionArray = upgradeDictionary["faction"] as? [String] {
                        factions += factionArray
                    } else {
                        factions.append(Faction.mixed.rawValue)
                    }
                    let isLimited = upgradeDictionary["limited"] as? Bool ?? false
                    var shipSizeLimit = ""
                    if let sizeLimit = upgradeDictionary["size"] as? [String] {
                        shipSizeLimit = sizeLimit[0]
                    }
                    let squadLimit = upgradeDictionary["squadLimited"] as? Int ?? -1
                    
                    let compatibleShips = upgradeDictionary["ship"] as? [String] ?? [String]()
                    
                    let range = upgradeDictionary["range"] as? String ?? ""
                    let attackValue = upgradeDictionary["attack"] as? Int ?? -1
                    let effect = upgradeDictionary["effect"] as? String ?? ""
                    let isDualCard = upgradeDictionary["dualCard"] as? Bool ?? false
                    let energyLimitIncrease = upgradeDictionary["energy"] as? Int ?? -1
                    let hasSquadEffect = upgradeDictionary["grants"] != nil
                    var condition = ""
                    if let conditionArray = upgradeDictionary["condtions"] as? [String] {
                        condition = conditionArray[0]
                    }
                    
                    if getUpgrade(withId: id) == nil {
                        let newUpgrade = Upgrade(name: name, id: id, upgradeType: upgradeType, slotCount: slotCount, squadCost: squadCost, text: text, xws: xws, isUnique: unique, factions: factions, isLimited: isLimited, shipSizeLimit: shipSizeLimit, squadLimit: squadLimit, range: range, attackValue: attackValue, effect: effect, energyLimitIncrease: energyLimitIncrease, hasSquadEffect: hasSquadEffect, condition: condition, dualCard: isDualCard)
                        
                        for shipName in compatibleShips {
                            if let ship = ShipManager.getShip(withName: shipName) {
                                newUpgrade.compatibleShips.append(ship)
                                ship.upgrades.append(newUpgrade)
                                ShipManager.save(ship: ship)
                            }
                        }
                        self.save(upgrade: newUpgrade)
                    }
                }
            }
        }
    }
    
    
    class func getUpgrade(withId: Int) -> Upgrade? {
        let realm = try! Realm()
        return realm.object(ofType: Upgrade.self, forPrimaryKey: withId)
    }
    
    class func getUpgrade(withName: String) -> Upgrade? {
        let realm = try! Realm()
        return realm.objects(Upgrade.self).filter("%K = %@", "name", withName).first
    }
    
    class func getUpgrades(withFaction: Faction) -> Results<Upgrade>? {
        let realm = try! Realm()
        var upgrades: Results<Upgrade>?
        if withFaction == Faction.galacticEmpire {
            upgrades = realm.objects(Upgrade.self).filter("ANY %K = %@ OR ANY %K = %@", "faction", Faction.galacticEmpire.rawValue, "faction", Faction.firstOrder.rawValue).sorted(byKeyPath: "squadCost", ascending: true)
        } else if withFaction == Faction.rebelAlliance {
            upgrades = realm.objects(Upgrade.self).filter("ANY %K = %@ OR ANY %K = %@", "faction", Faction.rebelAlliance.rawValue, "faction", Faction.resistance.rawValue).sorted(byKeyPath: "squadCost", ascending: true)
        } else if withFaction == Faction.scumAndVillainy {
            upgrades = realm.objects(Upgrade.self).filter("ANY %K = %@", "faction", Faction.scumAndVillainy.rawValue).sorted(byKeyPath: "squadCost", ascending: true)
        } else {
            upgrades = realm.objects(Upgrade.self).sorted(byKeyPath: "squadCost", ascending: true)
        }
        return upgrades
    }
    
    class func getUpgrades(withFaction: Faction, ofType: String) -> Results<Upgrade>? {
        let realm = try! Realm()
        var upgrades = realm.objects(Upgrade.self).filter("%K = %@", "upgradeType", ofType).sorted(byKeyPath: "squadCost", ascending: true)
        if withFaction == Faction.galacticEmpire {
            upgrades = upgrades.filter("ANY %K = %@ OR ANY %K = %@ OR ANY %K = %@", "factions.type", Faction.galacticEmpire.rawValue, "factions.type", Faction.firstOrder.rawValue, "factions.type", Faction.mixed.rawValue).sorted(byKeyPath: "squadCost", ascending: true)
        } else if withFaction == Faction.rebelAlliance {
            upgrades = upgrades.filter("ANY %K = %@ OR ANY %K = %@ OR ANY %K = %@", "factions.type", Faction.rebelAlliance.rawValue, "factions.type", Faction.resistance.rawValue, "factions.type", Faction.mixed.rawValue).sorted(byKeyPath: "squadCost", ascending: true)
        } else if withFaction == Faction.scumAndVillainy {
            upgrades = upgrades.filter("ANY %K = %@ OR ANY %K = %@", "factions.type", Faction.scumAndVillainy.rawValue, "factions.type", Faction.mixed.rawValue).sorted(byKeyPath: "squadCost", ascending: true)
        }
        return upgrades
    }
    
    class func save(upgrade: Upgrade) {
        let realm = try! Realm()
        do {
            try realm.write{
                realm.add(upgrade)
            }
        } catch {
            print("Error saving upgrade, \(error)")
        }
    }
    
}

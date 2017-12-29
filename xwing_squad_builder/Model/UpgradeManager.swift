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
                    let faction = upgradeDictionary["faction"] as? String ?? Faction.mixed.rawValue
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

                    let energyLimitIncrease = upgradeDictionary["energy"] as? Int ?? -1
                    let hasSquadEffect = upgradeDictionary["grants"] != nil
                    var condition = ""
                    if let conditionArray = upgradeDictionary["condtions"] as? [String] {
                        condition = conditionArray[0]
                    }
                    
                    if getUpgrade(withId: id) == nil {
                        let newUpgrade = Upgrade(name: name, id: id, upgradeType: upgradeType, slotCount: slotCount, squadCost: squadCost, text: text, xws: xws, isUnique: unique, faction: faction, isLimited: isLimited, shipSizeLimit: shipSizeLimit, squadLimit: squadLimit, range: range, attackValue: attackValue, effect: effect, energyLimitIncrease: energyLimitIncrease, hasSquadEffect: hasSquadEffect, condition: condition)
                        
                        for shipName in compatibleShips {
                            if let ship = ShipManager.getShip(withName: shipName) {
                                newUpgrade.compatibleShips.append(ship)
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

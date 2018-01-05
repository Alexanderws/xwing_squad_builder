//
//  Upgrade.swift
//  xwing_squad_builder
//
//  Created by Alexander on 27/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import Foundation
import RealmSwift

class RealmFaction: Object {
    @objc dynamic var type: String = ""
    
    convenience init(type: String) {
        self.init()
        self.type = type
    }
}

class Upgrade: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var id = -1
    @objc dynamic var upgradeType = ""
    @objc dynamic var slotCount = 1
    @objc dynamic var squadCost = 0
    @objc dynamic var text = ""
    @objc dynamic var xws = ""

    @objc dynamic var isUnique = false
    @objc dynamic var faction = Faction.mixed.rawValue
    @objc dynamic var isLimited = false
    @objc dynamic var isDualCard = false
    @objc dynamic var shipSizeLimit = ""
    @objc dynamic var squadLimit = -1
    
    let factions = List<RealmFaction>()
    let compatibleShips = List<Ship>()
    
    @objc dynamic var range = ""
    @objc dynamic var attackValue = -1
    @objc dynamic var isWeapon = false
    @objc dynamic var effect = ""

    @objc dynamic var energyLimitIncrease = -1
    @objc dynamic var hasSquadEffect = false
    @objc dynamic var condition: Condition? = nil
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(name: String, id: Int, upgradeType: String, slotCount: Int, squadCost: Int, text: String, xws: String, isUnique: Bool, factions: [String], isLimited: Bool, shipSizeLimit: String, squadLimit: Int, range: String, attackValue: Int, effect: String, energyLimitIncrease: Int, hasSquadEffect: Bool, condition: String, dualCard: Bool) {
        self.init()
        self.name = name
        self.id = id
        self.upgradeType = upgradeType
        self.slotCount = slotCount
        self.squadCost = squadCost
        self.text = text
        self.xws = xws
        self.isUnique = isUnique
        self.isLimited = isLimited
        self.shipSizeLimit = shipSizeLimit
        self.squadLimit = squadLimit
        self.range = range
        self.attackValue = attackValue
        self.isWeapon = attackValue > -1
        self.effect = effect
        self.energyLimitIncrease = energyLimitIncrease
        self.hasSquadEffect = hasSquadEffect
        self.isDualCard = dualCard
        
        for faction in factions {
            self.factions.append(RealmFaction(type: faction))
        }
        
    }
    
    
    
    
    
    
}

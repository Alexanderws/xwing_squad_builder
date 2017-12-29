//
//  Pilot.swift
//  xwing_squad_builder
//
//  Created by Alexander on 27/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import Foundation
import RealmSwift

class Pilot: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var isUnique: Bool = false
    @objc dynamic var pilotSkill: Int = 0
    @objc dynamic var squadCost: Int = 0
    @objc dynamic var faction: String = ""
    @objc dynamic var abilityText: String = ""
    @objc dynamic var xws: String = ""
    var parentShip = LinkingObjects(fromType: Ship.self, property: "pilots")
    let upgradeSlots = List<String>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(name: String, id: Int, unique: Bool, pilotSkill: Int, squadCost: Int, faction: String, upgradeSlots: [String], abilityText: String, xws: String) {
        self.init()
        self.name = name
        self.id = id
        self.isUnique = unique
        self.pilotSkill = pilotSkill
        self.squadCost = squadCost
        self.faction = faction
        self.abilityText = abilityText
        self.xws = xws
        for slot in upgradeSlots {
            self.upgradeSlots.append(slot)
        }
    }
    
    
    
}

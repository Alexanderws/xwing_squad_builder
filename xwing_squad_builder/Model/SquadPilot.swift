//
//  SquadPilot.swift
//  x-wing_squad_builder
//
//  Created by Alexander on 09/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import Foundation



class SquadPilot: Codable {
    
    private(set) var id: Int!
    private(set) var name: String!
    private(set) var shipId: Int!
    private(set) var shipName: String!
    private(set) var abilityText: String!
    private(set) var pilotSkill: Int!
    private(set) var isUnique: Bool!
    //private(set) var upgradeSlots = [String: Int]()
    //private(set) var upgradesAttached = [String: [Int]]()
    private(set) var upgradeSlots = [String]()
    private(set) var attachedUpgrades = [Int]()
    private(set) var baseSquadCost = 0
    private(set) var squadCost = 0
    private(set) var attackValue = 0
    private(set) var agilityValue = 0
    private(set) var hullValue = 0
    private(set) var shieldValue = 0
    
    
    init(selectedPilot: Int, pilotCost: Int) {
        self.id = selectedPilot
        self.squadCost = pilotCost
    }
    
    init(fromPilot: Pilot) {
        self.id = Int(fromPilot.id)
        self.name = fromPilot.name
        self.shipId = fromPilot.parentShip.first?.id
        self.shipName = fromPilot.parentShip.first?.name
        self.abilityText = fromPilot.abilityText
        self.pilotSkill = fromPilot.pilotSkill
        self.squadCost = fromPilot.squadCost
        self.baseSquadCost = self.squadCost
        //initializeUpgradeSlots(fromArray: (Array(fromPilot.upgradeSlots)))
        self.upgradeSlots = Array(fromPilot.upgradeSlots)
        initAttachedUpgrades()
        initializeShipStats(fromShip: fromPilot.parentShip.first!)
        self.isUnique = fromPilot.isUnique
    }
    
    /*func initializeUpgradeSlots(fromArray: [String]){
        for upgrade in fromArray {
            if let slotValue = upgradeSlots[upgrade] {
                upgradeSlots[upgrade] = slotValue + 1
            } else {
                upgradeSlots[upgrade] = 1
            }
        }
    }*/
    
    func initAttachedUpgrades() {
        for _ in 1...upgradeSlots.count {
            attachedUpgrades.append(-1)
        }
    }
    
    func initializeShipStats(fromShip: Ship) {
        // TODO: Set shipStats from Ship object
        self.attackValue = fromShip.attackValue
        self.agilityValue = fromShip.agilityValue
        self.hullValue = fromShip.hullValue
        self.shieldValue = fromShip.shieldValue
    }
    
}



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
    private(set) var upgradeSlots = [String]()
    private(set) var attachedUpgrades = [Int]()
    private(set) var baseSquadCost = 0
    private(set) var squadCost = 0
    private(set) var attackValue = 0
    private(set) var agilityValue = 0
    private(set) var hullValue = 0
    private(set) var shieldValue = 0
    
    var filteredUpgradeSlots: [String] {
        get {
            var filtered = upgradeSlots
            let emptyIndexes = attachedUpgrades.indexesOf(object: -2)
            for i in emptyIndexes {
                filtered.remove(at: i)
            }
            return filtered
        }
    }
    
    var filteredAttachedUpgrades: [Int] {
        get {
            return attachedUpgrades.filter { (item) -> Bool in
                item != -2
            }
        }
    }
    
    var upgradeStrings: [String] {
        get {
            var strings = [String]()
            for id in filteredAttachedUpgrades.filter({ (item) -> Bool in item != -1}) {
                strings.append((UpgradeManager.getUpgrade(withId: id)?.name) ?? "Error upgradeId: (id)")
            }
            return strings
        }
        
        
    }
    
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
        self.upgradeSlots = Array(fromPilot.upgradeSlots)
        initAttachedUpgrades()
        initializeShipStats(fromShip: fromPilot.parentShip.first!)
        self.isUnique = fromPilot.isUnique
    }

    
    func initAttachedUpgrades() {
        for _ in 1...upgradeSlots.count {
            self.attachedUpgrades.append(-1)
        }
    }
    
    func initializeShipStats(fromShip: Ship) {
        // TODO: Set shipStats from Ship object
        self.attackValue = fromShip.attackValue
        self.agilityValue = fromShip.agilityValue
        self.hullValue = fromShip.hullValue
        self.shieldValue = fromShip.shieldValue
    }
    
    func updateSquadCost(withValue: Int) {
        self.squadCost += withValue
    }
    
    func attach(upgrade: Upgrade, atIndex: Int) {
        updateSquadCost(withValue: upgrade.squadCost)
        if upgrade.slotCount == 1 {
            self.attachedUpgrades[atIndex] = upgrade.id
        }
        else {
            let compatibleIndexes = self.upgradeSlots.indexesOf(object: upgrade.upgradeType)
            var availableIndexes = [atIndex]
            for (_, element) in compatibleIndexes.enumerated() {
                if self.attachedUpgrades[element] == -1 && element != atIndex {
                    availableIndexes.append(element)
                }
            }
            if availableIndexes.count >= upgrade.slotCount {
                for (index, _) in availableIndexes.enumerated() {
                    if availableIndexes[index] == atIndex {
                        self.attachedUpgrades[availableIndexes[index]] = upgrade.id
                        if self.attachedUpgrades.indices.contains(index + 1) {
                            self.attachedUpgrades[availableIndexes[index + 1]] = -2
                        } else {
                            self.attachedUpgrades[availableIndexes[0]] = -2
                        }
                    }
                }
            } else {
                self.updateSquadCost(withValue: (-upgrade.squadCost))
                print("!!! not enough slots to attach upgrade '\(upgrade.name)' !!!")
            }
        }
    }
    
    func remove(upgrade atIndex: Int) {
        if self.attachedUpgrades[atIndex] != -1 {
            if let upgrade = UpgradeManager.getUpgrade(withId: self.attachedUpgrades[atIndex]) {
                self.updateSquadCost(withValue: (-upgrade.squadCost))
                self.attachedUpgrades[atIndex] = -1
                if upgrade.slotCount >= 1 {
                    var remainingSlots = upgrade.slotCount - 1
                    for (index, element) in self.attachedUpgrades.enumerated() {
                        if index != atIndex && self.upgradeSlots[index] == upgrade.upgradeType && element == -2 && remainingSlots > 0 {
                            self.attachedUpgrades[index] = -1
                            remainingSlots -= 1
                        }
                    }
                }
            }
        }
    }
}



//
//  Squad.swift
//  x-wing_squad_builder
//
//  Created by Alexander on 09/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import Foundation



class Squad: Codable {
    
    private(set) var pilots = [SquadPilot]()
    private(set) var name: String!
    private(set) var faction: Faction!
    private(set) var squadCostLimit: Int!
    private(set) var squadCost = 0
    private(set) var attackValue = 0
    private(set) var agilityValue = 0
    private(set) var shieldHullValue = 0
    private(set) var timesWon = 0
    private(set) var timesLost = 0
    
    var timesPlayed: Int {
        get {
            return timesWon + timesLost
        }
    }
    
    var winPercentage: Int {
        get {
            if timesPlayed > 0{
                return Int((Float(timesWon) / Float(timesPlayed)) * 100)
            }
            return 0
        }
    }
    
    init(squadName: String, squadFaction: Faction, squadCostLimit: Int) {
        self.name = squadName
        self.faction = squadFaction
        self.squadCostLimit = squadCostLimit
    }
    
    func addPilot(pilot: SquadPilot) {
        pilots.append(pilot)
        updateValues()
    }
    
    func updateValues() {
        var cost = 0
        var attack = 0
        var agility = 0
        var shieldHull = 0
        for pilot in pilots {
            cost += pilot.squadCost
            attack += pilot.attackValue
            agility += pilot.agilityValue
            shieldHull += pilot.shieldValue
            shieldHull += pilot.hullValue
        }
        self.squadCost = cost
        self.attackValue = attack
        self.agilityValue = agility
        self.shieldHullValue = shieldHull
    }
    
    
}

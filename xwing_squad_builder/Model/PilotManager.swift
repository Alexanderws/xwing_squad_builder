//
//  PilotManager.swift
//  xwing_squad_builder
//
//  Created by Alexander on 27/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import Foundation
import RealmSwift

class PilotManager {
    
    class func initPilots() {
        let filePath = Bundle.main.path(forResource: "pilots", ofType:"json")
        let data = try! Data(contentsOf: URL(fileURLWithPath:filePath!), options: .uncached)
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        
        if let array = json as? [Any] {
            for pilot in array {
                if let pilotDictionary = pilot as? [String: Any] {
                    
                    
                    guard let pilotName = pilotDictionary["name"] as? String, let pilotId = pilotDictionary["id"] as? Int, let pilotSkill = pilotDictionary["skill"] as? Int, let faction = pilotDictionary["faction"] as? String, let shipId = pilotDictionary["shipId"] as? Int, let squadCost = pilotDictionary["points"] as? Int, let xws = pilotDictionary["xws"] as? String else {
                        print("not guard let pilotDictionary")
                        print("piloName \(pilotDictionary["name"] as! String)")
                        return
                    }
                    var slots: [String] = ["Title"]
                    if let pilotSlots = pilotDictionary["slots"] as? [String] {
                        slots += pilotSlots
                    }
                    slots += ["Modification"]
                    let abilityText = pilotDictionary["text"] as? String ?? ""
                    let unique = pilotDictionary["unique"] as? Bool ?? false
                    
                    if getPilot(withId: pilotId) == nil {
                        let newPilot = Pilot(name: pilotName, id: pilotId, unique: unique, pilotSkill: pilotSkill, squadCost: squadCost, faction: faction, upgradeSlots: slots, abilityText: abilityText, xws: xws)
                        if let ship = ShipManager.getShip(withId: shipId) {
                            self.save(pilot: newPilot, ofShip: ship)
                        } else {
                            print("Ship with id \(shipId) does not exist.")
                            break
                        }
                    }
                }
            }
        }
    }
    
    class func getPilot(withId: Int) -> Pilot? {
        let realm = try! Realm()
        return realm.object(ofType: Pilot.self, forPrimaryKey: withId)
    }
    
    class func getPilots(withFaction: Faction, ofShip: Ship) -> Results<Pilot> {
        var pilots: Results<Pilot>
        
        switch withFaction {
        case .rebelAlliance:
            pilots = ofShip.pilots.filter("%K = %@ OR %K = %@", "faction", Faction.rebelAlliance.rawValue, "faction", Faction.resistance.rawValue).sorted(byKeyPath: "pilotSkill", ascending: false)
        case .galacticEmpire:
            pilots = ofShip.pilots.filter("%K = %@ OR %K = %@", "faction", Faction.galacticEmpire.rawValue, "faction", Faction.firstOrder.rawValue).sorted(byKeyPath: "pilotSkill", ascending: false)
        case .scumAndVillainy:
            pilots = ofShip.pilots.filter("%K = %@", "faction", Faction.scumAndVillainy.rawValue).sorted(byKeyPath: "pilotSkill", ascending: false)
        default:
            pilots = ofShip.pilots.sorted(byKeyPath: "pilotSkill", ascending: false)
        }
        return pilots
    }
    
    
    class func save(pilot: Pilot, ofShip: Ship) {
        let realm = try! Realm()
        do {
            try realm.write{
                realm.add(pilot)
                ofShip.pilots.append(pilot)
            }
        } catch {
            print("Error saving pilot, \(error)")
        }
    }
    
}

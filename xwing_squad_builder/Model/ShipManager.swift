//
//  ShipManager.swift
//  xwing_squad_builder
//
//  Created by Alexander on 27/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import Foundation
import RealmSwift

class ShipManager {
    
    class func initShips() {
        let filePath = Bundle.main.path(forResource: "ships", ofType:"json")
        let data = try! Data(contentsOf: URL(fileURLWithPath:filePath!), options: .uncached)
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        
        if let array = json as? [Any] {
            for ship in array {
                if let shipDictionary = ship as? [String: Any] {
                    guard let name = shipDictionary["name"] as? String, let shipId = shipDictionary["id"] as? Int, let xws = shipDictionary["xws"] as? String, let agilityValue = shipDictionary["agility"] as? Int, let hullValue = shipDictionary["hull"] as? Int, let shieldValue = shipDictionary["shields"] as? Int, let shipSize = shipDictionary["size"] as? String else {
                        print("Not guard let shipDictionary")
                        print("shipID \(shipDictionary["id"] as! Int)")
                        return
                    }
                    let attackValue = shipDictionary["attack"] as? Int ?? 0
                    var actions = [String]()
                    if let actionArray = shipDictionary["actions"] as? [String] {
                        actions = actionArray
                    }
                    
                    if getShip(withId: shipId) == nil {
                        let newShip = Ship(name: name, id: shipId, xws: xws, attackValue: attackValue, agilityValue: agilityValue, hullValue: hullValue, shieldValue: shieldValue, shipSize: shipSize, actions: actions)
                        self.save(ship: newShip)
                    }
                }
            }
        }
    }

    class func getShip(withId: Int) -> Ship? {
        let realm = try! Realm()
        return realm.object(ofType: Ship.self, forPrimaryKey: withId)
    }
    
    class func getShip(withName: String) -> Ship? {
        let realm = try! Realm()
        return realm.objects(Ship.self).filter("%K = %@", "name", withName).first
    }
    
    class func getShips(withFaction: Faction) -> Results<Ship>? {
        let realm = try! Realm()
        var ships: Results<Ship>?
        if withFaction == Faction.galacticEmpire {
            ships = realm.objects(Ship.self).filter("ANY %K = %@ OR ANY %K = %@", "pilots.faction", Faction.galacticEmpire.rawValue, "pilots.faction", Faction.firstOrder.rawValue).sorted(byKeyPath: "name", ascending: true)
        } else if withFaction == Faction.rebelAlliance {
            ships = realm.objects(Ship.self).filter("ANY %K = %@ OR ANY %K = %@", "pilots.faction", Faction.rebelAlliance.rawValue, "pilots.faction", Faction.resistance.rawValue).sorted(byKeyPath: "name", ascending: true)
        } else if withFaction == Faction.scumAndVillainy {
            ships = realm.objects(Ship.self).filter("ANY %K = %@", "pilots.faction", Faction.scumAndVillainy.rawValue).sorted(byKeyPath: "name", ascending: true)
        } else {
            ships = realm.objects(Ship.self).sorted(byKeyPath: "name", ascending: true)
        }
        return ships
    }
    
    class func save(ship: Ship) {
        let realm = try! Realm()
        do {
            try realm.write{
                realm.add(ship)
            }
        } catch {
            print("Error saving ship, \(error)")
        }
    }


}

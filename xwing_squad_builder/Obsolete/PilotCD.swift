//
//  PilotCD.swift
//  x-wing_squad_builder
//
//  Created by Alexander on 13/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import Foundation
import CoreData
import UIKit

/*class PilotCD {
    
    class func initPilots() {
        // TODO: Check if entity exists -> update values as needed
        print("INIT PILOTS")
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let filePath = Bundle.main.path(forResource: "pilots", ofType:"json")
        let data = try! Data(contentsOf: URL(fileURLWithPath:filePath!), options: .uncached)
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        
        if let array = json as? [Any] {
            print("if let array = json as? [Any]")
            for pilot in array {
                if let pilotDictionary = pilot as? [String: Any] {
                    print("pilotDictionary")
                    var slots: [String] = ["Title", "Modification"]
                    guard let pilotName = pilotDictionary["name"] as? String, let pilotId = pilotDictionary["id"] as? Int32, let pilotSkill = pilotDictionary["skill"] as? Int32,   let faction = pilotDictionary["faction"] as? String, let shipName = pilotDictionary["Ships"] as? String, let squadCost = pilotDictionary["points"] as? Int32 else {
                        print("not guard let Pilots")
                        return
                    }
                    if let pilotSlots = pilotDictionary["slots"] as? [String] {
                        slots += pilotSlots
                    }
                    let abilityText = pilotDictionary["text"] as? String ?? ""
                    let unique = pilotDictionary["unique"] as? Bool ?? false
                    let pilotEntity = NSManagedObject(entity: Pilots.entity(), insertInto: managedContext) as! Pilots
                    let Ships = ShipCD.getShip(withName: shipName)
                    pilotEntity.setValue(shipName, forKey: "shipName")
                    pilotEntity.setValue(Ships, forKey: "Ships")
                    pilotEntity.setValue(pilotName, forKey: "name")
                    pilotEntity.setValue(pilotId, forKey: "id")
                    pilotEntity.setValue(pilotSkill, forKey: "pilotSkill")
                    pilotEntity.setValue(abilityText, forKey: "abilityText")
                    pilotEntity.setValue(unique, forKey: "unique")
                    pilotEntity.setValue(squadCost, forKey: "squadCost")
                    pilotEntity.setValue(slots, forKey: "upgradeSlots")
                    pilotEntity.setValue(faction, forKey: "faction")

                   
                    print("________________PILOT_____________")
                    print(pilotEntity.name!)
                    print(pilotEntity.Ship?.name as String!)
                    print(pilotEntity.faction!)
                    do {
                        try managedContext.save()
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                    }
                } else {
                    print("NOT IF LET DICT PILOTS")
                }
            }
        }
    }
    
    class func filterPilots(withFaction: Faction, withShip: String) -> NSFetchedResultsController<Pilots> {
       let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = Pilots.fetchRequest() as NSFetchRequest<Pilots>
        switch withFaction {
        case .rebelAlliance:
            request.predicate = NSPredicate(format: "ANY %K = %@ AND ANY %K = %@ OR ANY %K = %@ AND ANY %K = %@" , "Ships.name", withShip, "faction", Faction.rebelAlliance.rawValue,"Ships.name", withShip, "faction", Faction.resistance.rawValue)
        case .galacticEmpire:
            request.predicate = NSPredicate(format: "ANY %K = %@ AND ANY %K = %@ OR ANY %K = %@ AND ANY %K = %@" , "Ships.name", withShip, "faction", Faction.galacticEmpire.rawValue,"Ships.name", withShip, "faction", Faction.firstOrder.rawValue)
        case .scumAndVillainy:
            request.predicate = NSPredicate(format: "ANY %K = %@ AND ANY %K = %@" , "Ships.name", withShip, "faction", Faction.scumAndVillainy.rawValue)
        default:
            request.predicate = NSPredicate(format: "ANY %K = %@", "Ships.name", withShip)
        }
        let skillSort = NSSortDescriptor(key: #keyPath(Pilots.pilotSkill), ascending: false, selector: nil)
        request.sortDescriptors = [skillSort]
        var pilotsFRC = NSFetchedResultsController<Pilots>()
        do {
            pilotsFRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
            try pilotsFRC.performFetch()
        } catch let error as NSError {
            print("filterPilots error \(error), \(error.userInfo)")
        }
 
        return NSFetchedResultsController<Pilots>()
    }
    
 } */

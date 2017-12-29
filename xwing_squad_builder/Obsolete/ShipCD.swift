//
//  ShipsCD.swift
//  x-wing_squad_builder
//
//  Created by Alexander on 13/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import Foundation
import CoreData
import UIKit

/* class ShipCD {
    
    class func initShips() {
        // TODO: Check if entity exists -> update values as needed
        
        let filePath = Bundle.main.path(forResource: "ships", ofType:"json")
        let data = try! Data(contentsOf: URL(fileURLWithPath:filePath!), options: .uncached)
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
        
        if let array = json as? [Any] {
            for ship in array {
                if let shipDictionary = ship as? [String: Any] {
                    guard let name = shipDictionary["name"] as? String, let shipId = shipDictionary["id"] as? Int32, let xws = shipDictionary["xws"] as? String else {
                        return
                    }
                    let shipEntity = NSManagedObject(entity: Ships.entity(), insertInto: managedContext) as! Ship
                    shipEntity.setValue(name, forKeyPath: "name")
                    shipEntity.setValue(shipId, forKey: "id")
                    shipEntity.setValue(xws, forKey: "xws")
                    
                    do {
                        try managedContext.save()
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                    }
                }
            }
        }
    }
    
    class func getShip(withName: String) -> Ships {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Ships")
        fetchRequest.predicate = NSPredicate(format: "name = %@", withName)
        var shipEntity: [Ships]!
        do {
            shipEntity = try managedContext.fetch(fetchRequest) as! [Ships]
        } catch {
            fatalError("Failed to fetch faction: \(error)")
        }
        return shipEntity[0]
    }
    
    class func filterShips(withFaction: Faction) -> NSFetchedResultsController<Ships> {
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = Ships.fetchRequest() as NSFetchRequest<Ships>
        if withFaction == Faction.galacticEmpire {
            request.predicate = NSPredicate(format: "ANY %K = %@ OR ANY %K = %@", "pilot.faction", Faction.galacticEmpire.rawValue, "pilot.faction", Faction.firstOrder.rawValue)
        } else if withFaction == Faction.rebelAlliance {
            request.predicate = NSPredicate(format: "ANY %K = %@ OR ANY %K = %@", "pilot.faction", Faction.rebelAlliance.rawValue, "pilot.faction", Faction.resistance.rawValue)
        } else if withFaction == Faction.scumAndVillainy {
            request.predicate = NSPredicate(format: "ANY %K = %@", "pilot.faction", Faction.scumAndVillainy.rawValue)
        }
        print("FACTION RAW VALUE :__:_:_:_: _:_:")
        print(withFaction.rawValue)
        let nameSort = NSSortDescriptor(key: #keyPath(Ship.name), ascending: true, selector: #selector(NSString.caseInsensitiveCompare(_:)))
        request.sortDescriptors = [nameSort]
        var shipsFRC = NSFetchedResultsController<Ships>()
        do {
            shipsFRC = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedContext, sectionNameKeyPath: nil, cacheName: nil)
            try shipsFRC.performFetch()
        } catch let error as NSError {
            print("filterShips error \(error), \(error.userInfo)")
        }
        return shipsFRC
    }
    
    
    
    
} */

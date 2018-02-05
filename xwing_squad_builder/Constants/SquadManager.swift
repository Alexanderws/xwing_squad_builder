//
//  SquadManager.swift
//  xwing_squad_builder
//
//  Created by Alexander on 11/01/2018.
//  Copyright © 2018 Alexander. All rights reserved.
//

import Foundation

class SquadsManager: Codable {
    
    static let squadsDataPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Squads")
    
    class func loadSquads() -> [Squad] {
        if let squadsData = try? Data(contentsOf: squadsDataPath!) {
            let decoder = JSONDecoder()
            do {
                let squads = try decoder.decode([Squad].self, from: squadsData)
                return squads
            } catch {
                print("Error decoding squads, \(error)")
            }
        }
        return [Squad]()
    }
    
    class func save(squads: [Squad]) {
        let encoder = JSONEncoder()
        do {
            let squadsData = try encoder.encode(squads)
            try squadsData.write(to: squadsDataPath!)
        } catch {
            print("Error encoding squads, \(error)")
        }
    }
    
}

//
//  Ship.swift
//  xwing_squad_builder
//
//  Created by Alexander on 27/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import Foundation
import RealmSwift

class Ship: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var id: Int = 0
    @objc dynamic var xws: String = ""
    @objc dynamic var attackValue: Int = 0
    @objc dynamic var agilityValue: Int = 0
    @objc dynamic var hullValue: Int = 0
    @objc dynamic var shieldValue: Int = 0
    @objc dynamic var shipSize: String = ""
    
    let pilots = List<Pilot>()
    let actions = List<String>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(name: String, id: Int, xws: String, attackValue: Int, agilityValue: Int, hullValue: Int, shieldValue: Int, shipSize: String, actions: [String]) {
        self.init()
        self.name = name
        self.id = id
        self.xws = xws
        self.attackValue = attackValue
        self.agilityValue = agilityValue
        self.hullValue = hullValue
        self.shieldValue = shieldValue
        self.shipSize = shipSize
        
        
        for action in actions {
            self.actions.append(action)
        }
    }
    
    
    
}

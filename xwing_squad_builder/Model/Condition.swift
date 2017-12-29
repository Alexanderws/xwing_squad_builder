//
//  Condition.swift
//  xwing_squad_builder
//
//  Created by Alexander on 27/12/2017.
//  Copyright © 2017 Alexander. All rights reserved.
//

import Foundation
import RealmSwift

class Condition: Object {
    
    @objc dynamic var id = -1
    @objc dynamic var name = ""
    @objc dynamic var text = ""
    @objc dynamic var unique  = false
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(id: Int, name: String, text: String, unique: Bool) {
        self.init()
        self.id = id
        self.name = name
        self.text = text
        self.unique = unique
    }
}
